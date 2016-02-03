//
//  KVICustomLaunchScreenWindow.m
//  CustomLaunchScreen
//
//  Created by Vasyl Khmil on 9/6/15.
//  Copyright (c) 2015 Volodymyr Khmil. All rights reserved.
//

#import "KVICustomLaunchScreenWindow.h"

@interface KVICustomLaunchScreenWindow ()

@property (nonatomic, strong) UIViewController *initialViewController;

@end

@implementation KVICustomLaunchScreenWindow

#pragma mark - Initialization

- (instancetype)initWithLaunchController:(UIViewController *)launchController {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self != nil) {
        _launchScreenViewController = launchController;
    }
    
    return self;
}

#pragma mark - Override

- (void)becomeKeyWindow {
    [self showLaunchScreenAndCacheRootController];
}

#pragma mark - Public

- (void)endDispalyingLaunchScreen {
    if ([self needToUseInitialViewControllerFromStoryboard]) {
        UIStoryboard *mainStoryboard = [self mainStoryboard];
        
        if (mainStoryboard != nil) {
            self.initialViewController = [mainStoryboard instantiateInitialViewController];
        }
    }
    self.rootViewController = self.initialViewController;
}

#pragma mark - Private

- (void)showLaunchScreenAndCacheRootController {
    if (self.launchScreenViewController != nil) {
        self.initialViewController = self.rootViewController;
        self.rootViewController = self.launchScreenViewController;
    }
}

- (UIStoryboard *)mainStoryboard {
    NSString *storyboardName = self.storyboardName;
    if (storyboardName == nil) {
        storyboardName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
    }
    
    if (storyboardName != nil) {
        return [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    }
    return nil;
}

- (BOOL)needToUseInitialViewControllerFromStoryboard {
    return self.initialViewController == nil;
}

@end
