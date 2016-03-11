//
//  LNResponse.h
//  AtourLife
//
//  Created by vvusu on 2/26/16.
//  Copyright © 2016 Anasue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNResponse : NSObject
@property (strong, nonatomic) id resultModel;
@property (assign, nonatomic) BOOL isSucceed;
@property (copy, nonatomic) NSString *errorCode;
@property (copy, nonatomic) NSString *errorMsg;
@property (strong, nonatomic) NSData *resultData;
@property (strong, nonatomic) NSDictionary *resultDic;
@end
