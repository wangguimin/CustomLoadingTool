//
//  NSObject+HUD.m
//
//  Created by wangguimin on 15/12/19.
//  Copyright © 2015年 wangguimin. All rights reserved.
//

#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

#define kAnimationType MBProgressHUDAnimationZoomOut
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation NSObject (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



#pragma mark 状态提醒
- (void)showErrorWithStatus:(NSString *)string{
    [self showHint:string imageStr:@"error"];
}


- (void)showSuccessWithStatus:(NSString *)string{
    [self showHint:string imageStr:@"success"];
}


- (void)showWarningWithStatus:(NSString *)string{
    [self showHint:string imageStr:@"warning"];
}
- (void)showWindowHint:(NSString *)hint imageStr:(NSString *)imageStr{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.animationType = kAnimationType;
    hud.userInteractionEnabled = NO;
    hud.opaque = YES;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = hint;
    hud.margin = 10.f;
    UIImage *image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.minSize = CGSizeMake(kScreenWidth / 3, kScreenWidth / 3);
    hud.minShowTime = [self displayDurationForString:hint];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];
    hud.bezelView.layer.cornerRadius = kScreenWidth / 24;
    //    hud.label.textColor = [UIColor whiteColor];
    
    [hud setOffset:CGPointMake(hud.offset.x, hud.offset.y - kHeight(50))];
    [hud hideAnimated:YES];
    [self setHUD:hud];
    
}

- (void)showHint:(NSString *)hint imageStr:(NSString *)imageStr{
    //显示提示信息
    UIView *view = [self appTopViewController].view;;
    __block BOOL stopShow = NO;
   [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if ([obj isKindOfClass:[MBProgressHUD class]]) {
           stopShow = YES;
       }
   }];
    if (stopShow) {
        [self hideAllHud];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.animationType = kAnimationType;
    hud.userInteractionEnabled = NO;
    hud.opaque = YES;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = hint;
    hud.margin = 10.f;
    UIImage *image = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.minSize = CGSizeMake(kScreenWidth / 3, kScreenWidth / 3);
    hud.minShowTime = [self displayDurationForString:hint];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];
    hud.bezelView.layer.cornerRadius = kScreenWidth / 24;
//    hud.label.textColor = [UIColor whiteColor];
    
    [hud setOffset:CGPointMake(hud.offset.x, hud.offset.y - kHeight(50))];
    [hud hideAnimated:YES];
    [self setHUD:hud];

}

- (void)showIndeterminate{
    UIView *view = [self appTopViewController].view;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self setHUD:hud];
}
- (void)showIndeterminateWithHint:(NSString *)hint{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = hint;

    [self setHUD:hud];
}
- (void)showDone{
    UIView *view = [self appTopViewController].view;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = @"清除成功！";
    
    [hud hideAnimated:YES afterDelay:3.f];
}
- (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MIN((float)string.length*0.06 + 0.3, 5.0);
}

- (void)hideAllHud{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    UIView *view1 = [self appTopViewController].view;
    [MBProgressHUD hideHUDForView:view1 animated:YES];
    
}
- (void)hideHud{
    
    [[self HUD] hideAnimated:YES];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    [[self HUD] hideAnimated:animated afterDelay:delay];
}

- (void)showMessageWithTitle:(NSString *)title
                     message:(NSString *)message
                 actionArray:(NSArray *)actionArray
                          VC:(UIViewController *)VC
              preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    for (int i = 0; i < actionArray.count; i++) {
        [alert addAction:actionArray[i]];
    }
    
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
}
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message actionNameArray:(NSArray *)actionNameArray action:(void (^)(NSInteger index))actionBlock VC:(UIViewController *)VC{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i = 0; i < actionNameArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionNameArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (actionBlock) {
                actionBlock(i);
            }
        }];
        [alert addAction:action];
    }
    
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
}

- (UIViewController *)appTopViewController{

    UIViewController *rootVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    
    UIViewController *parent = nil;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        NSInteger index = [(UITabBarController *)rootVC selectedIndex];
        parent = [(UITabBarController *)rootVC viewControllers][index];
        
    } else {
        parent = rootVC;
    }
    if (parent.presentedViewController) {
        parent = parent.presentedViewController;
    }

    if ([parent isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)parent topViewController];
    } else {
        rootVC = parent;
    }
   
    
    return rootVC;
}

@end
