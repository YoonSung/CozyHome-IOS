//
//  RBViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 11. 27..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBLoginController.h"
#import "RBLoginModel.h"

@interface RBViewController ()

@end

@implementation RBViewController
{
    RBLoginModel* loginModel;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //for keyboard hidden in login process
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
    //**************
    loginModel = [[RBLoginModel alloc]init];
}

    //for keyboard hidden in login process
- (void)didTap:(UITapGestureRecognizer*)rec
{
    [self.inputID resignFirstResponder];
    [self.inputPW resignFirstResponder];
}
    //**************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //[self performSegueWithIdentifier:@"moveList" sender:self];
}


- (IBAction)pressLoginBtn:(id)sender
{

}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    //NSLog(@"%@",[loginModel loginDataDescription]);
    //NSLog(@"%hhd",[loginModel isValidLoginID:self.inputID.text AndPassword:self.inputPW.text]);
    
    if ( [loginModel isValidLoginID:self.inputID.text AndPassword:self.inputPW.text] )
    {
        return true;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Check Input Data." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
        [alert show];
        return false;
    }

}

- (IBAction)pressJoinBtn:(id)sender {
    [loginModel saveID:self.inputID.text withPassword:self.inputPW.text withNickName:@"GGuydori"];
}
@end
