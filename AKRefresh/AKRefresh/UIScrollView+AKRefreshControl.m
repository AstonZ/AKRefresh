//
//  UIScrollView+AKRefreshControl.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/17.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "UIScrollView+AKRefreshControl.h"
#import <objc/runtime.h>

@implementation UIScrollView (AKRefreshControl)
static const char kAKRefreshControlHeaderKey;

- (void)setRefreshHeader:(AKRefreshHeaderView *)refreshHeader
{
    objc_setAssociatedObject(self, &kAKRefreshControlHeaderKey, refreshHeader, OBJC_ASSOCIATION_ASSIGN);
}

- (AKRefreshHeaderView *)refreshHeader
{
 return    objc_getAssociatedObject(self, &kAKRefreshControlHeaderKey);
}



@end
