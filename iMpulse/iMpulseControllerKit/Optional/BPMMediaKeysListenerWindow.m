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

@synthesize loggingDelegate;


//For +singleton method
static BPMMediaKeysListenerWindow* _singleton = nil;
//Singleton method
+ (BPMMediaKeysListenerWindow*)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _singleton = [[BPMMediaKeysListenerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    
    return _singleton;
}


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
    
    NSString* notificationName = nil;
    
    //Can ignore volume up and volume down since the OS will show the volume overlay.
    if (event.type == UIEventTypeRemoteControl)
    {
        switch (event.subtype)
        {  
            case UIEventSubtypeRemoteControlTogglePlayPause:
                notificationName = @"NOTIFICATION_PLAYPAUSE";
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                notificationName = @"NOTIFICATION_PREVIOUSTRACK";
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                notificationName = @"NOTIFICATION_NEXTTRACK";                
                break;

                
                
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                notificationName = @"NOTIFICATION_SEEKBACK_BEGIN";
                break;
                
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                notificationName = @"NOTIFICATION_SEEKBACK_END";
                break;
                
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                notificationName = @"NOTIFICATION_SEEKFORWARD_BEGIN";
                break;
                
            case UIEventSubtypeRemoteControlEndSeekingForward:
                notificationName = @"NOTIFICATION_SEEKFORWARD_END";
                break;
                
            default:
                break;
        }
    }
    
    //Post the notification
    if (notificationName)
    {
        DebugLog(@"Posting [%@]", notificationName);
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
    }
    else
    {
        DebugLog(@"Unrecognized event [%@]", event);
    }
    
    //Log the message to the logger
    if (self.loggingDelegate)
    {
        [self.loggingDelegate log:notificationName];
    }
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