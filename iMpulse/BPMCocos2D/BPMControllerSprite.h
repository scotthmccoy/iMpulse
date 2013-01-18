//
//  BPMControllerSprite.h
//  iMpulse
//
//  Created by Scott McCoy on 1/18/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "CCSprite.h"

@interface BPMControllerSprite : CCSprite
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

+ (id) sprite;

@end
