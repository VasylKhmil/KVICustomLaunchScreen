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

@property (nonatomic) BOOL workFinished;

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
    if (!self.workFinished) {
        [self showLaunchScreenAndCacheRootController];
    }
}

#pragma mark - Public

- (void)endDispalyingLaunchScreenWithPreparation:(void (^)())preparation completion:(void (^)())completion {
    if ([self needToUseInitialViewControllerFromStoryboard]) {
        UIStoryboard *mainStoryboard = [self mainStoryboard];
        
        if (mainStoryboard != nil) {
            self.initialViewController = [mainStoryboard instantiateInitialViewController];
        }
    }
    
    
    [self swapScreenToInitialWithPreparation:preparation completion:completion];
}

#pragma mark - Private

- (void)swapScreenToInitialWithPreparation:(void (^)())preparation completion:(void (^)())completion {
    
    void (^showInitialControllerAnimationBlock)() = ^{
        
        [UIView animateWithDuration:0.5
         
                         animations:^{
                             self.alpha = 1;
                         }
         
                         completion:^(BOOL finished) {
                             if (completion != nil) {
                                 completion();
                             }
                         }
         ];
    };
    
    void (^swappControllersAnimationBlock)(BOOL finished) = ^(BOOL finished) {
        self.rootViewController = self.initialViewController;
        
        self.workFinished = TRUE;
        
        [self makeKeyAndVisible];
        
        if (preparation != nil) {
            preparation();
        }
        
        showInitialControllerAnimationBlock();
    };
    
    [UIView animateWithDuration:0.5
     
                     animations:^{
                         self.alpha = 0;
                     }
     
                     completion:swappControllersAnimationBlock ];
    
}

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
