//
//  MessageVC.m
//  QQDemo
//
//  Created by vvusu on 3/9/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "MessageVC.h"
#import "MessageDataSource.h"
#import "LNUserCacheManager.h"

@interface MessageVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISegmentedControl *segmentControl;
@property (strong, nonatomic) MessageDataSource *messageDataSource;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = nil;
    self.tabBarController.navigationItem.titleView = self.segmentControl;
}

- (void)setupViews {
    self.tableView.delegate = self.messageDataSource;
    self.tableView.dataSource = self.messageDataSource;
    [self.tableView reloadData];
}

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@" 消息 ",@"电话"]];
        _segmentControl.tintColor = [UIColor whiteColor];
        [_segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.selectedSegmentIndex = 0;
    }
    return _segmentControl;
}

- (void)segmentControlClick:(UISegmentedControl *)segmentControl{
    switch (segmentControl.selectedSegmentIndex) {
        case 0: {
            self.tableView.hidden = NO;
        }
            break;
        case 1: {
            self.tableView.hidden = YES;
        }
    }
}

- (MessageDataSource *)messageDataSource {
    if (!_messageDataSource) {
        _messageDataSource = [[MessageDataSource alloc]init];
        _messageDataSource.tableView = self.tableView;
        [_messageDataSource loadTestData];
//        __weak typeof(self) wSelf = self;
        _messageDataSource.CellDidSelectedBlock = ^(CellClickType clickType,id entity){
            switch (clickType) {
                case CellClickTypeFriend:
                    break;
                case CellClickTypeGroup:
                    break;
                case CellClickTypeAD:
                    break;
            }
        };
    }
    return _messageDataSource;
}

@end
