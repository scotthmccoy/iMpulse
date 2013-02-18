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

//Cocos 2d Stuff
#import "cocos2d-iphone-2.0/cocos2d/cocos2d.h"
#import "BPMMainScene.h"
#import "BPMStartupLayer.h"
#import "BPMCocosNavigationController.h"

#import "BPMUtilities.h"

@implementation BPMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Instead of using a normal UIWindow, here we use one that has a looping sound file playing on it
    //This keeps it conveniently global, and since Window is high up in the responder tree, it's a good place
    //to capture media key events. Please note that in a normal app, this step will not be neccessary.
    self.window = [BPMMediaKeysListenerWindow singleton];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    

    
    /////////////////////////////////////////////////////////////////
    //Set Up the GL View
    /////////////////////////////////////////////////////////////////

	CCGLView *glview = [CCGLView viewWithFrame:[self.window bounds]
                                   pixelFormat:kEAGLColorFormatRGB565
                                   depthFormat:0 /* GL_DEPTH_COMPONENT24_OES */
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0
                        ];
    
    
    /////////////////////////////////////////////////////////////////
    //Set Up the cocos2D Director
    /////////////////////////////////////////////////////////////////
    
	[[CCDirector sharedDirector] setDisplayStats:YES];
	[[CCDirector sharedDirector] setAnimationInterval:1.0/60];
    
	[[CCDirector sharedDirector] setView:glview];
	[[CCDirector sharedDirector] setDelegate:self];
	[CCDirector sharedDirector].wantsFullScreenLayout = YES;
    
	[[CCDirector sharedDirector] enableRetinaDisplay:YES];
    if (IS_IPAD()) [[CCDirector sharedDirector] setContentScaleFactor:1];


    /////////////////////////////////////////////////////////////////
    //Set Up VC Stack
    /////////////////////////////////////////////////////////////////
    
    // in the didFinishLaunchingWithOptions method...
    
	// Create a Navigation Controller with the Director
	BPMCocosNavigationController* navController = [[BPMCocosNavigationController alloc] initWithRootViewController:[CCDirector sharedDirector]];
    navController.navigationBarHidden = YES;
    
	// for rotation and other messages
	[[CCDirector sharedDirector] setDelegate:self];
    
	// set the Navigation Controller as the root view controller
    //	[window_ addSubview:navController_.view];	// Generates flicker.
	[self.window setRootViewController:navController];




    
    
    ///////////////////////////////////////////////////////////////////////////////
    //Set up the keyboard listener. This also sets up the Controller State machine.
    ///////////////////////////////////////////////////////////////////////////////

    [[BPMKeyboardListener singleton] setupWithParentView:self.window];
    
    ///////////////////////////////////////////////////////////////////////////////
    //Set up and run the cocos2D Scene
    ///////////////////////////////////////////////////////////////////////////////
    BPMMainScene* mainScene = [[BPMMainScene alloc] init];
    [[CCDirector sharedDirector] runWithScene:mainScene];

    return YES;
}

#pragma mark - App Events

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] pause];
    exit(0);
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    [[CCDirector sharedDirector] stopAnimation];
    exit(0);
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

//#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
{
    // DebugLogWhereAmI();
    
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortrait && interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// Need to add this to the app delegate allow all portrait for things like Game Center or other portrait only modal view controllers that will be pushed into the app to avoid a crash.
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscape;
}


@end
