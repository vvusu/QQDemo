//
//  AuthorModel.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "BaseModel.h"

@interface AuthorModel : BaseModel
@property (copy, nonatomic) NSString *followStatus;
@property (copy, nonatomic) NSString *authorId;
@property (copy, nonatomic) NSString *subscriptionNum;
@property (copy, nonatomic) NSString *intro;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avatar;
@end
