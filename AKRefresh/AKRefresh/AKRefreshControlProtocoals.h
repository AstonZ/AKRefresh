//
//  AKRefreshControlProtocoals.h
//  AKRefresh
//
//  Created by Aston Z on 15/12/17.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark ---------Protocol for AnimationView

/** Protocals for animation View **/
@protocol AKRefreshAnimateHeaderViewProtocol <NSObject>

@required

+ (instancetype)alloc;

/** Name tells **/
- (void)startAnimation;
- (void)stopAnimationCompletion:(void(^)(void))completion;

@optional

/** VisibleHeight for AnimatingView when Refreshing  Default Value is 80.f**/
+ (CGFloat)heightForAnimatingView;


@optional
/**Customize UI When Scrolling **/
- (void)setScrollOffsetY:(CGFloat)scrollOffsetY isScrollingUP:(BOOL)isScrollingUP isUserDragging:(BOOL)isDragging;
@end


#pragma mark -
#pragma mark ---------Protocoal for ExtentionView

/** If user pull the scrollView very hard, we show them this view **/
@protocol  AKRefreshExtentionHeaderViewProtocol <NSObject>

+ (instancetype)alloc;

@optional

/** Customize UI When Scrolling **/
- (void)updateUIWithOffsetY:(CGFloat)offsetY isScrollingUP:(BOOL)isScrollingUP  isUserDragging:(BOOL)isDragging;

/** VisibleHeight for AnimatingView when Refreshing  Default Value is 500.f**/
+ (CGFloat)heightForExtentionView;



@end