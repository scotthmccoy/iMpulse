//
//  BPMScene.h
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Superclass
#import "CCScene.h"


@class CCSprite;

@interface BPMScene : CCScene
{
    CCSprite* controllerContainer;
    CCSprite* controllerFront;
    CCSprite* controllerBack;
    CCSprite* controllerBackArrow;
    
    CCSprite* buttonDPadUpHighlight;
    CCSprite* buttonDPadRightHighlight;
    CCSprite* buttonDPadDownHighlight;
    CCSprite* buttonDPadLeftHighlight;
    
    CCSprite* buttonWHighlight;
    CCSprite* buttonMHighlight;
    CCSprite* buttonVHighlight;
    CCSprite* buttonAHighlight;
    
    CCSprite* buttonUHighlight;
    CCSprite* buttonNHighlight;
}

- (void) setupiMpulseControllerObservers;

@end
