//
//  AKRefreshHeaderView.h
//  AKRefresh
//
//  Created by Aston Z on 15/12/10.
//  Copyright © 2015年 Aston. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "AKRefreshControlProtocoals.h"

static const NSString *kRefreshHeader_AnimateViewClassName = @"AKShimmerAnimationView";
static const NSString *kRefreshHeader_ExtentionViewClassName = @"AKRefreshExtImageView";


@class AKRefreshHeaderView;

typedef void(^RefreshAction)(AKRefreshHeaderView *headerView);

@interface AKRefreshHeaderView : UIView



#pragma mark -
#pragma mark ---------Init Methods

/* If the Animation View Class and the Extention View Class will Not be changed througout the project, simple init methods are supplied.
 *1. Set value to kRefreshHeader_AnimateViewClassName, and kRefreshHeader_ExtentionViewClassName if Needed
 *2. Use the following two methods instead of long ones.
 */

/** Animate View Only **/
+ (instancetype)refreshHeaderOnlyAnimateViewWithScrollView:(UIScrollView *)scrollView refreshAction:(RefreshAction)refreshAction;

/** Both Animate View and Extention View **/
+ (instancetype)refreshHeaderWithScrollView:(UIScrollView *)scrollView refreshAction:(RefreshAction)refreshAction;


#pragma mark -
#pragma mark ---------Customized Initializations
+ (instancetype)refreshHeaderWithScrollView:(UIScrollView *)scrollView
            registerAnimatedHeaderViewClass:(Class <AKRefreshAnimateHeaderViewProtocol>)animatedViewClass
                              refreshAction:(RefreshAction)refreshAction;

+ (instancetype)refreshHeaderWithScrollView:(UIScrollView *)scrollView
            registerAnimatedHeaderViewClass:(Class <AKRefreshAnimateHeaderViewProtocol>)animatedViewClass
                              extentionView:(Class <AKRefreshExtentionHeaderViewProtocol>)extentionViewClass
                              refreshAction:(RefreshAction)refreshAction;

/* The Value is 80.f by Default , if you need a different value, two ways to change it.
 * 1. If the value you want stays the same troughout the whole project, change  kAKRefreshControlHead_AnimateViewHeight in AKRefreshHeaderView.m.
 * 2. If the value may vary in each animation view, implement the  +heightForAnimatingView in protocal.
 */
@property (nonatomic, readonly) CGFloat heightForAnimateView;

/** Same as above, By default, the value is 600.f, normally hard enough to reach.  **/
@property (nonatomic, readonly) CGFloat heightForExtentionView;


/** As its name says, it will call the refreshBlock immediately  **/
- (void)startRefreshing;


/** By default, end with Animation **/
- (void)endRefreshing;

/** Back to position **/
- (void)endRefreshingAnimated:(BOOL)animated;

#pragma mark -
#pragma mark ---------DataForTesting
+ (NSMutableArray <NSString *>*)randomData;

@end
