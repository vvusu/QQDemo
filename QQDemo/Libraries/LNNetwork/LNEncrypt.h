//
//  LNEncrypt.h
//  AtourLife
//
//  Created by vvusu on 2/29/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNEncrypt : NSObject

+ (NSData *)aesKey;

+ (NSData *)ivKey;

+ (NSString *)encryption:(id)item;

+ (NSString *)decryptionWithString:(NSString *)encrypString;

+ (NSString *)decryptionWithData:(NSData *)encrypData;

@end
