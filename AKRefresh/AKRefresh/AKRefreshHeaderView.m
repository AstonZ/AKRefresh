//
//  AKRefreshHeaderView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/10.
//  Copyright © 2015年 Aston. All rights reserved.
//


#import "AKRefreshHeaderView.h"
#import <objc/runtime.h>


CGFloat kAKRefreshControlHead_AnimateViewHeight = 80.f;
CGFloat kAKRefreshControlHead_ExtentionViewHeight = 600.f;

@interface AKRefreshHeaderView ()

@property (nonatomic, strong) UIView <AKRefreshExtentionHeaderViewProtocol> *extentionView;
@property (nonatomic, strong) UIView <AKRefreshAnimateHeaderViewProtocol>* animateView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) CGFloat heightForAnimateView;
@property (nonatomic, assign) CGFloat heightForExtentionView;

@property (nonatomic, copy) RefreshAction blockRefresh;

@end
@implementation AKRefreshHeaderView

- (void)dealloc
{
    _blockRefresh = nil;
    

//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
     NSLog(@"Refresh Header View Gone !!");
}


- (instancetype)initWithScrollView:(UIScrollView *)scrollView
   registerAnimatedHeaderViewClass:(Class <AKRefreshAnimateHeaderViewProtocol>)animatedViewClass
                     refreshAction:(RefreshAction)refreshAction
{
    return [self initWithScrollView:scrollView registerAnimatedHeaderViewClass:animatedViewClass extentionView:nil refreshAction:refreshAction];
}

/** 传入实现代理的class即可 **/
- (instancetype)initWithScrollView:(UIScrollView *)scrollView
   registerAnimatedHeaderViewClass:(Class <AKRefreshAnimateHeaderViewProtocol>)animatedViewClass
                     extentionView:(Class <AKRefreshExtentionHeaderViewProtocol>)extentionViewClass
                     refreshAction:(RefreshAction)refreshAction
{
    if ((self = [self init]) == nil) {
        return self;
    }
  
    self.scrollView = scrollView;
    if (self.scrollView == nil) {
        NSLog(@"AKRefresh Warning !! There is No ScrollView !");
        return nil;
    }
    
    
    if (animatedViewClass == nil ) {
         NSLog(@"AKRefresh Warning !! Unable to init , No Animated Class found !!");
        return nil;
    }
    
    //check if Class confirm to protocol
    Protocol *aniProtocol = NSProtocolFromString(@"AKRefreshAnimateHeaderViewProtocol");
    if (class_conformsToProtocol(animatedViewClass, aniProtocol) == NO ) {
        NSLog(@"AKRefresh Warning !! Unable to init , The animateClass does not confirm to proper Protocol !!");
        return nil;
    }
    
    BOOL hasExtView = extentionViewClass != nil;

    //Two ways to check if a Class has implemented a Class Method
    
    BOOL isAniResponseToHeight;
    BOOL isExtResponseToHeight;
    //1. easier, but you got a warning here.
//    isAniResponseToHeight = [animatedViewClass respondsToSelector:@selector(heightForAnimatingView)];
//    isExtResponseToHeight = [extentionViewClass respondsToSelector:@selector(heightForExtentionView)];
    
    //2. no warning
    Method aniHeightMethod = class_getClassMethod(animatedViewClass, @selector(heightForAnimatingView));
    IMP aniHeightIMP = method_getImplementation(aniHeightMethod);
    isAniResponseToHeight = aniHeightIMP != NULL;
    //If there is a custom height for views, otherwise, use default values
    
    if (isAniResponseToHeight) {
        _heightForAnimateView = [animatedViewClass heightForAnimatingView];
    }else{
        _heightForAnimateView = kAKRefreshControlHead_AnimateViewHeight;
    }
    
    CGRect extFrame  = CGRectMake(0, 0, CGRectGetWidth(scrollView.bounds), 0);
    if (hasExtView) {
        
        Protocol *extProtocol = NSProtocolFromString(@"AKRefreshExtentionHeaderViewProtocol");
        if (class_conformsToProtocol(extentionViewClass, extProtocol) == NO ) {
            NSLog(@"AKRefresh Warning !! Unable to init , The extView does not confirm to proper Protocol !!");
            return nil;
        }
        
        Method extHeightMethod = class_getClassMethod(extentionViewClass, @selector(heightForExtentionView));
        IMP extHeightIMP = method_getImplementation(extHeightMethod);
        isExtResponseToHeight = extHeightIMP != NULL;
        if (isExtResponseToHeight) {
            _heightForExtentionView = [extentionViewClass heightForExtentionView];
        }else {
            _heightForExtentionView = kAKRefreshControlHead_ExtentionViewHeight;
        }
        //Frames for each views
        extFrame.size.height = _heightForExtentionView;
        self.extentionView = [[extentionViewClass alloc] initWithFrame:extFrame];
        [self addSubview:self.extentionView];

    }else{
        _heightForExtentionView = 0.0f;
    }
  
    CGRect aniFrame = extFrame;
    aniFrame.origin .y = _heightForExtentionView;
    aniFrame.size.height = _heightForAnimateView;
    
    CGRect viewFrame = extFrame;
    viewFrame.size.height += _heightForAnimateView;
    viewFrame.origin.y = -_heightForAnimateView - _heightForExtentionView;
    
    self.frame = viewFrame;
    
    
    self.animateView = [[animatedViewClass alloc] initWithFrame:aniFrame];

    [self addSubview:self.animateView];
    
    _blockRefresh = [refreshAction copy];
    
    [scrollView addSubview:self];
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    
    return self;
    
    
}



/** 开始加载 **/
- (void)startRefreshing
{
    if (_isRefreshing) {
        if (self.scrollView.contentInset.top < _heightForAnimateView) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.scrollView setContentInset:UIEdgeInsetsMake(_heightForAnimateView, 0, 0, 0)];
            }];
        }
        return;
    };
    self.isRefreshing = YES;
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentInset:UIEdgeInsetsMake(_heightForAnimateView, 0, 0, 0)];
    } completion:^(BOOL finished) {
        [self.animateView startAnimation];
        if (_blockRefresh) {
            _blockRefresh(self);
        }
    }];
}

/** 结束加载 **/
- (void)endRefreshingAnimated:(BOOL)animated
{
    if (_isRefreshing == NO) return;
    
    self.isRefreshing = NO;
    [self.animateView stopAnimationCompletion:^{
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView setContentInset:UIEdgeInsetsZero];
            }];
        }else{
            [self.scrollView setContentInset:UIEdgeInsetsZero];
        }
    }];

}




//默认有动画
- (void)endRefreshing
{
    [self endRefreshingAnimated:YES];
}


#pragma mark -
#pragma mark ---------KVO
static CGFloat _lastOffSetY = 0;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    CGFloat offsetY =  self.scrollView.contentOffset.y;

    
    //if is scrolling UP
    BOOL isMovingUP = NO;
    if (_lastOffSetY < offsetY) {
        isMovingUP = YES;
    }else if (_lastOffSetY > offsetY){
        isMovingUP = NO;
    }
    
    if ([self.animateView respondsToSelector:@selector(setScrollOffsetY:isScrollingUP:isUserDragging:)]) {
        [self.animateView setScrollOffsetY:offsetY isScrollingUP:isMovingUP isUserDragging:self.scrollView.isDragging];
    }
    if ([self.extentionView respondsToSelector:@selector(updateUIWithOffsetY:isScrollingUP:isUserDragging:)]) {
        [self.extentionView updateUIWithOffsetY:offsetY isScrollingUP:isMovingUP isUserDragging:self.scrollView.isDragging];
    }
    if (ABS(offsetY) + 20 >= self.heightForAnimateView && self.scrollView.isDragging == NO &&self.scrollView.decelerating==YES) {
        [self startRefreshing];
    
    }
    
}

#pragma mark -
#pragma mark ---------Getters


#pragma mark -
#pragma mark ---------DataForTesting
+ (NSMutableArray <NSString *>*)randomData
{
    NSMutableArray *temArr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [temArr addObject:[NSString stringWithFormat:@"Random Row: %i", arc4random()%300]];
    }
    return temArr;
}


@end
