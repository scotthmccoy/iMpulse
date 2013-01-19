//
//  BPMWindow.h
//  iMpulse
//
//  Created by Scott McCoy on 1/4/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//


#import <UIKit/UIKit.h>

//For MPMusicPlayerController
#import <AVFoundation/AVFoundation.h>

//Protocol
#import "BPMLoggingDelegate.h"

@interface BPMMediaKeysListenerWindow : UIWindow
{
    AVAudioPlayer* theAudio;
}

+ (BPMMediaKeysListenerWindow*)singleton;

@property (readwrite) id<BPMLoggingDelegate> loggingDelegate;

@end
