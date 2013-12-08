//
//  RBJoinController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 8..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBJoinController.h"
#import "RBDataModel.h"

@implementation RBJoinController
{
    RBDataModel* loginModel;
}

- (IBAction)pressJoinBtn:(id)sender {
    
    if ( [self.password.text isEqual:self.passwordConfirm.text] ) {
        [loginModel saveID:self.email.text withPassword:self.password.text withNickName:self.nickname.text];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@" Password & PasswordConfirm is not same. Please check." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    loginModel = [RBDataModel getInstance];
    
    
    _email.delegate = self;
    _nickname.delegate = self;
    _password.delegate = self;
    _passwordConfirm.delegate = self;
    
    _email.returnKeyType = UIReturnKeyNext;
    _nickname.returnKeyType = UIReturnKeyNext;
    _password.returnKeyType = UIReturnKeyNext;
    _passwordConfirm.returnKeyType = UIReturnKeyDone;
    
    [_email resignFirstResponder];
    [_nickname resignFirstResponder];
    [_password resignFirstResponder];
    [_passwordConfirm resignFirstResponder];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn call");
    if ( [textField isEqual:_email]) {
        [_nickname becomeFirstResponder];
    } else if ([textField isEqual:_nickname]) {
        [_password becomeFirstResponder];
    } else if ([textField isEqual:_password]) {
        [_passwordConfirm becomeFirstResponder];
    } else if ([textField isEqual:_passwordConfirm]) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
