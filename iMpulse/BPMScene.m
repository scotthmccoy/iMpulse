//
//  BPMScene.m
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMScene.h"

#import "cocos2d.h"

@implementation BPMScene


- (id)init {
    
    if ((self = [super init]))
    {
    }
    return self;
    
}
                      
                      
- (void)onEnter
{
    [super onEnter];
    
    DebugLogWhereAmI();
    CCSprite *grossini = [CCSprite spriteWithFile:@"grossini.png"];
    [self addChild:grossini];
    [grossini setPosition:ccp(100,200)];
    
//    [grossini runAction:[CCMoveBy actionWithDuration:1 position:ccp(150,0)]];
    
    id sequence = [CCSequence actions:
                          [CCMoveBy actionWithDuration:1
                                              position:ccp(150,0)],
                          [CCMoveBy actionWithDuration:1
                                              position:ccp(-150,0)],
              nil];
    id repeatedSequence = [CCRepeatForever actionWithAction:sequence];
    
    [grossini runAction:repeatedSequence];
}


- (void)update:(ccTime)dt
{
    DebugLogWhereAmI();
}

@end
