//
//  RBListViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 11. 27..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "RBListViewController.h"
#import "RBCommentController.h"
#import "RBDataModel.h"
#import "RBTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RBWriteViewController.h"

@interface RBListViewController ()

@end

@implementation RBListViewController
{
    RBDataModel* _model;
    NSInteger index;
    RBTableViewCell *cell;
    NSDictionary* item;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _model = [RBDataModel getInstance];
    _model.tableController = self;
    //[_model getBoardDataFromServer];
    //NSLog(@"viewDidLoad in RBListViewController");
    
    
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(newImage:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

//sender는 호출한 객체가 들어있다.
- (void)newImage:(id)sender
{
    UIImagePickerController *picker
    = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self.navigationController
     presentViewController:picker animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge id)kUTTypeImage])
    {
        UIImage* aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
       
        //editor 소스추가 부분
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:aImage];
        editor.delegate = self;
        [picker pushViewController:editor animated:YES];
        //editor 소스추가 부분 끝
    }
    //이미지 골랐을때 자동으로 뷰 닫기. 여기도 {} 안에 액션을 구현하면 뷰가 닫힌후 {}안에 영역이 실행된다.
//    [picker dismissViewControllerAnimated:YES completion:^{
//        UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"이미지" message:@"골랐어요" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//        alertView1.alertViewStyle = UIAlertViewStyleDefault;
//        [alertView1 show];
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}]; //^{}는 콜백함수. ananimous함수로 뷰가 끝난뒤 실행할 부분을 구현한다.
}

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    RBWriteViewController* writeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"writeView"];
    [writeVC prepareData:image];
    [editor dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController pushViewController:writeVC animated:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:YES];
    NSLog(@"in willAppear");
    [self.navigationController setNavigationBarHidden:NO];
    [_model getBoardDataFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"length : %d",[_model getListSize]);
    return [_model getListSize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath Execute");
    
    item = [_model getListDataAtIndex:indexPath.row];
    
    //UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    //    cell.textLabel.text = [item objectForKey:@"title"];
    //    cell.detailTextLabel.text = [item objectForKey:@"content"];
    //    cell.imageView.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell"];
    

    //local
    //cell.cellImage.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    
    
    //External api, download from http://bit.ly/1jKQJ90
    //[cell.cellImage setImageWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/static/images/psychobox.png"]];
    
    //local, exter common code
    //cell.cellTitle.text = [item objectForKey:@"title"];
    //cell.cellContent.text = [item objectForKey:@"content"];
    
    
    cell.cellTitle.text = [item objectForKey:@"title"];
    cell.cellContent.text = [item objectForKey:@"contents"];
    
    NSArray* comments = [item objectForKey:@"comments"];
    NSInteger commentsNum = [comments count];
    
    if ( commentsNum == 0 )
    {
        cell.cellCommentNum.text = @"";
    } else {
        cell.cellCommentNum.text = [NSString stringWithFormat:@"댓글 : %d 개", commentsNum];
    }
    
    NSString* imgUrl = [item objectForKey:@"fileName"];
    
    if ( [imgUrl class] != [NSNull class] )
    {
        NSString* loadURL = @"http://localhost:3080/images/";
        loadURL = [loadURL stringByAppendingString:imgUrl];
        
        [cell.cellImage setImageWithURL:[NSURL URLWithString:loadURL]];
        NSLog(@"imgURL = %@", imgUrl);
        NSLog(@"loadURL = %@", loadURL);
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* comments = [item objectForKey:@"comments"];
    NSInteger commentsNum = [comments count];
    
    if ( commentsNum == 0 ) {
        NSLog(@"댓글이 없어서 다음으로 안넘어가요ㅎ");
    } else {
        index = indexPath.row;
        //http://stackoverflow.com/questions/9176215/understanding-performseguewithidentifier
        [self performSegueWithIdentifier:@"Comments" sender:indexPath];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RBCommentController* targetController = segue.destinationViewController;
    targetController.index = index;
}

@end
