//
//  AKHeightLabelExtView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/11.
//  Copyright © 2015年 Aston. All rights reserved.
//


#import "AKHeightLabelExtView.h"
#import "AKRefreshControlProtocoals.h"



@interface AKHeightLabelExtView ()

@property (nonatomic, strong) NSArray <UILabel *> *subLabels;

@end

@implementation AKHeightLabelExtView

- (instancetype)init
{
    if (self = [super init]) {
         NSLog(@"Warning:  please use initWithFrame otherwize I cannot culculate the Height !");
        [self setUP];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}

- (void)setUP
{
    
    CGFloat lbHeight= 40.f;
    CGFloat lbWid = 200.f;
    
    CGFloat superMidX = CGRectGetMidX(self.frame);
    if (superMidX <= 1) {
        superMidX = CGRectGetWidth([UIScreen mainScreen].bounds) /2.0;
    }
    
    CGFloat superMaxY = CGRectGetMaxY(self.frame);
    if (superMaxY <= 1) {
        superMaxY =CGRectGetHeight(self.bounds) ;
    }
    
    CGFloat ox = superMidX - lbWid/2 ;
    CGFloat oy = superMaxY - lbHeight/2;
    
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    
    NSMutableArray *temArr = [NSMutableArray array];
    for (int i= selfHeight/100; i>=0; i--) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"This is  %d m High ",i*100];
        label.tag = i;
        CGRect frame =CGRectMake(ox, oy - i*100, lbWid, lbHeight);
        if (i == 0) {
            frame.origin.y -= lbHeight/2;
        }
        else if (i == selfHeight/100){
            frame.origin.y += lbHeight/2;
        }
        
        label.frame = frame;
        [self addSubview:label];
        [temArr addObject:label];
    }
    self.subLabels = [temArr copy];
}

#pragma mark -
#pragma mark ---------AKRefreshExtentionHeaderViewProtocol

- (void)updateUIWithOffsetY:(CGFloat)offsetY isScrollingUP:(BOOL)isScrollingUP isUserDragging:(BOOL)isDragging;
{
    offsetY = ABS(offsetY);
    
    static const CGFloat updateStepper = 100.f;
    
    //To lower the cpu pressure, we do not need to update it too frequently
    if ((int)offsetY %20 !=0) {
        return;
    }
    
    NSInteger indexToUpdate = offsetY/updateStepper;

    for (UILabel *label in self.subLabels) {
        if (indexToUpdate > label.tag) {
            label.textColor = [UIColor cyanColor];
        }else{
            label.textColor = [UIColor blackColor];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
