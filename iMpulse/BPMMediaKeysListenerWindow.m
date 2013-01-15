//
//  BPMWindow.m
//  iMpulse
//
//  Created by Scott McCoy on 1/4/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//


//The app window 

//Header
#import "BPMMediaKeysListenerWindow.h"

//Other
#import "BPMUtilities.h"


@implementation BPMMediaKeysListenerWindow

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //Set up an active audio session so that the app will repsond to media keys.
        [self setupAVAudioSession];
        
        //Play a looping sound file
        NSString *path = [BPMUtilities pathForResource:@"snd_blank.aiff"];
        theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        theAudio.numberOfLoops = -1;
        [theAudio play];
        
        //Have the application respond to media control buttons
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    return self;
}

//Allow the window to become first responder
- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    DebugLogWhereAmI();
    
    //TODO: Figure out which remote control event occured.
}

#pragma Audio
- (void) setupAVAudioSession
{
    // Registers this class as the delegate of the audio session.
	[[AVAudioSession sharedInstance] setDelegate: self];
	
	NSError *myErr;
	
    // Initialize the AVAudioSession here.
	if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr])
    {
        DebugLog(@"Error!");
        // Handle the error here.
    }
}


@end