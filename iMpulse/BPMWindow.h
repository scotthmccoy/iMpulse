//
//  BPMWindow.h
//  iMpulse
//
//  Created by Scott McCoy on 1/4/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//


#import <UIKit/UIKit.h>

//For MPMusicPlayerController
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface BPMWindow : UIWindow
{
    AVAudioPlayer* theAudio;
}

@end
