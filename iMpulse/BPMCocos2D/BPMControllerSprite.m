//
//  BPMControllerSprite.m
//  iMpulse
//
//  Created by Scott McCoy on 1/18/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMControllerSprite.h"

//Cocos2d
#import "cocos2d.h"



@implementation BPMControllerSprite

@synthesize selectedPlayer;


+ (id) sprite
{
    //node calls [self init]
    return [BPMControllerSprite node];
}

- (id) init
{
    DebugLogWhereAmI();
    if( (self=[super init]))
    {
        //Setup self
        self.ignoreAnchorPointForPosition = YES;
        
        //////////////////////////////
        //Create Some Sprites
        //////////////////////////////
        controllerFront = [CCSprite spriteWithFile:@"controller_front.png"];
        controllerFront.position = ccp(0,0);
        
        controllerBack = [CCSprite spriteWithFile:@"controller_back.png"];
        controllerBack.position = ccp(38,-120);
        
        
        controllerBackArrow = [CCSprite spriteWithFile:@"controller_backside_arrow.png"];
        controllerBackArrow.position = ccp(-107,-99);
        
        //Media Keys
        mediaPlayPause = [CCSprite spriteWithFile:@"media_playpause_overlay.png"];
        mediaPlayPause.position = ccp(0, -50);
        mediaPlayPause.opacity = 0;
        
        mediaNextTrack = [CCSprite spriteWithFile:@"media_nexttrack_overlay.png"];
        mediaNextTrack.position = ccp(0, -50);
        mediaNextTrack.opacity = 0;
        
        mediaPreviousTrack = [CCSprite spriteWithFile:@"media_previoustrack_overlay.png"];
        mediaPreviousTrack.position = ccp(0, -50);
        mediaPreviousTrack.opacity = 0;
        
        
        
        
        mediaSeekBackward = [CCSprite spriteWithFile:@"media_seekbackward_overlay.png"];
        mediaSeekBackward.position = ccp(0, -50);
        mediaSeekBackward.opacity = 0;

        
        mediaSeekForward = [CCSprite spriteWithFile:@"media_seekforward_overlay.png"];
        mediaSeekForward.position = ccp(0, -50);
        mediaSeekForward.opacity = 0;
                
        
        //////////////////////////////
        //Add main sprites to self
        //////////////////////////////
        [self addChild:controllerBackArrow];
        [self addChild:controllerFront];
        [self addChild:controllerBack];
        
        [self addChild:mediaNextTrack];
        [self addChild:mediaPreviousTrack];
        [self addChild:mediaPlayPause];
        
        
        
        
        ///////////////////////////////////////////
        //Add button highlights to Controller Front
        ///////////////////////////////////////////
        buttonDPadUpHighlight = [CCSprite spriteWithFile:@"button_dpadup_highlight.png"];
        buttonDPadUpHighlight.position = ccp(72,99);
        buttonDPadUpHighlight.opacity = 0;
        
        buttonDPadRightHighlight = [CCSprite spriteWithFile:@"button_dpadright_highlight.png"];
        buttonDPadRightHighlight.position = ccp(72,99);
        buttonDPadRightHighlight.opacity = 0;
        
        buttonDPadDownHighlight = [CCSprite spriteWithFile:@"button_dpaddown_highlight.png"];
        buttonDPadDownHighlight.position = ccp(72,99);
        buttonDPadDownHighlight.opacity = 0;
        
        buttonDPadLeftHighlight = [CCSprite spriteWithFile:@"button_dpadleft_highlight.png"];
        buttonDPadLeftHighlight.position = ccp(72,99);
        buttonDPadLeftHighlight.opacity = 0;
        
        buttonWHighlight = [CCSprite spriteWithFile:@"button_w_highlight.png"];
        buttonWHighlight.position = ccp(203,72);
        buttonWHighlight.opacity = 0;
        
        buttonMHighlight = [CCSprite spriteWithFile:@"button_m_highlight.png"];
        buttonMHighlight.position = ccp(203,124);
        buttonMHighlight.opacity = 0;
        
        buttonVHighlight = [CCSprite spriteWithFile:@"button_v_highlight.png"];
        buttonVHighlight.position = ccp(229,98);
        buttonVHighlight.opacity = 0;
        
        buttonAHighlight = [CCSprite spriteWithFile:@"button_a_highlight.png"];
        buttonAHighlight.position = ccp(175,98);
        buttonAHighlight.opacity = 0;
        
        //Add sprites to front
        [controllerFront addChild:buttonDPadUpHighlight];
        [controllerFront addChild:buttonDPadRightHighlight];
        [controllerFront addChild:buttonDPadDownHighlight];
        [controllerFront addChild:buttonDPadLeftHighlight];
        
        [controllerFront addChild:buttonWHighlight];
        [controllerFront addChild:buttonMHighlight];
        [controllerFront addChild:buttonVHighlight];
        [controllerFront addChild:buttonAHighlight];
        
        
        
        
        ///////////////////////////////////////////
        //Add button highlights to Controller Back
        ///////////////////////////////////////////
        buttonRightShoulderHighlight = [CCSprite spriteWithFile:@"button_right_shoulder_highlight.png"];
        buttonRightShoulderHighlight.position = ccp(74,56);
        buttonRightShoulderHighlight.opacity = 0;
        
        buttonLeftShoulderHighlight = [CCSprite spriteWithFile:@"button_left_shoulder_highlight.png"];
        buttonLeftShoulderHighlight.position = ccp(158,56);
        buttonLeftShoulderHighlight.opacity = 0;
        
        //Add sprites to back
        [controllerBack addChild:buttonLeftShoulderHighlight];
        [controllerBack addChild:buttonRightShoulderHighlight];
        
        
        //////////////////////////////////////////////
        //Add observers for iMpulse Controller Events
        //////////////////////////////////////////////    
        [self setupiMpulseControllerObservers];
            
        
    }
    return self;
}


- (void) setSouthpawMode:(BOOL)isOn
{
    //If it's already in the requested state, bail.
    if (isOn == southpawMode)
        return;
    
    //Set the new state
    southpawMode = isOn;
    
    //Rotate
    ccTime duration = 0.25;
    
    //Determine what angle to rotate to
    if (southpawMode)
    {
        //Rotate to upside-down
        [self runAction:[CCRotateTo actionWithDuration:duration angle:180]];
        [self runAction:[CCMoveBy actionWithDuration:duration position: ccp(0,-80)]];
    }
    else
    {
        //Rotate to upside-down
        [self runAction:[CCRotateTo actionWithDuration:duration angle:0]];
        [self runAction:[CCMoveBy actionWithDuration:duration position: ccp(0,80)]];

    }
}


#pragma mark - Observers - Media Keys generated by the optional BPMMediaKeysListenerWindow

- (void) observer_NOTIFICATION_PLAYPAUSE:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaPlayPause runAction:[CCFadeOut actionWithDuration:1.0]];
}

- (void) observer_NOTIFICATION_PREVIOUSTRACK:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaPreviousTrack runAction:[CCFadeOut actionWithDuration:1.0]];
}

- (void) observer_NOTIFICATION_NEXTTRACK:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaNextTrack runAction:[CCFadeOut actionWithDuration:1.0]];
}


- (void) observer_NOTIFICATION_SEEKFORWARD_BEGIN:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    mediaNextTrack.opacity = 255;
}

- (void) observer_NOTIFICATION_SEEKFORWARD_END:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaNextTrack runAction:[CCFadeOut actionWithDuration:1.0]];
}

- (void) observer_NOTIFICATION_SEEKBACK_BEGIN:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    mediaPreviousTrack.opacity = 255;
}

- (void) observer_NOTIFICATION_SEEKBACK_END:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaPreviousTrack runAction:[CCFadeOut actionWithDuration:1.0]];
}



#pragma mark - Observers - Player 1 Press

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadUpHighlight onlyForPlayer:1 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadRightHighlight onlyForPlayer:1 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadDownHighlight onlyForPlayer:1 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadLeftHighlight onlyForPlayer:1 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_1_V_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonVHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_M_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonMHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_W_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonWHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_A_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonAHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonRightShoulderHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonLeftShoulderHighlight onlyForPlayer:1];
}


#pragma mark - Observers - Player 1 Release
- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadUpHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadRightHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadDownHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadLeftHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_V_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonVHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_M_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonMHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_W_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonWHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_A_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonAHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonRightShoulderHighlight onlyForPlayer:1];
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonLeftShoulderHighlight onlyForPlayer:1];
}



#pragma mark - Observers - Player 1 Press

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_UP_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadUpHighlight onlyForPlayer:2 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadRightHighlight onlyForPlayer:2 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadDownHighlight onlyForPlayer:2 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonDPadLeftHighlight onlyForPlayer:2 clearDPad:YES];
}

- (void) observer_NOTIFICATION_PLAYER_2_V_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonVHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_M_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonMHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_W_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonWHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_A_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonAHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonRightShoulderHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:YES forHighlight:buttonLeftShoulderHighlight onlyForPlayer:2];
}


#pragma mark - Observers - Player 2 Release
- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_UP_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadUpHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadRightHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadDownHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonDPadLeftHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_V_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonVHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_M_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonMHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_W_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonWHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_A_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonAHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonRightShoulderHighlight onlyForPlayer:2];
}

- (void) observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self setHighlightState:NO forHighlight:buttonLeftShoulderHighlight onlyForPlayer:2];
}


#pragma mark - Highlight Toggle
- (void) setHighlightState:(BOOL)on forHighlight:(CCSprite*)sprite onlyForPlayer:(int)playerNumber clearDPad:(BOOL)clearDPad
{
    //Bail if the Player Number differs from what we expect
    if (self.selectedPlayer != playerNumber)
        return;
    
    //Don't overlap multiple D-Pad highlights
    if (clearDPad)
    {
        [self hideDPadHighlights];
    }
    
    //If we're in southpaw mode, we need the mirror of the highlight.
    CCSprite* target = [self getSpriteOrMirror:sprite];
    
    //Set it to 255 if it's now on, or 0 if it's not.
    target.opacity = on ? 255 : 0;
}


- (void) setHighlightState:(BOOL)on forHighlight:(CCSprite*)sprite onlyForPlayer:(int)playerNumber
{
    [self setHighlightState:on forHighlight:sprite onlyForPlayer:playerNumber clearDPad:NO];
}

#pragma mark - Observer Setup
- (void) setupiMpulseControllerObservers
{
    //Media Keys
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYPAUSE:) name:@"NOTIFICATION_PLAYPAUSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PREVIOUSTRACK:) name:@"NOTIFICATION_PREVIOUSTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_NEXTTRACK:) name:@"NOTIFICATION_NEXTTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_BEGIN:) name:@"NOTIFICATION_SEEKFORWARD_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_END:) name:@"NOTIFICATION_SEEKFORWARD_END" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_BEGIN:) name:@"NOTIFICATION_SEEKBACK_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_END:) name:@"NOTIFICATION_SEEKBACK_END" object:nil];
    
    //Player 1 Press
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS:) name:@"NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_V_PRESS:) name:@"NOTIFICATION_PLAYER_1_V_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_M_PRESS:) name:@"NOTIFICATION_PLAYER_1_M_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_W_PRESS:) name:@"NOTIFICATION_PLAYER_1_W_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_A_PRESS:) name:@"NOTIFICATION_PLAYER_1_A_PRESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_PRESS:) name:@"NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_PRESS:) name:@"NOTIFICATION_PLAYER_1_LEFT_SHOULDER_PRESS" object:nil];
    
    //Player 1 Release
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_UP_RELEASE:) name:@"NOTIFICATION_PLAYER_1_D_PAD_UP_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_RELEASE:) name:@"NOTIFICATION_PLAYER_1_D_PAD_RIGHT_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_RELEASE:) name:@"NOTIFICATION_PLAYER_1_D_PAD_DOWN_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE:) name:@"NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_V_RELEASE:) name:@"NOTIFICATION_PLAYER_1_V_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_M_RELEASE:) name:@"NOTIFICATION_PLAYER_1_M_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_W_RELEASE:) name:@"NOTIFICATION_PLAYER_1_W_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_A_RELEASE:) name:@"NOTIFICATION_PLAYER_1_A_RELEASE" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_RELEASE:) name:@"NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_RELEASE:) name:@"NOTIFICATION_PLAYER_1_LEFT_SHOULDER_RELEASE" object:nil];
    
    
    //Player 2 Press
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_UP_PRESS:) name:@"NOTIFICATION_PLAYER_2_D_PAD_UP_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_PRESS:) name:@"NOTIFICATION_PLAYER_2_D_PAD_RIGHT_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_PRESS:) name:@"NOTIFICATION_PLAYER_2_D_PAD_DOWN_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_PRESS:) name:@"NOTIFICATION_PLAYER_2_D_PAD_LEFT_PRESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_V_PRESS:) name:@"NOTIFICATION_PLAYER_2_V_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_M_PRESS:) name:@"NOTIFICATION_PLAYER_2_M_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_W_PRESS:) name:@"NOTIFICATION_PLAYER_2_W_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_A_PRESS:) name:@"NOTIFICATION_PLAYER_2_A_PRESS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_PRESS:) name:@"NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_PRESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_PRESS:) name:@"NOTIFICATION_PLAYER_2_LEFT_SHOULDER_PRESS" object:nil];
    
    //Player 2 Release
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_UP_RELEASE:) name:@"NOTIFICATION_PLAYER_2_D_PAD_UP_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE:) name:@"NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_RELEASE:) name:@"NOTIFICATION_PLAYER_2_D_PAD_DOWN_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_RELEASE:) name:@"NOTIFICATION_PLAYER_2_D_PAD_LEFT_RELEASE" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_V_RELEASE:) name:@"NOTIFICATION_PLAYER_2_V_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_M_RELEASE:) name:@"NOTIFICATION_PLAYER_2_M_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_W_RELEASE:) name:@"NOTIFICATION_PLAYER_2_W_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_A_RELEASE:) name:@"NOTIFICATION_PLAYER_2_A_RELEASE" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_RELEASE:) name:@"NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_RELEASE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_RELEASE:) name:@"NOTIFICATION_PLAYER_2_LEFT_SHOULDER_RELEASE" object:nil];
}

#pragma mark - Helper Methods

//Hides all the D pad highlight sprites.
//Since they are visually mutually exclusive, we do this before showing a new one.
- (void) hideDPadHighlights
{
    buttonDPadUpHighlight.opacity = 0;
    buttonDPadRightHighlight.opacity = 0;
    buttonDPadDownHighlight.opacity = 0;
    buttonDPadLeftHighlight.opacity = 0;
}

- (void) hideButtonHighlights
{
    buttonAHighlight.opacity = 0;
    buttonMHighlight.opacity = 0;
    buttonWHighlight.opacity = 0;
    buttonVHighlight.opacity = 0;
    
    buttonLeftShoulderHighlight.opacity = 0;
    buttonRightShoulderHighlight.opacity = 0;
}


- (void) reset
{
    [self hideDPadHighlights];
    [self hideButtonHighlights];
}

- (CCSprite*) getSpriteOrMirror:(CCSprite*) sprite
{
    if (!southpawMode)
        return sprite;
    
    if (sprite == buttonDPadUpHighlight)
        return buttonDPadDownHighlight;
    
    if (sprite == buttonDPadRightHighlight)
        return buttonDPadLeftHighlight;
    
    if (sprite == buttonDPadDownHighlight)
        return buttonDPadUpHighlight;
    
    if (sprite == buttonDPadLeftHighlight)
        return buttonDPadRightHighlight;
    
    if (sprite == buttonWHighlight)
        return buttonMHighlight;
    
    if (sprite == buttonMHighlight)
        return buttonWHighlight;

    if (sprite == buttonVHighlight)
        return buttonAHighlight;
    
    if (sprite == buttonAHighlight)
        return buttonVHighlight;
    
    if (sprite == buttonRightShoulderHighlight)
        return buttonLeftShoulderHighlight;
    
    if (sprite == buttonLeftShoulderHighlight)
        return buttonRightShoulderHighlight;
    
    DebugLog(@"This sprite has no mirror");
    return nil;
}


@end
