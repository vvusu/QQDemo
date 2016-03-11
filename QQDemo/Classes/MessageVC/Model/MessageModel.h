//
//  MessageModel.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *avatarURL;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) NSNumber *messageNum;

@end
