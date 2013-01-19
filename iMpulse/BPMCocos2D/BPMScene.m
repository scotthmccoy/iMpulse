//
//  BPMScene.m
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMScene.h"

//Cocos
#import "cocos2d.h"
#import "BPMControllerSprite.h"

//Other
#import "BPMUtilities.h"

@implementation BPMScene


- (id)init {
    
    if ((self = [super init]))
    {

    }
    return self;
    
}

- (void)onEnter
{
    DebugLogWhereAmI();
    
    //Must do this on every onEnter
    [super onEnter];
    
    //Create bg
    CCSprite* bg = [CCSprite spriteWithFile:@"background.png"];
    bg.ignoreAnchorPointForPosition = YES;
    
    //Create the controller sprite
    controller = [BPMControllerSprite sprite];
    controller.position = ccp(315,180);
    
    //Add Sprites
    [self addChild:bg];
    [self addChild:controller];
    
}
                      
                      









@end
