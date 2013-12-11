//
//  RBListViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 11. 27..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBListViewController.h"
#import "RBCommentController.h"
#import "RBDataModel.h"
#import "RBTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RBListViewController ()

@end

@implementation RBListViewController
{
    RBDataModel* _model;
    NSInteger index;
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
    [_model getBoardDataFromServer];
    //NSLog(@"viewDidLoad in RBListViewController");
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
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
    
    NSDictionary* item = [_model getListDataAtIndex:indexPath.row];
    
    //UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    //    cell.textLabel.text = [item objectForKey:@"title"];
    //    cell.detailTextLabel.text = [item objectForKey:@"content"];
    //    cell.imageView.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    
    RBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicCell"];
    

    //local
    //cell.cellImage.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    
    
    //External api, download from http://bit.ly/1jKQJ90
    //[cell.cellImage setImageWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/static/images/psychobox.png"]];
    
    //local, exter common code
    //cell.cellTitle.text = [item objectForKey:@"title"];
    //cell.cellContent.text = [item objectForKey:@"content"];
    
    
    cell.cellTitle.text = [item objectForKey:@"title"];
    cell.cellContent.text = [item objectForKey:@"content"];
    [cell.cellImage setImageWithURL:[NSURL URLWithString:[item objectForKey:@"image"]]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    index = indexPath.row;
    //http://stackoverflow.com/questions/9176215/understanding-performseguewithidentifier
    [self performSegueWithIdentifier:@"Comments" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RBCommentController* targetController = segue.destinationViewController;
    targetController.index = index;
}

@end
