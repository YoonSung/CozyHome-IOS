//
//  RBWriteViewController.h
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 18..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBWriteViewController : UIViewController<UITextViewDelegate>
{
    UIImage* _internalImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *writeImageView;
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;
- (IBAction)onSendClick:(id)sender;
- (void)prepareData:(UIImage*)image;

@end
