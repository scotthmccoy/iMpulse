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
    //Add sprites to screen
    //////////////////////////////
    [controllerContainer addChild:controllerBackArrow];
    [controllerContainer addChild:controllerFront];
    [controllerContainer addChild:controllerBack];
    [self addChild:controllerContainer];
    

//    DebugLog(@"controllerContainer.contentSize = %f, %f", controllerContainer.boundingBox.size.width, controllerContainer.boundingBox.size.height);
//    [controllerContainer setTextureRect:CGRectMake( 0, 0, controllerContainer.contentSize.width, controllerContainer.contentSize.height)];
//    controllerContainer.color = ccORANGE;
    

    
}


- (void)update:(ccTime)dt
{
    DebugLogWhereAmI();
}






#pragma mark - Observers - Player 1 Press

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

- (void) observer_NOTIFICATION_PLAYER_1_V_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_M_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_W_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_A_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_PRESS:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

#pragma mark - Observers - Player 1 Release

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_UP_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_RIGHT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_DOWN_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_V_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_M_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_W_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_A_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_RIGHT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
}

- (void) observer_NOTIFICATION_PLAYER_1_LEFT_SHOULDER_RELEASE:(NSNotification *)aNotification
{
    DebugLogWhereAmI();
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



@end
