//
//  BPMStartupScene.m
//  iMpulse
//
//  Created by Scott McCoy on 2/6/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMStartupLayer.h"

//Cocos
#import "cocos2d.h"
#import "BPMMainScene.h"


@implementation BPMStartupLayer


+ (id) layer
{
    //node calls [self init]
    return [BPMStartupLayer node];
}

- (id) init
{
    DebugLogWhereAmI();
    
    if(self = [super init])
    {
        ///////////////////
        //Create Main Layer
        ///////////////////
        
        //Create bg
        CCSprite* bg = [CCSprite spriteWithFile:@"bgStartup.png"];
        bg.ignoreAnchorPointForPosition = YES;
        
        //Add the bg
        [self addChild:bg];
        
        //Set up listeners for all possible "M" key notifications.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_M_PRESS:) name:@"NOTIFICATION_PLAYER_1_M_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_M_PRESS:) name:@"NOTIFICATION_PLAYER_2_M_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_W_PRESS:) name:@"NOTIFICATION_PLAYER_1_W_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_W_PRESS:) name:@"NOTIFICATION_PLAYER_2_W_PRESS" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_COULD_NOT_MAP_KEY:) name:@"NOTIFICATION_COULD_NOT_MAP_KEY" object:nil];
    }
    
    return self;
}


- (void) doneSetupWithIsMAW:(BOOL)isMaw andIsMedia:(BOOL)isMedia andIsPlayer1:(BOOL)isPlayer1 andIsSouthPaw:(BOOL)isSouthPaw
{
    DebugLogWhereAmI();
    //Kill all observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    //TODO: Fade the bg sprite and at the end of that sequence, remove the layer.
    [self removeFromParentAndCleanup:NO];
}


#pragma mark - Observers

//If we get an M, we know we're in Northpaw
- (void) observer_NOTIFICATION_PLAYER_1_M_PRESS:(NSNotification*)aNotification
{
    //Get the Key
    NSString* key = [aNotification.userInfo objectForKey:@"input"];
    DebugLog(@"[%@]", key);

    if ([key isEqualToString:@"o"])
    {
        [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer1:NO andIsSouthPaw:NO];
    }
    else if ([key isEqualToString:@"7"])
    {
        [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer1:YES andIsSouthPaw:NO];
    }
}

- (void) observer_NOTIFICATION_PLAYER_2_M_PRESS:(NSNotification*)aNotification
{
    //Get the Key
    NSString* key = [aNotification.userInfo objectForKey:@"input"];
    DebugLog(@"[%@]", key);
    
    if ([key isEqualToString:@"o"])
    {
        [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer1:NO andIsSouthPaw:NO];
    }
    else if ([key isEqualToString:@"7"])
    {
        [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer1:YES andIsSouthPaw:NO];
    }
}

- (void) observer_NOTIFICATION_PLAYER_1_W_PRESS:(NSNotification*)aNotification
{
    DebugLog(@"[%@]", aNotification.userInfo);
}

- (void) observer_NOTIFICATION_PLAYER_2_W_PRESS:(NSNotification*)aNotification
{
    DebugLog(@"[%@]", aNotification.userInfo);
}

- (void) observer_NOTIFICATION_COULD_NOT_MAP_KEY:(NSNotification*)aNotification
{
    DebugLog(@"[%@]", aNotification.userInfo);
}

- (void) observer_NOTIFICATION_NEXTTRACK:(NSNotification*)aNotification
{
    DebugLog(@"[%@]", aNotification.userInfo);
}

- (void) observer_NOTIFICATION_SEEKFORWARD_BEGIN:(NSNotification*)aNotification
{
    DebugLog(@"[%@]", aNotification.userInfo);    
}





@end