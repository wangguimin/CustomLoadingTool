//
//  NSObject+HUD.h
//
//  Created by wangguimin on 15/12/19.
//  Copyright © 2015年 wangguimin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSObject (HUD)

- (NSTimeInterval)displayDurationForString:(NSString*)string;
- (void)showSuccessWithStatus:(NSString*)string;
- (void)showErrorWithStatus:(NSString *)string;
- (void)showWarningWithStatus:(NSString *)string;

- (void)showWindowHint:(NSString *)hint imageStr:(NSString *)imageStr;

- (void)showIndeterminate;
- (void)showIndeterminateWithHint:(NSString *)hint;

- (void)showDone;

- (void)hideAllHud;
- (void)hideHud;
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

//  系统样式的弹出框
- (void)showMessageWithTitle:(NSString *)title
                     message:(NSString *)message
                 actionArray:(NSArray *)actionArray
                          VC:(UIViewController *)VC
              preferredStyle:(UIAlertControllerStyle)preferredStyle;

- (void)showAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                 actionNameArray:(NSArray *)actionNameArray
                  action:(void (^)(NSInteger index))actionBlock
                          VC:(UIViewController *)VC;
@end
