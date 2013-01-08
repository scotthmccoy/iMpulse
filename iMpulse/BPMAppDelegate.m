//
//  BPMAppDelegate.m
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

//AppDelegate
#import "BPMAppDelegate.h"

//Keyboard
#import "BPMKeyboardListener.h"

//Other
#import "BPMMediaKeysListenerWindow.h"

@implementation BPMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Instead of using a normal UIWindow, here we use one that has a looping sound file playing on it
    //This keeps it conveniently global, and since Window is high up in the responder tree, it's a good place
    //to capture media key events. Please note that in a normal app, this step will not be neccessary.
    self.window = [[BPMMediaKeysListenerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];    
    
    //Set up the keyboard listener. This also sets up the Controller State machine.
    [[BPMKeyboardListener singleton] setParentView:self.window];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
