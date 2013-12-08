//
//  RBLoginModel.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 4..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBDataModel.h"
#define LOGIN_ID_KEY @"ID"
#define LOGIN_PW_KEY @"PW"
#define LOGIN_NICKNAME_KEY @"NICK"


@implementation RBDataModel
{
    NSMutableDictionary* _loginModel;
    NSMutableArray* _listArray;
}
static RBDataModel* sharedInstance;

- (id)init
{
    self = [super init];
    if (self) {
        _loginModel = [[NSMutableDictionary alloc] initWithCapacity:3];
        
        _listArray = [@[
                        @{@"title":@"첫번째", @"content":@"첫번째 글", @"image":@"test1.png",
                          @"comments": @[@"a_comment1",@"a_comment2",@"a_comment3"]},
                        
                        @{@"title":@"두번째", @"content":@"두번째 글" , @"image":@"test2.png",
                          @"comments": @[@"b_comment1",@"b_comment2",@"b_comment3"]},
                        
                        @{@"title":@"마지막", @"content":@"세번째 글" ,  @"image":@"test3.png",
                          @"comments": @[@"c_comment1",@"c_comment2",@"c_comment3"]},
                        ]mutableCopy];
    }
    return self;
}

- (NSDictionary*)getListDataAtIndex:(NSUInteger)index
{
    return _listArray[index];
}

- (NSUInteger)getListSize
{
    return [_listArray count];
}

+ (RBDataModel*)getInstance
{
    if ( sharedInstance == nil )
        sharedInstance = [[super alloc] init];
    return sharedInstance;
}

- (void)saveID:(NSString*)userid withPassword:(NSString*)password withNickName:(NSString*)nickName
{
    [ _loginModel setObject:userid forKey: LOGIN_ID_KEY];
    [ _loginModel setObject:password forKey: LOGIN_PW_KEY];
    [ _loginModel setObject:nickName forKey: LOGIN_NICKNAME_KEY];
}

- (NSString*)loginDataDescription
{
    return [_loginModel description];
}

- (BOOL)isValidLoginID:(NSString*)inputID AndPassword:(NSString*)inputPW
{
    NSString* savedID = [_loginModel objectForKey:LOGIN_ID_KEY];
    NSString* savedPW = [_loginModel objectForKey:LOGIN_PW_KEY];
    NSLog(@"savedID : %@",savedID);
    NSLog(@"savedPW : %@",savedPW);
    
    return ( [savedID isEqualToString:inputID] && [savedPW isEqualToString:inputPW] );
}


@end