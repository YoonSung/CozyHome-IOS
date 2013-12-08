//
//  RBLoginModel.h
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 4..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBLoginModel : NSObject
-(void)saveID:(NSString*)userid withPassword:(NSString*)password withNickName:(NSString*)nickName;
- (NSString*)loginDataDescription;
+ (RBLoginModel*)getInstance;

- (BOOL)isValidLoginID:(NSString*)inputID AndPassword:(NSString*)inputPW;
@end
