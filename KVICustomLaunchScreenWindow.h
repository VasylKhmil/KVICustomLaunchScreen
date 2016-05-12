//
//  KVICustomLaunchScreenWindow.h
//  CustomLaunchScreen
//
//  Created by Vasyl Khmil on 9/6/15.
//  Copyright (c) 2015 Volodymyr Khmil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVICustomLaunchScreenWindow : UIWindow

@property (nonatomic, strong) UIViewController *launchScreenViewController;
@property (nonatomic, strong) NSString *storyboardName;

- (instancetype)initWithLaunchController:(UIViewController *)launchController;

- (void)endDispalyingLaunchScreenWithPreparation:(void (^)())preparation completion:(void (^)())completion;

@end
