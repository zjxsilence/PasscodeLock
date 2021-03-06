//
//  AppDelegate.m
//  PasscodeLockDemo
//
//  Created by 159CaiMini02 on 16/7/1.
//  Copyright © 2016年 myz. All rights reserved.
//

#import "AppDelegate.h"
#import "MYZTabBarController.h"
#import "MYZLockView.h"


@interface AppDelegate ()

@property (nonatomic, weak) MYZLockView * lockView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MYZTabBarController * rootVC = [[MYZTabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
    
    [self addLockView];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:PasscodeText]) {
        [self.lockView showRemindFingerprint];
    }
    
    return YES;
}

- (void)addLockView
{
    [self.lockView removeFromSuperview];
    
    //手势解锁开关
    BOOL gestureLock = [[NSUserDefaults standardUserDefaults] boolForKey:GestureText];
    //密码解锁开关
    BOOL passcodeLock = [[NSUserDefaults standardUserDefaults] boolForKey:PasscodeText];
    
    if (gestureLock || passcodeLock)
    {
        MYZLockView * lockView = [[MYZLockView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        lockView.showGestureViewBool = gestureLock;
        lockView.showPasscodeViewBool = passcodeLock;
        [[UIApplication sharedApplication].keyWindow addSubview:lockView];
        self.lockView = lockView;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self addLockView];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:PasscodeText]) {
        [self.lockView showRemindFingerprint];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
