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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS" object:nil];
    
    
    


    
    
}


- (void)update:(ccTime)dt
{
    DebugLogWhereAmI();
}


#pragma mark - Observers

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}




@end
