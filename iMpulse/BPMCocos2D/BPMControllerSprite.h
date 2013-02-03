//
//  BPMControllerSprite.h
//  iMpulse
//
//  Created by Scott McCoy on 1/18/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "CCSprite.h"

//Define some constants for the different sprite positions for different modes
//TODO: This is really not a good place to define these
#define basePosition ccp(320,180)
#define southpawOffset ccp(0,-80)
#define mediaModeOffset ccp(40,-50)


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
