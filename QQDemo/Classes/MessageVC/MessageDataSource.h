//
//  MessageDataSource.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODRefreshControl;
typedef NS_ENUM(NSInteger, CellClickType) {
    CellClickTypeFriend,
    CellClickTypeGroup,
    CellClickTypeAD,
    CellClickTypeHiddenKeboard
};

@interface MessageDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UITabBarItem *tabbarItem;
@property (nonatomic, strong) ODRefreshControl *refreshcontrol;
@property (nonatomic, copy) void(^CellDidSelectedBlock)(CellClickType type, id entity);

- (void)loadTestData;
@end
