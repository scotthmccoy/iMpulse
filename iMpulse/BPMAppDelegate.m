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

#import "cocos2d-iphone-2.0/cocos2d/cocos2d.h"
#import "BPMScene.h"

@implementation BPMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Instead of using a normal UIWindow, here we use one that has a looping sound file playing on it
    //This keeps it conveniently global, and since Window is high up in the responder tree, it's a good place
    //to capture media key events. Please note that in a normal app, this step will not be neccessary.
    //self.window = [[BPMMediaKeysListenerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];    
    
    //Set up the keyboard listener. This also sets up the Controller State machine.
    //[[BPMKeyboardListener singleton] setupWithParentView:self.window];
    
    
	[[CCDirector sharedDirector] setDisplayStats:YES];
	[[CCDirector sharedDirector] setAnimationInterval:1.0/60];
    
	// GL View
	CCGLView *glview = [CCGLView viewWithFrame:[self.window bounds]
									 pixelFormat:kEAGLColorFormatRGB565
									 depthFormat:0 /* GL_DEPTH_COMPONENT24_OES */
							  preserveBackbuffer:NO
									  sharegroup:nil
								   multiSampling:NO
								 numberOfSamples:0
						  ];
//    CCGLView *glview = [CCGLView viewWithFrame:CGRectMake(0, 0, 250,350)];
    
//    EAGLView *glView = [EAGLView viewWithFrame:[self.window bounds]
//                                   pixelFormat:kEAGLColorFormatRGBA8
//                                   depthFormat:GL_DEPTH_COMPONENT24_OES
//                            preserveBackbuffer:NO];
	
    
	[[CCDirector sharedDirector] setView:glview];
	[[CCDirector sharedDirector] setDelegate:self];
	[CCDirector sharedDirector].wantsFullScreenLayout = YES;
    
	// Retina Display ?
	[[CCDirector sharedDirector] enableRetinaDisplay:YES];
    
    BPMScene* myScene = [[BPMScene alloc] init];
    
    
    UINavigationController* windowNC = [[UINavigationController alloc] initWithRootViewController: [CCDirector sharedDirector]];
	windowNC.navigationBarHidden = YES;
    [self.window addSubview: windowNC.view];
    
    [[CCDirector sharedDirector] runWithScene:myScene];
    

    
    return YES;
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    [[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
    [[CCDirector sharedDirector] startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

@end
