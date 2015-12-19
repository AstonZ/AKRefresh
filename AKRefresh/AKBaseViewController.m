//
//  AKBaseViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKBaseViewController.h"

@implementation AKBaseViewController

- (void)dealloc
{
    //TODO: I want to figure out how to stop crashing without the code below...
    [_tableView removeObserver:self.tableView.refreshHeader forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.title = NSStringFromClass([self class]);
    
}


#pragma mark -
#pragma mark ---------RefreshAction

- (void)actionRefresh
{
    __weak typeof(self) wkSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wkSelf.dataSource = [AKRefreshHeaderView randomData];
        [wkSelf.tableView reloadData];
        [wkSelf.tableView.refreshHeader endRefreshing];
    });
}

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSMutableArray<NSString *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [AKRefreshHeaderView randomData];
    }
    return _dataSource;
}



@end
