//
//  BaseModel.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject<NSCoding, NSCopying>

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)copyWithZone:(NSZone *)zone;
- (NSUInteger)hash;
- (BOOL)isEqual:(id)object;

@end
