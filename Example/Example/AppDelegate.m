//
//  AppDelegate.m
//  Example
//
//  Created by luoshimei on 2023/3/27.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupWindow];
    return YES;
}

#pragma mark -

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    RootViewController *vc = [[RootViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
//    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}

@end
