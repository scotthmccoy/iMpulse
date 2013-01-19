//
//  BPMScene.h
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Superclass
#import "CCScene.h"


//@class CCSprite;
@class BPMControllerSprite;
@class CCLayer;
@class CCMenu;

@interface BPMScene : CCScene
{
    CCMenu* tabMenu;
    
    CCLayer* lyrMain;
    CCLayer* lyrDevTool;
    CCLayer* lyrInstructions;    
    
    BPMControllerSprite* controller;
}




@end
