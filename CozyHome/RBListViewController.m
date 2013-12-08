//
//  RBListViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 11. 27..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBListViewController.h"
#import "RBDataModel.h"
@interface RBListViewController ()

@end

@implementation RBListViewController
{
    RBDataModel* _model;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _model = [RBDataModel getInstance];
    NSLog(@"viewDidLoad in RBListViewController");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"length : %d",[_model getListSize]);
    return [_model getListSize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath Execute");
    
    NSDictionary* item = [_model getListDataAtIndex:indexPath.row];
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"content"];
    cell.imageView.image = [UIImage imageNamed: [item objectForKey:@"image"]];
    return cell;
}

@end
