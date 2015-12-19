//
//  AKBaseViewController.h
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKRefreshControl.h"

@interface AKBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSource;
/** If there is a extetionView above refreshing View **/
@property (nonatomic, assign) BOOL hasExtView;


- (void)actionRefresh;

@end
