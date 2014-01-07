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
    NSArray* _listArray;
    NSMutableData* _responseData;
    NSURLConnection* connection;
}
static RBDataModel* sharedInstance;

- (id)init
{
    self = [super init];
    if (self) {
        _loginModel = [[NSMutableDictionary alloc] initWithCapacity:3];
        
//        _listArray = [@[
//                        @{@"title":@"첫번째", @"content":@"첫번째 글", @"image":@"test1.png",
//                          @"comments": @[@"a_comment1",@"a_comment2",@"a_comment3"]},
//                        
//                        @{@"title":@"두번째", @"content":@"두번째 글" , @"image":@"test2.png",
//                          @"comments": @[@"b_comment1",@"b_comment2",@"b_comment3"]},
//                        
//                        @{@"title":@"마지막", @"content":@"세번째 글" ,  @"image":@"test3.png",
//                          @"comments": @[@"c_comment1",@"c_comment2",@"c_comment3"]},
//                        ]mutableCopy];
    }
    return self;
}


- (void)getBoardDataFromServer
{
    _responseData = [[NSMutableData alloc] initWithCapacity:10];
    NSString *aURLString = @"http://localhost:3080/board/list.json";//@"http://1.234.2.8/board.php";
    NSURL* aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest* aRequest = [NSMutableURLRequest requestWithURL:aURL];
    //[aRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    connection = [[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* aError;
    
    NSString *result = [NSString stringWithUTF8String:_responseData.bytes];
    NSLog(@"result data = %@", result);
    NSDictionary* resultDictionary = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&aError];
    
    NSLog(@"result json = %@", resultDictionary);

    NSArray* resultArray = [resultDictionary objectForKey:@"boardAllData"];
    NSLog(@"result json = %@", resultArray);
    _listArray = resultArray;
    [_tableController.tableView reloadData];
    
    NSLog(@"Error : %@",aError);
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
    
    NSLog(@"id : %@", userid);
    NSLog(@"id : %@", password);
    
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


- (BOOL)authenticateID:(NSString*)userid withPassword:(NSString*)password
{
    
    //send
    NSString* urlString = @"http://localhost:3080/login.json";
    NSError* aError;
    NSDictionary* requestData = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 userid, @"ID", password, @"PW", nil];
    NSData* postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&aError];
    
    
    NSURL *aURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest* aRequest = [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:postData];
    //send
    
    
    //response
    NSHTTPURLResponse* aResponse;
    NSData* aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest returningResponse:&aResponse
                           error:&aError];
    
    NSDictionary *dataArray = [NSJSONSerialization
                               JSONObjectWithData:aResultData
                               options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"login response = %d", aResponse.statusCode);
    NSLog(@"login result = %@", dataArray);
    NSLog(@"%@", [dataArray objectForKey:@"result"]);
    
    if ( [[dataArray objectForKey:@"result"] isEqualToString:@"OK" ] ) {
        [self saveID:userid withPassword:password withNickName:[dataArray objectForKey:@"nickname"]];
        return true;
    }
    
    return false;
}

- (BOOL)UploadNewPostTitle:(NSString*)title WithContent:(NSString*)content WithImage:(UIImage*)image
{
    NSURL* url = [NSURL URLWithString:@"http://localhost:3080/board/newPost"];//newPost"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                        cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    [request setHTTPMethod:@"POST"];
    NSString* stringBoundary = @"--*****";
    
    // header value
    NSString* headerBoundary = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    
    // set header
    [request addValue:headerBoundary forHTTPHeaderField:@"Content-Type"];
    
    //add body
    NSMutableData *postBody = [NSMutableData data];
    NSLog(@"body made");
    
    //access token - 미구현
    
    //제목-title
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"title\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[title dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //내용-content
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"contents\"\r\n\r\n"dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //닉네임-nickname
    NSString* nickName = [_loginModel objectForKey:LOGIN_NICKNAME_KEY];
    NSLog(@"nickName : %@\n", nickName);
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Disposition: form-data; name=\"writer\"\r\n\r\n"dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[nickName dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //이미지-image
    NSDate *date = [NSDate date];
    //NSLog(@"Time: %lli", [@(floor([date timeIntervalSince1970])) longLongValue]);
    NSString* fileName = [NSString stringWithFormat:@"%@_%lli.jpg",
                          [_loginModel objectForKey:LOGIN_ID_KEY],
                          [@(floor([date timeIntervalSince1970])) longLongValue]
                          ];
    //lvev9925@naver.com_1366057691.png
    //(id + epoch time).png
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:
                           @"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
   
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    // add it to body
    [postBody appendData:imgData];
    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"message added");
    // final boundary
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add body to post
    [request setHTTPBody:postBody];
    
    
    
    NSLog(@"body set");
    
    
    //response
    NSError* error;
    NSHTTPURLResponse* response;
    NSData* aResultData = [NSURLConnection
                           sendSynchronousRequest:request returningResponse:&response
                           error:&error];
    
    NSDictionary *dataArray = [NSJSONSerialization
                               JSONObjectWithData:aResultData
                               options:NSJSONReadingMutableContainers error:nil];

    
    if (error) {
        //NSLog(@"EROROROROROROR: %@", error);
    }
    NSLog(@"just 3");
    
    
    NSLog(@"upload NewPost response = %d", response.statusCode);
    NSLog(@"upload NewPost result = %@", dataArray);
    NSLog(@"%@", [dataArray objectForKey:@"result"]);

    NSLog(@"done");
    if ( [[dataArray objectForKey:@"result"] isEqualToString:@"OK" ] ) {
        return YES;
    }
    
    return FALSE;
}

@end
