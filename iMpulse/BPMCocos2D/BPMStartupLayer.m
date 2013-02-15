//
//  BPMStartupScene.m
//  iMpulse
//
//  Created by Scott McCoy on 2/6/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMStartupLayer.h"
#import "BPMUtilities.h"

//Cocos
#import "cocos2d.h"
#import "BPMMainScene.h"


@implementation BPMStartupLayer

@synthesize scene=_scene;

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
        CCSprite* bg = [CCSprite spriteWithFile:SD_OR_HD(@"bgStartup.png")];
        bg.position=ADJUST_CCP(ccp(0,0));
        bg.ignoreAnchorPointForPosition = YES;
        
        //Add the bg
        [self addChild:bg];
        
        //Set up listeners for all possible "M" key notifications.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_M_PRESS:) name:@"NOTIFICATION_PLAYER_1_M_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_M_PRESS:) name:@"NOTIFICATION_PLAYER_2_M_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_W_PRESS:) name:@"NOTIFICATION_PLAYER_1_W_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_W_PRESS:) name:@"NOTIFICATION_PLAYER_2_W_PRESS" object:nil];


        
        //Media
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_NEXTTRACK:) name:@"NOTIFICATION_NEXTTRACK" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_BEGIN:) name:@"NOTIFICATION_SEEKFORWARD_BEGIN" object:nil];        
        
        
        //Maw
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE:) name:@"NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_V_RELEASE:) name:@"NOTIFICATION_PLAYER_1_V_RELEASE" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_M_RELEASE:) name:@"NOTIFICATION_PLAYER_1_M_RELEASE" object:nil];        

        
        
        //Unknown
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_COULD_NOT_MAP_KEY:) name:@"NOTIFICATION_COULD_NOT_MAP_KEY" object:nil];
        
    }
    
    return self;
}


- (void) doneSetupWithIsMAW:(BOOL)isMaw andIsMedia:(BOOL)isMedia andIsPlayer2:(BOOL)isPlayer2 andIsSouthPaw:(BOOL)isSouthPaw
{
    DebugLogWhereAmI();
    DebugLog(@"Is MAW: [%i], isMedia: [%i], isPlayer2:[%i], isSouthPaw:[%i]", isMaw, isMedia, isPlayer2, isSouthPaw);
    
    
    //Kill all observers
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (isMaw)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MODE_MAW" object:nil];
    }
    
    if (isMedia)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MODE_MEDIA" object:nil];
    }

    if (isPlayer2)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MODE_PLAYER2" object:nil];
    }
    
    if (isSouthPaw)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_MODE_LEFT" object:nil];
    }
    
    //Turn on mode overlays
    self.scene.allowModeChangeOverlays = YES;
    self.scene = nil;
    
    //TODO: Fade the bg sprite and at the end of that sequence, remove the layer.
    [self removeFromParentAndCleanup:NO];
}


#pragma mark - Observers

//iOS. If we get an M Press Event, we know it's in normal orientation mode
- (void) observer_NOTIFICATION_PLAYER_1_M_PRESS:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer2:NO andIsSouthPaw:NO];
}

- (void) observer_NOTIFICATION_PLAYER_2_M_PRESS:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer2:YES andIsSouthPaw:NO];
}

//iOS. If we get an W Press Event, we know it's in Southpaw orientation mode
- (void) observer_NOTIFICATION_PLAYER_1_W_PRESS:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer2:YES andIsSouthPaw:YES];
}

- (void) observer_NOTIFICATION_PLAYER_2_W_PRESS:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:NO andIsMedia:NO andIsPlayer2:YES andIsSouthPaw:YES];
}


//If we get a media event, we know it's in media mode.
- (void) observer_NOTIFICATION_NEXTTRACK:(NSNotification*)aNotification
{
    //Get the Key
    NSString* key = [aNotification.userInfo objectForKey:@"input"];
    DebugLog(@"[%@]", key);
    
    [self doneSetupWithIsMAW:NO andIsMedia:YES andIsPlayer2:NO andIsSouthPaw:NO];
}

- (void) observer_NOTIFICATION_SEEKFORWARD_BEGIN:(NSNotification*)aNotification
{
    //Get the Key
    NSString* key = [aNotification.userInfo objectForKey:@"input"];
    DebugLog(@"[%@]", key);
    
    [self doneSetupWithIsMAW:NO andIsMedia:YES andIsPlayer2:NO andIsSouthPaw:NO];
}

#pragma mark - Maw Mode
//If the controller is in MAW Mode, then the 
- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:YES andIsMedia:NO andIsPlayer2:NO andIsSouthPaw:NO];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:YES andIsMedia:NO andIsPlayer2:NO andIsSouthPaw:YES];
}

- (void) observer_NOTIFICATION_PLAYER_1_V_RELEASE:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:YES andIsMedia:NO andIsPlayer2:YES andIsSouthPaw:NO];
}

- (void) observer_NOTIFICATION_PLAYER_1_M_RELEASE:(NSNotification*)aNotification
{
    [self doneSetupWithIsMAW:YES andIsMedia:NO andIsPlayer2:YES andIsSouthPaw:YES];    
}














@end