//
//  RBWriteViewController.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 18..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBWriteViewController.h"
#import "RBDataModel.h"
@interface RBWriteViewController ()

@end

@implementation RBWriteViewController
{
    RBDataModel* uploadModel;
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
    
    _writeTextView.delegate = self;
    _writeImageView.image = _internalImage;
    uploadModel = [RBDataModel getInstance];
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
    
    if ( _writeTextView.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Post Contents is Empty!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
        [alert show];
    } else {
        BOOL result = [uploadModel UploadNewPostTitle:@"테스트제목입니다" WithContent:_writeTextView.text WithImage:_writeImageView.image];
        
        if ( result ) {
            NSLog(@"in result true");
             [self.navigationController popViewControllerAnimated:TRUE];
        } else {
            NSLog(@"in result false");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Save Post Failure. try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKAY", nil];
            [alert show];
        }
        
        //[loginModel authenticateID:self.inputID.text withPassword:self.inputPW.text]
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSLog(@"view did begin edit\n");
    self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    
    CGRect newframe = self.view.frame;
    newframe.origin.y = 0;
    self.view.frame = newframe;
    [UIView commitAnimations];
    
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    NSLog(@"view did begin edit\n");
    self.view.backgroundColor = [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:0.1];
    
    [UIView beginAnimations:@"MyAnimation" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    
    CGRect newframe = self.view.frame;
    newframe.origin.y = -200;
    self.view.frame = newframe;
    [UIView commitAnimations];
    
    return YES;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches begin\n");
    [self.view endEditing:YES];
}

@end
