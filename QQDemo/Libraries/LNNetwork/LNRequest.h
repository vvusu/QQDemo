//
//  LNRequest.h
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , LNRequestMethod) {
    LNRequestMethodGet = 0, //查
    LNRequestMethodPost,    //改
    LNRequestMethodHead,
    LNRequestMethodPut,     //增
    LNRequestMethodDelete,  //删
    LNRequestMethodPatch
};

typedef NS_ENUM(NSUInteger, LNRequestDataType) {
    LNRequestDataTypeJSON = 0,    // JSON 格式
    LNRequestDataTypePlainText    // 普通text/html  默认
};

typedef NS_ENUM(NSUInteger, LNResponseDataType) {
    LNResponseDataTypeJSON = 0,   // 默认
    LNResponseDataTypeXML,        // XML
    LNResponseDataTypeData        // Data
};

typedef NS_ENUM(NSUInteger, LNEncryptType) {
    LNEncryptTypeNone = 0,        // 默认不加密
    LNEncryptTypeAES,             // AES加密
    LNEncryptTypeOther            // 其他加密格式
};

typedef NS_ENUM(NSUInteger, LNBaseUrlType) {
    LNBaseUrlTypeNormal = 0,
    LNBaseUrlTypeEasyPhoto
};

@interface LNRequest : NSObject
//基本接口类型
@property (nonatomic, assign) LNBaseUrlType baseUrlType;
//配置请求加密方式
@property (nonatomic, assign) LNEncryptType encryptType;
//网络请求类型
@property (nonatomic, assign) LNRequestMethod requestMethod;
//配置请求格式，默认为JSON。如果要求传XML或者PLIST
@property (nonatomic, assign) LNRequestDataType requestDataType;
//返回数据格式类型
@property (nonatomic, assign) LNResponseDataType responseDataType;

//整个连接地址
@property (nonatomic, copy) NSString *url;
//在API添加的固定URL地址，这个直接设置，url 会自动拼接，（可自动切换正式和测试服）
@property (nonatomic, copy) NSString *urlType;
//请求数据Data
@property (nonatomic, strong) NSData *bodyData;
//URL是否Encode (URL 里面有中文)
@property (nonatomic, assign) BOOL shouldEncode;
//配置请求头
@property (nonatomic, strong) NSDictionary *httpHeaders;
//请求参数
@property (nonatomic, strong) NSMutableDictionary *parameters;

//上传文件地址
@property (nonatomic, copy) NSString *filePath;
//下载文件路径
@property (nonatomic, copy) NSString *saveToPath;
//图片格式
@property (nonatomic, copy) NSString *mimeType;

@end
