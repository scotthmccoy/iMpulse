//
//  BPMWindow.m
//  iMpulse
//
//  Created by Scott McCoy on 1/4/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMWindow.h"

#import "BPMUtilities.h"

//For MPMusicPlayerController




@implementation BPMWindow

- (id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self)
    {

        
        //Make it blue so we know we're on there
        self.backgroundColor = [UIColor blueColor];

        //Take input
        [self becomeFirstResponder];
        
        
        
        NSString *path = [BPMUtilities pathForResource:@"snd_cycle_stop.aif"];
        theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        //theAudio.delegate = self;
        theAudio.numberOfLoops = -1;
        [theAudio play];
                          
        
        
        [self setupAVAudioSession];
        
        //Have the application respond to media control buttons
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
//        
//        // instantiate a music player
//        myPlayer = [MPMusicPlayerController applicationMusicPlayer];
//        
//        // assign a playback queue containing all media items on the device
//        [myPlayer setQueueWithQuery: [MPMediaQuery songsQuery]];
//        
//        // start playing from the beginning of the queue
//        [myPlayer play];
    }
    return self;
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    DebugLogWhereAmI();
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