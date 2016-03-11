//
//  LNNetworking.h
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNNetworkAPI.h"
#import "LNRequest.h"
#import "LNResponse.h"

/*
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 *  @param totalBytesExpectedToRead  还有多少需要下载
 */
typedef void (^LNDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);
typedef LNDownloadProgress LNGetProgress;
typedef LNDownloadProgress LNPostProgress;
/*
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^LNUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);

@class NSURLSessionTask;

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask LNURLSessionTask;

/*
 *
 *  请求成功的回调
 *
 *  @param response 服务端返回的数据类型，通常是字典
 */
typedef void(^LNResponseSuccess)(id response);

/*
 *
 *  网络响应失败时的回调
 *
 *  @param error 错误信息
 */
typedef void(^LNResponseFail)(NSError *error);

/**
 *  基于AFNetworking的网络层封装类.
 *
 *  @note 这里只提供公共api
 */
@class LNRequest,LNResponse;
@interface LNNetworking : NSObject

/*
 *  GET请求接口
 *
 *  @param LNRequest  请求参数
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (LNURLSessionTask *)getWithRequest:(LNRequest *)request
                             success:(LNResponseSuccess)success
                                fail:(LNResponseFail)fail;


+ (LNURLSessionTask *)getWithRequest:(LNRequest *)request
                            progress:(LNGetProgress)progress
                             success:(LNResponseSuccess)success
                                fail:(LNResponseFail)fail;

/**
 *  POST请求接口
 *
 *  @param request request 请求参数
 *  @param success success 接口成功请求到数据的回调
 *  @param fail    fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (LNURLSessionTask *)postWithRequest:(LNRequest *)request
                              success:(LNResponseSuccess)success
                                 fail:(LNResponseFail)fail;
/**
 *  POST 请求
 *
 *  @param request  请求参数
 *  @param progress 下载进度
 *  @param success  接口成功请求到数据的回调
 *  @param fail     接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (LNURLSessionTask *)postWithRequest:(LNRequest *)request
                             progress:(LNPostProgress)progress
                              success:(LNResponseSuccess)success
                                 fail:(LNResponseFail)fail;

/**
 *  上传图片
 *
 *  @param request     请求参数
 *  @param progress    上传进度
 *  @param success
 *  @param fail
 *
 *  @return
 */
+ (LNURLSessionTask *)uploadImageWithRequest:(LNRequest *)request
                                    progress:(LNUploadProgress)progress
                                     success:(LNResponseSuccess)success
                                        fail:(LNResponseFail)fail;

/**
 *  上传文件
 *
 *  @param request  请求参数
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return LNURLSessionTask
 */
+ (LNURLSessionTask *)uploadFileWithRequest:(LNRequest *)request
                                   progress:(LNUploadProgress)progress
                                    success:(LNResponseSuccess)success
                                       fail:(LNResponseFail)fail;

/**
 *  下载文件
 *
 *  @param request  请求参数
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return return value description
 */
+ (LNURLSessionTask *)downloadWithRequest:(LNRequest *)request
                                 progress:(LNDownloadProgress)progress
                                  success:(LNResponseSuccess)success
                                  failure:(LNResponseFail)failure;

@end
