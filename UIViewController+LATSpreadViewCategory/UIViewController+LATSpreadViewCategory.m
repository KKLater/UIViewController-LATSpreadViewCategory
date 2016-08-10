//
//  UIViewController+LATSpreadViewCategory.m
//  LATNavigationSpreadViewDemo
//
//  Created by Later on 16/8/9.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "UIViewController+LATSpreadViewCategory.h"
#import <objc/runtime.h>

@interface UIViewController ()
@property (assign, nonatomic, readwrite) BOOL isSpreadViewShow;
/**
 *  显示Y
 */
@property (strong, nonatomic) NSNumber * showY;
/**
 *  隐藏的Y
 */
@property (strong, nonatomic) NSNumber * hideY;
/**
 *  动画
 */
@property (assign, nonatomic) BOOL isAnimation;
@end
@implementation UIViewController (LATSpreadViewCategory)
#pragma mark PublicMethod
- (void)showSpreadViewAnimation:(void(^)())animation completed:(void(^)())completed {
    [self.view addSubview:self.spreadBackView];
    if (!self.isAnimation && !self.isSpreadViewShow) {
        self.isAnimation = YES;
        [self.spreadBackView addSubview:self.spreadView];
        self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds), [self.hideY floatValue], CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.spreadBackView.alpha = 1;
            self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds), [self.showY floatValue], CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
            !animation ?: animation();
        } completion:^(BOOL finished) {
            self.isSpreadViewShow = YES;
            self.isAnimation = NO;
            !completed ?: completed();
        }];
    }

    
}
- (void)hideSpreadViewAnimation:(void(^)())animation completed:(void(^)())completed {
    if (!self.isAnimation && self.isSpreadViewShow) {
        self.isAnimation = YES;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.spreadBackView.alpha = 0;
            self.spreadView.frame = CGRectMake(CGRectGetMinX(self.spreadView.bounds),  [self.hideY floatValue], CGRectGetWidth(self.spreadView.bounds), CGRectGetHeight(self.spreadView.bounds));
            !animation ?: animation();
        } completion:^(BOOL finished) {
            self.isSpreadViewShow = NO;
            self.isAnimation = NO;
            [self.spreadBackView removeFromSuperview];
            [self.spreadView removeFromSuperview];
            !completed ?: completed();
        }];
    }

}
#pragma mark Setter/Getter
- (UIView *)spreadView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSpreadView:(UIView *)spreadView {
    UIView *view = objc_getAssociatedObject(self, @selector(spreadView));
    if ([view isEqual:spreadView]) {
        return;
    }
    self.showY = @(CGRectGetMinY(spreadView.frame));
    self.hideY = @(- CGRectGetHeight(spreadView.bounds)-64);

    objc_setAssociatedObject(self, @selector(spreadView), spreadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)spreadBackView {
    UIView *backView = objc_getAssociatedObject(self, _cmd);
    if (!backView) {
        backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        backView.alpha = 0;
        objc_setAssociatedObject(self, _cmd, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backView;
    
}
- (void)setSpreadBackView:(UIView *)spreadBackView {
    objc_setAssociatedObject(self, @selector(spreadBackView), spreadBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSNumber *)showY {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setShowY:(NSNumber *)showY {
    objc_setAssociatedObject(self, @selector(showY), showY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSNumber *)hideY {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHideY:(NSNumber *)hideY {
    objc_setAssociatedObject(self, @selector(hideY), hideY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isSpreadViewShow {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsSpreadViewShow:(BOOL)isSpreadViewShow {
    objc_setAssociatedObject(self, @selector(isSpreadViewShow), @(isSpreadViewShow), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)isAnimation {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsAnimation:(BOOL)isAnimation {
    objc_setAssociatedObject(self, @selector(isAnimation), @(isAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())LATViewControllerSpreadViewShowAnimationBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLATViewControllerSpreadViewShowAnimationBlock:(void (^)())LATViewControllerSpreadViewShowAnimationBlock {
    objc_setAssociatedObject(self, @selector(LATViewControllerSpreadViewShowAnimationBlock), LATViewControllerSpreadViewShowAnimationBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())LATViewControllerSpreadViewShowCompletedBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLATViewControllerSpreadViewShowCompletedBlock:(void (^)())LATViewControllerSpreadViewShowCompletedBlock {
    objc_setAssociatedObject(self, @selector(LATViewControllerSpreadViewShowCompletedBlock), LATViewControllerSpreadViewShowCompletedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())LATViewControllerSpreadViewHideAnimationBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLATViewControllerSpreadViewHideAnimationBlock:(void (^)())LATViewControllerSpreadViewHideAnimationBlock {
    objc_setAssociatedObject(self, @selector(LATViewControllerSpreadViewHideAnimationBlock), LATViewControllerSpreadViewHideAnimationBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())LATViewControllerSpreadViewHideCompletedBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setLATViewControllerSpreadViewHideCompletedBlock:(void (^)())LATViewControllerSpreadViewHideCompletedBlock {
    objc_setAssociatedObject(self, @selector(LATViewControllerSpreadViewHideCompletedBlock), LATViewControllerSpreadViewHideCompletedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)dealloc {
    self.LATViewControllerSpreadViewShowAnimationBlock = nil;
    self.LATViewControllerSpreadViewShowCompletedBlock = nil;
    self.LATViewControllerSpreadViewHideAnimationBlock = nil;
    self.LATViewControllerSpreadViewHideCompletedBlock = nil;
}
@end
