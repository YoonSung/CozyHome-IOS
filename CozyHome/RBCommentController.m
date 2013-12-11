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
    _contents = [[_model getListDataAtIndex:_index] objectForKey:@"comments"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary* comment = _contents[indexPath.row];
    
    cell.textLabel.text = [comment objectForKey:@"comment"];
    
    return cell;
}

@end
