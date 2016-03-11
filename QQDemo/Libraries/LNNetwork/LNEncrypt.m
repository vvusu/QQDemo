//
//  LNEncrypt.m
//  AtourLife
//
//  Created by vvusu on 2/29/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import "LNEncrypt.h"
#import "LNNetworkAPI.h"
#import "FBEncryptorAES.h"

static NSString *AESKey = @"";
static NSString *IVKey = @"";

@implementation LNEncrypt

+ (NSData *)ivKey {
    return [IVKey dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData *)aesKey {
    NSString *key = [AESKey substringToIndex:16];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    return keyData;
}

#pragma mark - 加密
+ (NSString *)encryption:(id)item {
    //对待加密处理
    NSError *error = nil;
    if (![NSJSONSerialization isValidJSONObject:item]) {
        NSLog(@"格式错误无法转成json");
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonSring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *contentData = [jsonSring dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aesData = [FBEncryptorAES encryptData:contentData key:[LNEncrypt aesKey] iv:[LNEncrypt ivKey]];
    NSString *aesString = [aesData base64EncodedStringWithOptions:0];
    return aesString;
}

#pragma mark - 解密
+ (NSString *)decryptionWithString:(NSString *)encrypString {
    NSData *aesData = [[NSData alloc]initWithBase64EncodedString:encrypString options:0];
    return [self decryptionWithData:aesData];
};

+ (NSString *)decryptionWithData:(NSData *)encrypData {
    NSData *jsonData = [FBEncryptorAES decryptData:encrypData key:[LNEncrypt aesKey] iv:[LNEncrypt ivKey]];
    NSString *aesString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return aesString;
}

@end
