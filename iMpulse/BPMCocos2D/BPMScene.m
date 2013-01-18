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
    
    //Add observers for iMpulse Controller Events
    [self setupiMpulseControllerObservers];
    
    //////////////////////////////
    //Create Some Sprites
    //////////////////////////////
    controllerFront = [CCSprite spriteWithFile:@"controller_front.png"];
    controllerFront.position = ccp(0,0);
    
    controllerBack = [CCSprite spriteWithFile:@"controller_back.png"];
    controllerBack.position = ccp(40,-120);
    
    
    controllerBackArrow = [CCSprite spriteWithFile:@"controller_backside_arrow.png"];
    controllerBackArrow.position = ccp(-107,-99);
    
    //Create a container to hold the other sprites
    controllerContainer = [CCSprite node];
    controllerContainer.ignoreAnchorPointForPosition = YES;
    
    //controllerContainer.anchorPoint = ccp(0,0);
    controllerContainer.position = ccp(250,200);

    //////////////////////////////
    //Add main sprites to screen
    //////////////////////////////
    [controllerContainer addChild:controllerBackArrow];
    [controllerContainer addChild:controllerFront];
    [controllerContainer addChild:controllerBack];
    [self addChild:controllerContainer];
    



    
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
    buttonUHighlight = [CCSprite spriteWithFile:@"button_u_highlight.png"];
    buttonUHighlight.position = ccp(69,58);
    buttonUHighlight.opacity = 0;
    
    buttonNHighlight = [CCSprite spriteWithFile:@"button_n_highlight.png"];
    buttonNHighlight.position = ccp(151,58);
    buttonNHighlight.opacity = 0;
    
    [controllerBack addChild:buttonNHighlight];
    [controllerBack addChild:buttonUHighlight];
}


- (void)update:(ccTime)dt
{
    DebugLogWhereAmI();
}






#pragma mark - Observers - Player 1 Press

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self hideDPadHighlights];
    buttonDPadUpHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self hideDPadHighlights];
    buttonDPadRightHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self hideDPadHighlights];
    buttonDPadDownHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    [self hideDPadHighlights];
    buttonDPadLeftHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_V_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonVHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_M_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonMHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_W_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonWHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_A_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonAHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonNHighlight.opacity = 255;
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonUHighlight.opacity = 255;
}


#pragma mark - Observers - Player 1 Release
- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonDPadUpHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonDPadRightHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonDPadDownHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonDPadLeftHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_V_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonVHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_M_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonMHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_W_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonWHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_A_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonAHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonNHighlight.opacity = 0;
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
    buttonUHighlight.opacity = 0;
}



#pragma mark - Observers - Player 2 Press

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_UP_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_V_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_M_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_W_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_A_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

#pragma mark - Observers - Player 2 Release

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_UP_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_RIGHT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_DOWN_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_D_PAD_LEFT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_V_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_M_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_W_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_A_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_RIGHT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_2_LEFT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
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
- (void) hideDPadHighlights
{
    buttonDPadUpHighlight.opacity = 0;
    buttonDPadRightHighlight.opacity = 0;
    buttonDPadDownHighlight.opacity = 0;
    buttonDPadLeftHighlight.opacity = 0;
}

@end
