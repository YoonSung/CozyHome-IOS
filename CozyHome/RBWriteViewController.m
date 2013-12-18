//
//  RBWriteViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 18..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBWriteViewController.h"

@interface RBWriteViewController ()

@end

@implementation RBWriteViewController

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
    
    _writeImageView.image = _internalImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData:(UIImage *)image
{
    _internalImage = image;
}

- (IBAction)onSendClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
