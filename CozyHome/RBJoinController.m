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
    
    if ( _email.text.length == 0    ||
         _nickname.text.length == 0 ||
         _password.text.length == 0 ||
         _passwordConfirm.text.length == 0 ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty!" message:@"You Must Fill All of Form" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
        [alert show];
        return;
    }
    
    
    if ( [self.password.text isEqual:self.passwordConfirm.text] ) {
        [loginModel saveID:self.email.text withPassword:self.password.text withNickName:self.nickname.text];  
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Join CozyHome. Congratulation." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Thank You", nil];
//        [alert show];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
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
    
    /*원래 어떠한 controller에 component를 추가할 경우, 
     delegete가 지정되어 있지 않다. 
     
     어떤 component에 액션을 지정해 주는 방법은 두가지인데, 첫번째는 ibaction과 같이 target을 직접 지정해주는 방법과, delegete를 연결해서 이용하는 방법이 있다.*/
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
