//
//  BPMControllerSprite.m
//  iMpulse
//
//  Created by Scott McCoy on 1/18/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMControllerSprite.h"
#import "BPMUtilities.h"

//Cocos2d
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

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
        controllerFront = [CCSprite spriteWithFile:SD_OR_HD(@"controller_front.png")];
        controllerFront.position = ADJUST_CCP(ccp(-5,2));
        
        controllerBack = [CCSprite spriteWithFile:SD_OR_HD(@"controller_back.png")];
        controllerBack.position = ADJUST_CCP(ccp(30,-110));
        
        controllerBackArrow = [CCSprite spriteWithFile:SD_OR_HD(@"controller_backside_arrow.png")];
        controllerBackArrow.position = ADJUST_CCP(ccp(-112,-95));
        
        //////////////////////////////
        //Add main sprites to self
        //////////////////////////////
        [self addChild:controllerBackArrow];
        [self addChild:controllerFront];
        [self addChild:controllerBack];
        
        
        
        
        
        ///////////////////////////////////////////
        //Add button highlights to Controller Front
        ///////////////////////////////////////////
        buttonDPadUpHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_dpadup_highlight.png")];
        buttonDPadUpHighlight.position = ADJUST_REL(ccp(72,99));
        buttonDPadUpHighlight.opacity = 0;
        
        buttonDPadRightHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_dpadright_highlight.png")];
        buttonDPadRightHighlight.position = ADJUST_REL(ccp(71,100));
        buttonDPadRightHighlight.opacity = 0;
        
        buttonDPadDownHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_dpaddown_highlight.png")];
        buttonDPadDownHighlight.position = ADJUST_REL(ccp(72,102));
        buttonDPadDownHighlight.opacity = 0;
        
        buttonDPadLeftHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_dpadleft_highlight.png")];
        buttonDPadLeftHighlight.position = ADJUST_REL(ccp(73,100));
        buttonDPadLeftHighlight.opacity = 0;
        
        buttonWHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_w_highlight.png")];
        buttonWHighlight.position = ADJUST_REL(ccp(203,72));
        buttonWHighlight.opacity = 0;
        
        buttonMHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_m_highlight.png")];
        buttonMHighlight.position = ADJUST_REL(ccp(202,128));
        buttonMHighlight.opacity = 0;
        
        buttonVHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_v_highlight.png")];
        buttonVHighlight.position = ADJUST_REL(ccp(230,100));
        buttonVHighlight.opacity = 0;
        
        buttonAHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_a_highlight.png")];
        buttonAHighlight.position = ADJUST_REL(ccp(174,100));
        buttonAHighlight.opacity = 0;
        
        mediaKeyGuideFront = [CCSprite spriteWithFile:SD_OR_HD(@"media_key_guide_front.png")];
        mediaKeyGuideFront.position = ADJUST_REL(ccp(128, 99));
        mediaKeyGuideFront.opacity = 0;
        
        //Add sprites to front
        [controllerFront addChild:buttonDPadUpHighlight];
        [controllerFront addChild:buttonDPadRightHighlight];
        [controllerFront addChild:buttonDPadDownHighlight];
        [controllerFront addChild:buttonDPadLeftHighlight];
        
        [controllerFront addChild:buttonWHighlight];
        [controllerFront addChild:buttonMHighlight];
        [controllerFront addChild:buttonVHighlight];
        [controllerFront addChild:buttonAHighlight];
        
        [controllerFront addChild:mediaKeyGuideFront];
        
        
        
        ///////////////////////////////////////////
        //Add button highlights to Controller Back
        ///////////////////////////////////////////
        buttonRightShoulderHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_right_shoulder_highlight.png")];
        buttonRightShoulderHighlight.position = ADJUST_REL(ccp(75,56));
        buttonRightShoulderHighlight.opacity = 0;
        
        buttonLeftShoulderHighlight = [CCSprite spriteWithFile:SD_OR_HD(@"button_left_shoulder_highlight.png")];
        buttonLeftShoulderHighlight.position = ADJUST_REL(ccp(159,56));
        buttonLeftShoulderHighlight.opacity = 0;
        
        mediaKeyGuideBack = [CCSprite spriteWithFile:SD_OR_HD(@"media_key_guide_back.png")];
        mediaKeyGuideBack.position = ADJUST_REL(ccp(109,89));
        mediaKeyGuideBack.opacity = 0;
        
        //Add sprites to back
        [controllerBack addChild:buttonLeftShoulderHighlight];
        [controllerBack addChild:buttonRightShoulderHighlight];
        [controllerBack addChild:mediaKeyGuideBack];
        
        
        
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
        [self runAction:[CCMoveTo actionWithDuration:duration position: ccpAdd(basePosition, southpawOffset)]];
    }
    else
    {
        //Rotate to rightside-up
        [self runAction:[CCRotateTo actionWithDuration:duration angle:0]];
        [self runAction:[CCMoveTo actionWithDuration:duration position:basePosition]];

    }
}

- (void) setMediaMode:(BOOL)isOn
{
    //If it's already in the requested state, bail.
    if (isOn == mediaMode)
        return;
    
    //Set the new state
    mediaMode = isOn;
    
    //Animation Time
    ccTime duration = 0.125;
    
    
    if (mediaMode)
    {
        //Entering Media Mode

        //Rotate it to sit vertically
        [self runAction:[CCRotateTo actionWithDuration:duration angle:90]];
        
        //Move and scale to fit on screen
        [self runAction:[CCMoveTo actionWithDuration:duration position:ccpAdd(basePosition, mediaModeOffset)]];
        [self runAction:[CCScaleTo actionWithDuration:duration scale:0.88]];
        
        //Fade in the media Key Guide after a brief delay
        [mediaKeyGuideFront runAction:[CCSequence actions:[CCDelayTime actionWithDuration:duration], [CCFadeIn actionWithDuration:duration], nil]];
        [mediaKeyGuideBack runAction:[CCSequence actions:[CCDelayTime actionWithDuration:duration], [CCFadeIn actionWithDuration:duration], nil]];
    }
    else
    {
        //Leaving Media Mode
        [self runAction:[CCScaleTo actionWithDuration:duration scale:1.0]];

        //Are we in Southpaw Mode?
        if (southpawMode)
        {
            //Return to southpaw mode position and rotation
            [self runAction:[CCRotateTo actionWithDuration:duration angle:180]];
            [self runAction:[CCMoveTo actionWithDuration:duration position:ccpAdd(basePosition, southpawOffset)]];
        }
        else
        {
            //Return to base position and rotation
            [self runAction:[CCRotateTo actionWithDuration:duration angle:0]];
            [self runAction:[CCMoveTo actionWithDuration:duration position:basePosition]];
        }
        

        //Fade out the Media Guide
        [mediaKeyGuideFront runAction:[CCFadeOut actionWithDuration:duration]];
        [mediaKeyGuideBack runAction:[CCFadeOut actionWithDuration:duration]];
    }
    
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
    
    /////////////
    //Play sounds
    /////////////    
    if
    (
        target == buttonDPadUpHighlight ||
        target == buttonDPadDownHighlight ||
        target == buttonDPadLeftHighlight ||
        target == buttonDPadRightHighlight
    )
    {
        //D-Pad
        if (on)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_d_pad_press.wav"];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_d_pad_release.wav"];
        }
    }
    else if
    (
        target == buttonRightShoulderHighlight ||
        target == buttonLeftShoulderHighlight
    )
    {
        //Shoulder button
        if (on)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_shoulder_press.wav"];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_shoulder_release.wav"];
        }
    }
    else
    {
        //All other buttons
        if (on)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_button_press.wav"];
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"btn_shoulder_release.wav"];
        }
    }
}


- (void) setHighlightState:(BOOL)on forHighlight:(CCSprite*)sprite onlyForPlayer:(int)playerNumber
{
    [self setHighlightState:on forHighlight:sprite onlyForPlayer:playerNumber clearDPad:NO];
}

#pragma mark - Observer Setup
- (void) setupiMpulseControllerObservers
{    
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
    return sprite;
}


@end
