//
//  UIScrollView+AKRefreshControl.h
//  AKRefresh
//
//  Created by Aston Z on 15/12/17.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKRefreshHeaderView.h"
@interface UIScrollView (AKRefreshControl)
@property (nonatomic, strong) AKRefreshHeaderView *refreshHeader;
@end
