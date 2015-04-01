//
//  RBCommentControllerViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 8..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBCommentController.h"
#import "RBDataModel.h"

@interface RBCommentController ()

@end

@implementation RBCommentController
{
    RBDataModel* _model;
    NSArray* _contents;
    UITextField *commentTextField;
    UIButton * commentAddButton;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:false];
    _model = [RBDataModel getInstance];
    _model.commentController = self;
    
    _contents = [[_model getListDataAtIndex:_index] objectForKey:@"comments"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contents count]+1;
}


- (void)uploadComment//:(id)sender
{
    NSLog(@"in uploadCommment!!!!!");
    
    NSString* articleNumber = [[_model getListDataAtIndex:_index] objectForKey:@"id"];
    BOOL result = [_model UploadNewCommentPostNum:articleNumber WithComment:(NSString*)commentTextField.text];
    
    if ( result == true )
        [_model getBoardDataFromServer];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    

    if ( [indexPath row] == [_contents count] ) {
        commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 20, 210, 20)];
        commentTextField.adjustsFontSizeToFitWidth = YES;
        commentTextField.textColor = [UIColor blackColor];
        if ([indexPath row] == 0) {
            commentTextField.placeholder = @"Input First Comment : ";
            commentTextField.keyboardType = UIKeyboardTypeDefault;
        }
        else {
            commentTextField.placeholder = @"Input Comment : ";
            commentTextField.keyboardType = UIKeyboardTypeDefault;
        }
        //playerTextField.backgroundColor = [UIColor grayColor];
        //playerTextField.alpha = 0.3;
        commentTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
        commentTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
        commentTextField.textAlignment = UITextAlignmentLeft;
        commentTextField.tag = 0;
        //playerTextField.delegate = self;
        
        commentTextField.clearButtonMode = UITextFieldViewModeNever; // no clear 'x' button to the right
        [commentTextField setEnabled: YES];
        
        //button add
        commentAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[commentAddButton setFrame:CGRectMake(250, 20, 90, 20)]; //x,y,width, height
		[commentAddButton setTitle:@"ADD" forState:UIControlStateNormal];
		[commentAddButton addTarget:self action:@selector(uploadComment) forControlEvents:UIControlEventTouchUpInside];
		//[editingCell.contentView addSubview:editingCell];

        
        
        
        
        [cell.contentView addSubview:commentAddButton];
        [cell.contentView addSubview:commentTextField];
        
        // [playerTextField release];
    } else {
        NSDictionary* comment = _contents[indexPath.row];
        
        cell.textLabel.text = [comment objectForKey:@"comment"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"[ %@ ]",[comment objectForKey:@"writer"]];
    }
    
    return cell;
}

@end
