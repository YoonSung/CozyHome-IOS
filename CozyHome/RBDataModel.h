//
//  RBLoginModel.h
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 4..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBDataModel : NSObject
- (void)saveID:(NSString*)userid withPassword:(NSString*)password withNickName:(NSString*)nickName;
- (NSString*)loginDataDescription;
+ (RBDataModel*)getInstance;
- (NSUInteger)getListSize;
- (BOOL)isValidLoginID:(NSString*)inputID AndPassword:(NSString*)inputPW;
- (NSDictionary*)getListDataAtIndex:(NSUInteger)index;
@end
