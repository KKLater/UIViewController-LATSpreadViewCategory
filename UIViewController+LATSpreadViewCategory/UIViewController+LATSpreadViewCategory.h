//
//  UIViewController+LATSpreadViewCategory.h
//  LATNavigationSpreadViewDemo
//
//  Created by Later on 16/8/9.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LATSpreadViewCategory)
/**
 *  可以展开的视图
 */
@property (strong, nonatomic) UIView *spreadView;
@property (strong, nonatomic) UIView *spreadBackView;

/**
 *  视图是否处于展开的状态
 */
@property (assign, nonatomic, readonly) BOOL isSpreadViewShow;
/**
 *  spreadView显示
 *
 *  @param animation 显示过程block
 *  @param completed 显示结束block
 */
- (void)showSpreadViewAnimation:(void(^)())animation
                      completed:(void(^)())completed;
/**
 *  spreadView隐藏
 *
 *  @param animation 隐藏过程block
 *  @param completed 隐藏结束block
 */
- (void)hideSpreadViewAnimation:(void(^)())animation
                      completed:(void(^)())completed;
@end
