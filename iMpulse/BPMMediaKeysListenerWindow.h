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

@interface BPMMediaKeysListenerWindow : UIWindow
{
    AVAudioPlayer* theAudio;
}

@end
