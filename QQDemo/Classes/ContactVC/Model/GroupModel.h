//
//  GroupModel.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "BaseModel.h"

@interface GroupModel : BaseModel
@property (copy, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSArray *authors;
@property (strong, nonatomic) NSNumber *groupId;
@property (strong, nonatomic) NSNumber *onlineNum;
@property (assign, nonatomic, getter=isDisplay) BOOL display; //分组是否打开

@end
