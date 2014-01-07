//
//  RBViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 11. 27..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBLoginController.h"
#import "RBDataModel.h"

@interface RBViewController () //원래는 (이름)을 쓰는식으로 했었다ㅎ
//implement {} 와 동일한 기능, objective c의 category라는 인터페이스 재정의 기능이다.
@end

@implementation RBViewController
{
    RBDataModel* loginModel;
    BOOL isKeyboardAppear;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    loginModel = [RBDataModel getInstance];
    
    _inputID.delegate = self;
    _inputPW.delegate = self;
    
    _inputID.returnKeyType = UIReturnKeyNext;
    _inputPW.returnKeyType = UIReturnKeyDone;
    
    [self.navigationController setNavigationBarHidden:true];
    //http://b4you.net/blog/tag/resignFirstResponder
    
    //[_inputID becomeFirstResponder];
    [_inputID resignFirstResponder];
    [_inputPW resignFirstResponder];

}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:true];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    
    CGRect newframe = self.view.frame;
    
    if ( textField == _inputID)
    {
        newframe.origin.y = -120;
    }
    else if ( textField == _inputPW )
    {
        newframe.origin.y = -150;
    }
    self.view.frame = newframe;
    
    //self.view.alpha
    //self.view.backgroundColor = [UIColor whiteColor];
    [UIView commitAnimations];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    CGRect newframe = self.view.frame;
    newframe.origin.y = 0;
    self.view.frame = newframe;
    
    [UIView commitAnimations];
    
    return YES;
}

//-(void) textFieldDidBeginEditing:(UITextField *)textField
//{
//    //http://stackoverflow.com/questions/13345167/how-to-move-view-up-when-click-on-uitextfield-in-customcell-of-uitableview
//    NSLog(@"keyboard appear");
//    
//    if ( isKeyboardAppear == NO ) {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDuration:0.5];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-165.0,
//                                 self.view.frame.size.width, self.view.frame.size.height);
//    }
//}
//
//
//-(void) textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+165.0,
//                                  self.view.frame.size.width, self.view.frame.size.height);
//}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
// ANOTHER SOLUTION TAP ACTION CONTROLLER
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //for keyboard hidden in login process
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
//    [self.view addGestureRecognizer:tap];
//    [self.navigationController setNavigationBarHidden:YES];
//    
//    //**************
//
//}
//
//    //for keyboard hidden in login process
//- (void)didTap:(UITapGestureRecognizer*)rec
//{
//    [self.inputID resignFirstResponder];
//    [self.inputPW resignFirstResponder];
//}
//    //**************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)loginCheck
{
//    NSLog(@"%hhd", [loginModel isValidLoginID:self.inputID.text AndPassword:self.inputPW.text]);
    //if ( [loginModel isValidLoginID:self.inputID.text AndPassword:self.inputPW.text] )
    NSLog(@"login id : %@", self.inputID.text);
    NSLog(@"loing pw : %@", self.inputPW.text);
    
    
    if ( [loginModel authenticateID:self.inputID.text withPassword:self.inputPW.text] )
    {
        return true;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Is not Valid ID&PW. Check Input Data." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
        [alert show];
        return false;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Login"]) {
        if ( self.inputID.text.length == 0 || self.inputPW.text.length == 0) {                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty!" message:@"You did not fill login form" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
            [alert show];
            return false;
        } else {
            return [self loginCheck];
        }
    }
    return true;
}

-(IBAction)returned:(UIStoryboardSegue*)segue
{
    NSLog(@"return Login Page");
}
@end
