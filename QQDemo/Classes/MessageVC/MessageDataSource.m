//
//  MessageDataSource.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "MessageDataSource.h"
#import "MessageCell.h"
#import "ODRefreshControl.h"
#import "LNUserCacheManager.h"
#import "MessageModel.h"
//为了测试
#import "GroupModel.h"
#import "AuthorModel.h"
#import "LNNetworking.h"
#import "NSObject+YYModel.h"

@implementation MessageDataSource

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [self.refreshcontrol endRefreshing];
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(addOneMessage) userInfo:nil repeats:YES];
    }
    return _dataArr;
}

- (ODRefreshControl *)refreshcontrol {
    if (!_refreshcontrol) {
        _refreshcontrol = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [_refreshcontrol addTarget:self action:@selector(refreshcontrolAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshcontrol;
}

- (void)refreshcontrolAction {
    //网络太快为了测试
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self addOneMessage];
        [self.refreshcontrol endRefreshing];
    });
}

- (void)loadTestData {
    NSArray *cacheArr = [LNUserCacheManager cachedQQMessage];
    if (cacheArr.count != 0) {
        [self.dataArr addObjectsFromArray:cacheArr];
    } else {
        [self.refreshcontrol beginRefreshing];
        NSArray *tempArr = [LNUserCacheManager cachedQQGroup];
        if (tempArr.count == 0) {
            [self doHttpRequest];
        } else {
            GroupModel *group = tempArr[arc4random()%tempArr.count];
            for (AuthorModel *tempModel in group.authors) {
                MessageModel *messageModel = [[MessageModel alloc]init];
                messageModel.avatarURL = tempModel.avatar;
                messageModel.nickName = tempModel.nickname;
                messageModel.message = tempModel.intro;
                messageModel.messageNum = [NSNumber numberWithInt:arc4random()%10];
                NSDate *now=[NSDate date];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"HH:mm"];
                NSString * nowString=[dateformatter stringFromDate:now];
                messageModel.time = nowString;
                [self.dataArr addObject:messageModel];
            }
        }
        [LNUserCacheManager cachedQQMessageActivity:self.dataArr];
    }
    [self.tableView reloadData];
    [self.refreshcontrol endRefreshing];
}

//每10秒添加一条数据到Data
- (void)addOneMessage {
    NSArray *tempArr = [LNUserCacheManager cachedQQMessage];
    [self.dataArr insertObject:tempArr[arc4random()%tempArr.count] atIndex:0];
    [self.tableView reloadData];
    [LNUserCacheManager cachedQQMessageActivity:self.dataArr];
}

//请求接口联系人的接口 暂时
- (void)doHttpRequest {
    LNRequest *request = [[LNRequest alloc]init];
    request.urlType = kIGetGroupInfo;
    [LNNetworking getWithRequest:request success:^(LNResponse *response) {
        [self.refreshcontrol endRefreshing];
        if (response.isSucceed) {
            NSArray *groupArr = (NSArray *)response.resultDic;
            NSMutableArray *groupModels = [NSMutableArray array];
            for (NSDictionary *temp in groupArr) {
                GroupModel *groupModel = [GroupModel yy_modelWithDictionary:[temp valueForKey:@"category"]];
                groupModel.authors = [NSArray yy_modelArrayWithClass:[AuthorModel class] json:[temp valueForKey:@"authors"]];
                groupModel.onlineNum = [NSNumber numberWithInteger:groupModel.authors.count];
                [groupModels addObject:groupModel];
            }
            [LNUserCacheManager cachedQQGroupActivity:groupModels];
            [self loadTestData];
        }
    } fail:^(NSError *error) {
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    [cell createWithGroupModel:self.dataArr[indexPath.row] index:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
