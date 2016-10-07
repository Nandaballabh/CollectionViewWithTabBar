//
//  AppDelegate.m
//  CollectionViewExample
//
//  Created by Nanda Ballabh on 10/5/16.
//  Copyright © 2016 Nanda Ballabh. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()
@property (strong , nonatomic) UIView * menuView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.tabBarController];
    self.tabBarController.title = @"First View";
    UIBarButtonItem * home = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(homeButtonTapped)];
    self.tabBarController.navigationItem.leftBarButtonItem = home;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

//TODO
// Can be created the Side menu like below . Just wrote for example
// I need to give good look to side menu
- (void) homeButtonTapped {
    
    if(self.menuView) {
        [self hideMenuView];
        return;
    
    }
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(-220, 0, 220, CGRectGetHeight(self.window.bounds))];
    self.menuView.backgroundColor = [UIColor blackColor];
    UIButton * backgroungBtn = [[UIButton alloc]initWithFrame:self.window.bounds];
    backgroungBtn.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7];
    backgroungBtn.tag = 3333;
    backgroungBtn.alpha = 0.0f;
    [backgroungBtn addTarget:self action:@selector(dismissMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:backgroungBtn];
    [self.window addSubview:self.menuView];
    [UIView animateWithDuration:0.35 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.menuView.frame = CGRectMake(-10, 0, 220, CGRectGetHeight(self.window.bounds));
        backgroungBtn.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) hideMenuView {
 
    UIButton * button = (UIButton *)[self.window viewWithTag:3333];
    [UIView animateWithDuration:0.35 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveLinear animations:^{
       self.menuView.frame = CGRectMake(-220, 0, 220, CGRectGetHeight(self.window.bounds));
        button.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        [self.menuView removeFromSuperview];
        self.menuView = nil;
        [button removeFromSuperview];
    }];
   
}
- (void)dismissMenuView {
    [self hideMenuView];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if([viewController isKindOfClass:[FirstViewController class]]) {
        tabBarController.title = @"First View";
    } else if([viewController isKindOfClass:[SecondViewController class]]) {
        tabBarController.title = @"Second View";
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
