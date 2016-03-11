//
//  LNNetworking.m
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import "LNNetworking.h"
#import "LNRequest.h"
#import "LNResponse.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "LNEncrypt.h"

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define LNNetLog(s, ... ) NSLog( @"[%@：in line: %d]-->%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define LNNetLog(s, ... )
#endif

@implementation LNNetworking

#pragma mark - Get
+ (LNURLSessionTask *)getWithRequest:(LNRequest *)request
                             success:(LNResponseSuccess)success
                                fail:(LNResponseFail)fail {

    request.requestMethod = LNRequestMethodGet;
    return [self requestWithRequest:request
                           progress:nil
                            success:success
                               fail:fail];
}

+ (LNURLSessionTask *)getWithRequest:(LNRequest *)request
                            progress:(LNGetProgress)progress
                             success:(LNResponseSuccess)success
                                fail:(LNResponseFail)fail {
    
    request.requestMethod = LNRequestMethodGet;
    return [self requestWithRequest:request
                           progress:progress
                            success:success
                               fail:fail];
}

#pragma mark - Post
+ (LNURLSessionTask *)postWithRequest:(LNRequest *)request
                              success:(LNResponseSuccess)success
                                 fail:(LNResponseFail)fail {
    
    request.requestMethod = LNRequestMethodPost;
    return [self requestWithRequest:request
                           progress:nil
                            success:success
                               fail:fail];
}

+ (LNURLSessionTask *)postWithRequest:(LNRequest *)request
                             progress:(LNPostProgress)progress
                              success:(LNResponseSuccess)success
                                 fail:(LNResponseFail)fail {
    
    request.requestMethod = LNRequestMethodPost;
    return [self requestWithRequest:request
                           progress:progress
                            success:success
                               fail:fail];

}

#pragma mark - Upload
+ (LNURLSessionTask *)uploadImageWithRequest:(LNRequest *)request
                                    progress:(LNUploadProgress)progress
                                     success:(LNResponseSuccess)success
                                        fail:(LNResponseFail)fail {
    request.requestMethod = LNRequestMethodPost;
    AFHTTPSessionManager *manager = [self manager:request];
    LNURLSessionTask *session = [manager POST:request.url parameters:request.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = [NSData dataWithContentsOfFile:request.filePath];
        NSString *imageFileName = request.filePath.lastPathComponent;
        NSString *name = [imageFileName substringToIndex:imageFileName.length - ([imageFileName pathExtension].length + 1)];
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:request.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callback:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    return session;
}

+ (LNURLSessionTask *)uploadFileWithRequest:(LNRequest *)request
                                   progress:(LNUploadProgress)progress
                                    success:(LNResponseSuccess)success
                                       fail:(LNResponseFail)fail {
    if ([NSURL URLWithString:request.url] == nil) {
        LNNetLog(@"uploadingFile无效，无法生成URL。请检查待上传文件是否存在");
        return nil;
    }
    
    AFHTTPSessionManager *manager = [self manager:request];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    LNURLSessionTask *session = [manager uploadTaskWithRequest:urlRequest fromFile:[NSURL URLWithString:request.filePath] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self successResponse:responseObject callback:success];
        if (error) {
            if (fail) {
                fail(error);
            }
        } else {
            [self successResponse:responseObject callback:success];
        }
    }];
    return session;
}

#pragma mark - Download
+ (LNURLSessionTask *)downloadWithRequest:(LNRequest *)request
                                 progress:(LNDownloadProgress)progress
                                  success:(LNResponseSuccess)success
                                  failure:(LNResponseFail)failure {
    if (request.url == nil) {
        LNNetLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
        return nil;
    }
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    AFHTTPSessionManager *manager = [self manager:request];
    LNURLSessionTask *session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:request.saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (success) {
            success(filePath.absoluteString);
        }
    }];
    return session;
}

#pragma mark - Privite
+ (LNURLSessionTask *)requestWithRequest:(LNRequest *)request
                                progress:(LNDownloadProgress)progress
                                 success:(LNResponseSuccess)success
                                    fail:(LNResponseFail)fail {
        
    AFHTTPSessionManager *manager = [self manager:request];
    if (!request.url) {
        if ([NSURL URLWithString:request.url] == nil) {
            LNNetLog(@"URLString无效，无法生成URL。可能是URL中有中文，请尝试Encode URL");
            return nil;
        }
    }
    
    LNURLSessionTask *session = nil;
    switch (request.requestMethod) {
        case LNRequestMethodGet: {
            session = [manager GET:request.url parameters:request.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successResponse:responseObject callback:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
            break;
        case LNRequestMethodPost: {
                session = [manager POST:request.url parameters:request.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    if (progress) {
                        progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self successResponse:responseObject callback:success];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (fail) {
                        fail(error);
                    }
                }];
        }
            break;
        default:
            break;
    }
    return session;
}

//成功的block
+ (void)successResponse:(id)responseData callback:(LNResponseSuccess)success {
    
    //解析返回的数据
    if (success) {
        success([self tryToParseData:responseData]);
    }
}

+ (id)tryToParseData:(id)responseData {
    LNResponse *reponseModel = [[LNResponse alloc]init];
    reponseModel.isSucceed = NO;
    if (![responseData isKindOfClass:[NSData class]]) {
        reponseModel.isSucceed = YES;
        reponseModel.resultDic = responseData;
    } else {
        reponseModel.errorMsg = @"返回解析数据为NSData格式";
    }
   return reponseModel;
}

//根据服务器返回标准格式来生成对应的 LNResponse
+ (LNResponse *)parserJSON:(NSDictionary *)resultDic with:(LNResponse *)reponseModel{
    reponseModel.resultDic = resultDic;
    NSString *rs = [resultDic valueForKey:@"retcode"];
    if (rs.integerValue == 0) {
        reponseModel.isSucceed = YES;
    } else {
        reponseModel.errorCode = rs;
        reponseModel.errorMsg = [resultDic valueForKey:@"retmsg"];
    }
    return reponseModel;
}

+ (AFHTTPSessionManager *)manager:(LNRequest *)request {
    // 开启转圈圈
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    switch (request.requestDataType) {
        case LNRequestDataTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        }
        case LNRequestDataTypePlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    switch (request.responseDataType) {
        case LNResponseDataTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case LNResponseDataTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case LNResponseDataTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    for (NSString *key in request.httpHeaders.allKeys) {
        if (request.httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:request.httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    return manager;
}

@end
