//
//  KVICustomLaunchScreenViewController.m
//  
//
//  Created by Vasyl Khmil on 9/5/15.
//
//

#import "UIViewController+KVICustomLaunchScreen.h"
#import "KVICustomLaunchScreenWindow.h"

@implementation UIViewController (KVICustomLaunchScreen)

- (void)kvi_endDispalyingAsLaunchScreen {
    
    KVICustomLaunchScreenWindow *launchScreenWindow = [self launchScreenDispayingWindow];
    [launchScreenWindow endDispalyingLaunchScreen];
}

#pragma mark - Private

- (KVICustomLaunchScreenWindow *)launchScreenDispayingWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    __block KVICustomLaunchScreenWindow *launchScreenWindow;
    [windows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self isSelfDisplayingLaunchScreenWindow:obj]) {
            launchScreenWindow = obj;
        }
    }];
    
    return launchScreenWindow;
}

- (BOOL)isSelfDisplayingLaunchScreenWindow:(UIWindow *)window {
    if ([window isKindOfClass:[KVICustomLaunchScreenWindow class]]) {
        return ([(KVICustomLaunchScreenWindow *)window launchScreenViewController] == self);
    }
    return NO;
}

@end
