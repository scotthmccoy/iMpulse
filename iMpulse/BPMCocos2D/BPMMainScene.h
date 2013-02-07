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
@class CCMenuItemToggle;
@class BPMStartupLayer;

@interface BPMMainScene : CCScene <BPMLoggingDelegate>
{
    //Tabs on the top right
    CCMenu* tabMenu;
    BPMStartupLayer* startupLayer;
    
    ////////////
    //Main Layer
    ////////////    
    CCLayer* lyrMain;
    BPMControllerSprite* controller;
    
    //OS Mode selector
    CCMenu* mnu_os_toggle;
    CCMenuItemToggle* btn_os_toggle;
    CCMenuItemImage* btn_os_ios;
    CCMenuItemImage* btn_os_maw;
    
    //Game or Media mode selector
    CCMenu* mnu_game_media_toggle;
    CCMenuItemToggle* btn_game_media_toggle;
    CCMenuItemImage* btn_game;
    CCMenuItemImage* btn_media;
    
    //Player 1 and Player 2 Selector
    CCMenu* mnu_player_toggle;    
    CCMenuItemToggle* btn_player_toggle;
    CCMenuItemImage* btn_player_1;
    CCMenuItemImage* btn_player_2;

    //Left and Right Hand mode selector
    CCMenuItemToggle* btn_orientation_toggle;    
    CCMenu* mnu_orientation_toggle;
    CCMenuItemImage* btn_orientation_right;
    CCMenuItemImage* btn_orientation_left;
    
    //Covers up buttons
    CCSprite* mediaModeButtonBlockerOverlay;
    CCSprite* mediaModeOSButtonBlockerOverlay;
    
    
    
    ////////////////
    //Dev Tool Layer
    ////////////////
    CCLayer* lyrDevTool;
    NSMutableArray* arrayLog;
    NSMutableString* strLog;
    CCLabelTTF* lblDevTool;
    NSDateFormatter* dateFormat;
    
    ////////////////////
    //Instructions Layer
    ////////////////////
    CCLayer* lyrInstructions;

    
    /////////////////////////
    //Media and Mode overlays
    /////////////////////////
    
    //Media Key Sprites
    CCSprite* mediaNextTrack;
    CCSprite* mediaPreviousTrack;
    CCSprite* mediaSeekForward;
    CCSprite* mediaSeekBackward;
    CCSprite* mediaPlayPause;
    
    //Mode Change Sprites
    CCSprite* modeMedia;
    CCSprite* modeGame;
    CCSprite* modeMAW;
    CCSprite* modeIOS;
    CCSprite* modeLeft;
    CCSprite* modeRight;
    CCSprite* modePlayer1;
    CCSprite* modePlayer2;
}

@property (readwrite) BOOL allowModeChangeOverlays;


@end
