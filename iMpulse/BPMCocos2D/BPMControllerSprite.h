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
    
    CCSprite* buttonRightShoulderHighlight;
    CCSprite* buttonLeftShoulderHighlight;
    
    CCSprite* mediaNextTrack;
    CCSprite* mediaPreviousTrack;
    CCSprite* mediaPlayPause;
    
    BOOL southpawMode;
}

@property (readwrite) int selectedPlayer;

- (void) setSouthpawMode:(BOOL)isOn;
- (void) setHighlightState:(BOOL)on forHighlight:(CCSprite*)sprite onlyForPlayer:(int)playerNumber;
- (void) reset;


+ (id) sprite;

@end
