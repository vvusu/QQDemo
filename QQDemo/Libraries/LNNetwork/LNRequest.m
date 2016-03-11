//
//  LNRequest.m
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import "LNRequest.h"
#import "LNNetworkAPI.h"

@implementation LNRequest
#pragma mark - get
- (LNBaseUrlType)baseUrlType {
    if (!_baseUrlType) {
        _baseUrlType = LNBaseUrlTypeNormal;
    }
    return _baseUrlType;
}

- (LNRequestMethod)requestMethod {
    if (!_requestMethod) {
        _requestMethod = LNRequestMethodGet;
    }
    return _requestMethod;
}

- (LNEncryptType)encryptType {
    if (!_encryptType) {
        _encryptType = LNEncryptTypeNone;
    }
    return _encryptType;
}

- (LNRequestDataType)requestDataType {
    if (!_requestDataType) {
        _requestDataType = LNRequestDataTypePlainText;
    }
    return _requestDataType;
}

- (LNResponseDataType)responseDataType {
    if (!_responseDataType) {
        _responseDataType = LNResponseDataTypeJSON;
    }
    return _responseDataType;
}

//添加通用参数
- (NSMutableDictionary *)parameters {
    if (!_parameters) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}

#pragma mark - set
- (void)setUrlType:(NSString *)urlType {
    if (_url.length == 0) {
        switch (self.baseUrlType) {
            case LNBaseUrlTypeNormal:
                _url = [NSString stringWithFormat:@"%@%@",kIBaseApi,urlType];
                break;
            case LNBaseUrlTypeEasyPhoto:
                break;
        }
    }
    _urlType = urlType;
}

- (void)setShouldEncode:(BOOL)shouldEncode {
    if (_url.length != 0) {
        [self URLEncode:_url];
    }
    _shouldEncode = shouldEncode;
}

#pragma mark - other
- (NSString *)URLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return url;
}

@end
