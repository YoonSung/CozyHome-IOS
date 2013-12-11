//
//  RBLoginModel.h
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 4..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBDataModel : NSObject <NSURLConnectionDataDelegate>
- (void)saveID:(NSString*)userid withPassword:(NSString*)password withNickName:(NSString*)nickName;
- (NSString*)loginDataDescription;
+ (RBDataModel*)getInstance;
- (NSUInteger)getListSize;
- (BOOL)isValidLoginID:(NSString*)inputID AndPassword:(NSString*)inputPW;
- (NSDictionary*)getListDataAtIndex:(NSUInteger)index;
- (BOOL)authenticateID:(NSString*)userid withPassword:(NSString*)password;
- (void)getBoardDataFromServer;
@property UITableViewController* tableController;
@end