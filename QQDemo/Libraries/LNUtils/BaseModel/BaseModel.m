//
//  BaseModel.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "BaseModel.h"
#import "YYModel.h"

@implementation BaseModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

@end
