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

@interface BPMScene : CCScene <BPMLoggingDelegate>
{
    CCMenu* tabMenu;
    
    //Main Layer
    CCLayer* lyrMain;
    BPMControllerSprite* controller;
    
    //Dev Tool Layer
    CCLayer* lyrDevTool;
    NSMutableString* strLog;
    CCLabelTTF* lblDevTool;
    NSDateFormatter* dateFormat;
    
    
    //Instructions Layer
    CCLayer* lyrInstructions;    
}




@end
