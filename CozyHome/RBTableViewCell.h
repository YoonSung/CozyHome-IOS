//
//  RBTableViewCell.h
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 11..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UILabel *cellCommentNum;
@property (weak, nonatomic) IBOutlet UILabel *cellWriter;


//cellCommentNum;
@end
