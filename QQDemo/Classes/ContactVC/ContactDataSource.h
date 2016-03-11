//
//  ContactDataSource.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellClickType) {
    CellClickTypeDevice,
    CellClickTypeAddressBook,
    CellClickTypeContact,
    CellClickTypeHiddenKeboard
};

@class ODRefreshControl;
@interface ContactDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ODRefreshControl *refreshcontrol;
@property (nonatomic, copy) void(^CellDidSelectedBlock)(CellClickType type, id entity);

- (void)refreshQQContactWithRequest;
@end

