//
//  RBLoginModel.m
//  CozyHome
//
//  Created by JungYoonSung on 2013. 12. 4..
//  Copyright (c) 2013년 nhnnext. All rights reserved.
//

#import "RBLoginModel.h"
#define LOGIN_ID_KEY @"ID"
#define LOGIN_PW_KEY @"PW"
#define LOGIN_NICKNAME_KEY @"NICK"


@implementation RBLoginModel
{
    NSMutableDictionary* _loginModel;
}

- (id)init
{
    self = [super init];
    if (self) {
        _loginModel = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    return self;
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
