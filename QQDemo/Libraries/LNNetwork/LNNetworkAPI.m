//
//  LNNetworkAPI.m
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import "LNNetworkAPI.h"

@implementation LNNetworkAPI
#pragma mark - 基本接口
NSString *const kIBaseApi = @"http://f.wallstcn.com";        //正式服务器接口
NSString *const kIBaseTestApi = @"http://192.168.11.11:8080";       //测试服务器接口


#pragma mark - get请求
//测试接口
NSString *const kIGetGroupInfo = @"/news.json?";

@end
