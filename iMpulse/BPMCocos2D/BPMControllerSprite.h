//
//  BPMControllerSprite.h
//  iMpulse
//
//  Created by Scott McCoy on 1/18/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "CCSprite.h"
#import "BPMUtilities.h"

//Define some constants for the different sprite positions for different modes
//TODO: This is really not a good place to define these
#define basePosition ADJUST_REL(ccp(320,180))
#define southpawOffset (IS_IPAD() == YES ? ccp(46,-30) : ccp(-13,-78))
#define mediaModeOffset (IS_IPAD() == YES ? ccp(60,0) : ccp(40,-47))

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
    
    CCSprite* mediaKeyGuideFront;
    CCSprite* mediaKeyGuideBack;
    
    CCSprite* buttonRightShoulderHighlight;
    CCSprite* buttonLeftShoulderHighlight;
    
    BOOL southpawMode;
    BOOL mediaMode;
}

@property (readwrite) int selectedPlayer;

- (void) setMediaMode:(BOOL)isOn;
- (void) setSouthpawMode:(BOOL)isOn;

- (void) setHighlightState:(BOOL)on forHighlight:(CCSprite*)sprite onlyForPlayer:(int)playerNumber;
- (void) reset;


+ (id) sprite;

@end
