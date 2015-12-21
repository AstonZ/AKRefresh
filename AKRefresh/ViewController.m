//
//  ViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/10.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "ViewController.h"
#import "AKRefreshControl.h"
#import "AKBaseViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary  <NSString *, NSArray *> *dataSource;
 @end

@implementation ViewController


- (NSDictionary *)dataSource
{
    if (_dataSource == nil) {
        
        NSArray *VCs = @[
                         @"AKShimmerViewController",
                         @"AKRotationRectViewController",
                         @"AKScalPointViewController",
                         @"AKStaticHeaderViewController"
                         ];
        _dataSource = @{
                        @"Without Extention View":VCs,
                        @"With Extention View":VCs
                        };
    }
    return _dataSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"AKRefreshControl";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}




#pragma mark -
#pragma mark ---------UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource.allKeys[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource[self.dataSource.allKeys[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[self.dataSource.allKeys[indexPath.section]][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *secKey = self.dataSource.allKeys[indexPath.section];
    NSString *className = self.dataSource[secKey][indexPath.row];
    AKBaseViewController *VC = [[NSClassFromString(className) alloc] init];
    VC.hasExtView = ![secKey hasPrefix:@"Without"];
        if (VC == nil) {
        return;
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
