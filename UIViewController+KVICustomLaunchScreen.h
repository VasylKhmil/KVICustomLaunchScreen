//
//  KVICustomLaunchScreenViewController.h
//  
//
//  Created by Vasyl Khmil on 9/5/15.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (KVICustomLaunchScreen)

- (void)kvi_endDispalyingAsLaunchScreenWithPreparation:(void (^)())preparation completion:(void (^)())completion;

@end
