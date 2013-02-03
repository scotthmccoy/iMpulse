//
//  BPMScene.h
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Superclass
#import "CCScene.h"

//Protocol
#import "BPMLoggingDelegate.h"


//Cocos Classes
@class BPMControllerSprite;
@class CCLayer;
@class CCMenu;
@class CCLabelTTF;
@class CCMenuItemImage;
@class CCSprite;

@interface BPMScene : CCScene <BPMLoggingDelegate>
{
    CCMenu* tabMenu;
    
    //Main Layer
    CCLayer* lyrMain;
    BPMControllerSprite* controller;
    CCMenuItemImage* btn_os_ios;
    CCMenuItemImage* btn_os_maw;
    CCMenuItemImage* btn_game;
    CCMenuItemImage* btn_media;
    CCMenuItemImage* btn_player_1;
    CCMenuItemImage* btn_player_2;
    CCMenuItemImage* btn_orientation_right;
    CCMenuItemImage* btn_orientation_left;
    
    
    //Dev Tool Layer
    CCLayer* lyrDevTool;
    NSMutableArray* arrayLog;
    NSMutableString* strLog;
    CCLabelTTF* lblDevTool;
    NSDateFormatter* dateFormat;
    
    
    //Instructions Layer
    CCLayer* lyrInstructions;
    
    //Media Key Sprites
    CCSprite* mediaNextTrack;
    CCSprite* mediaPreviousTrack;
    CCSprite* mediaSeekForward;
    CCSprite* mediaSeekBackward;
    CCSprite* mediaPlayPause;
}




@end
