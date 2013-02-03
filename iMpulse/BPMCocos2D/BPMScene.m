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

//For logging delegate
#import "BPMKeystrokeParser.h"
#import "BPMMediaKeysListenerWindow.h"
#import "BPMKeyboardListener.h"

//Other
#import "BPMUtilities.h"
#import "BPMControllerState.h"

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
    CCSprite* bg = [CCSprite spriteWithFile:@"bgScene.png"];
    bg.ignoreAnchorPointForPosition = YES;
    
    ///////////////
    //Create tabs
    ///////////////
    CCMenuItemImage* mnuDevTool = [CCMenuItemImage itemWithNormalImage:@"btn_devtool_inactive.png"
                                                         selectedImage: @"btn_devtool_active.png"
                                                                target:self
                                                              selector:@selector(callback_mnuDevTool:)];
    
    CCMenuItemImage* mnuInstructions = [CCMenuItemImage itemWithNormalImage:@"btn_instructions_inactive.png"
                                                              selectedImage: @"btn_instructions_active.png"
                                                                     target:self
                                                                   selector:@selector(callback_mnuInstructions:)];
        
    
    CCMenuItemImage* mnuMain = [CCMenuItemImage itemWithNormalImage:@"btn_main_inactive.png"
                                                         selectedImage: @"btn_main_active.png"
                                                                target:self
                                                              selector:@selector(callback_mnuMain:)];
    
    
    // Create a menu and add your menu items to it
    tabMenu = [CCMenu menuWithItems:mnuDevTool, mnuInstructions, mnuMain, nil];
    
    //Position the menu
    tabMenu.position = ccp(415,297);
    mnuDevTool.position = ccp(-43,0);
    mnuInstructions.position = ccp(0,0);
    mnuMain.position = ccp(43,0);
    
    
    ///////////////////
    //Create Main Layer
    ///////////////////
    lyrMain = [[CCLayer alloc] init];
    lyrMain.visible = NO;

    ////////////////////////////////////
    //Add OS iOS/MAW mode buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_os_ios = [CCMenuItemImage itemWithNormalImage:@"btn_os_ios.png"
                                                         selectedImage:@"btn_os_maw.png"
                                                                target:self
                                                              selector:nil];
    
    btn_os_maw = [CCMenuItemImage itemWithNormalImage:@"btn_os_maw.png"
                                                         selectedImage:@"btn_os_ios.png"
                                                                target:self
                                                              selector:nil];
    
    //Create a toggleItem out of the buttons
    CCMenuItemToggle *btn_os_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_os_toggle:) items:btn_os_ios, btn_os_maw, nil];
    btn_os_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    CCMenu *mnu_os_toggle = [CCMenu menuWithItems:btn_os_toggle, nil];
    
    //Position the menu
    mnu_os_toggle.position = ccp(3, 216);
    
    
    //Add the menu
    [lyrMain addChild:mnu_os_toggle];
    
    
    
    
    
    ////////////////////////////////////
    //Add media mode / game mode buttons
    ////////////////////////////////////    

    //Add Buttons
    btn_game = [CCMenuItemImage itemWithNormalImage:@"btn_game.png"
                                                       selectedImage:@"btn_media.png"
                                                              target:self
                                                            selector:nil];

    btn_media = [CCMenuItemImage itemWithNormalImage:@"btn_media.png"
                                                      selectedImage:@"btn_game.png"
                                                             target:self
                                                           selector:nil];
    
    //Create a toggleItem out of the buttons
    CCMenuItemToggle *btn_game_media_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_game_media_toggle:) items:btn_game, btn_media, nil];
    btn_game_media_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    CCMenu *mnu_game_media_toggle = [CCMenu menuWithItems:btn_game_media_toggle, nil];
    
    //Position the menu
    mnu_game_media_toggle.position = ccp(3, 178);

    
    //Add the menu
    [lyrMain addChild:mnu_game_media_toggle];
    
    
    ////////////////////////////////////
    //Add player 1 & player 2 buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_player_1 = [CCMenuItemImage itemWithNormalImage:@"btn_player_1.png"
                                                       selectedImage:@"btn_player_2.png"
                                                              target:self
                                                            selector:nil];
    
    btn_player_2 = [CCMenuItemImage itemWithNormalImage:@"btn_player_2.png"
                                                        selectedImage:@"btn_player_1.png"
                                                               target:self
                                                             selector:nil];
    
    //Create a toggleItem out of the buttons
    CCMenuItemToggle *btn_player_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_player_toggle:) items:btn_player_1, btn_player_2, nil];
    btn_player_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    CCMenu *mnu_player_toggle = [CCMenu menuWithItems:btn_player_toggle, nil];
    
    //Position the menu
    mnu_player_toggle.position = ccp(3, 66);
    
    
    //Add the menu
    [lyrMain addChild:mnu_player_toggle];
    
    
    ////////////////////////////////////
    //Add orientations buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_orientation_right = [CCMenuItemImage itemWithNormalImage:@"btn_orientation_right.png"
                                                           selectedImage:@"btn_orientation_left.png"
                                                                  target:self
                                                                selector:nil];
    
    btn_orientation_left = [CCMenuItemImage itemWithNormalImage:@"btn_orientation_left.png"
                                                           selectedImage:@"btn_orientation_right.png"
                                                                  target:self
                                                                selector:nil];
    
    //Create a toggleItem out of the buttons
    CCMenuItemToggle *btn_orientation_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_orientation_toggle:) items:btn_orientation_right, btn_orientation_left, nil];
    btn_orientation_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    CCMenu *mnu_orientation_toggle = [CCMenu menuWithItems:btn_orientation_toggle, nil];
    
    //Position the menu
    mnu_orientation_toggle.position = ccp(3, 2);
    
    //Add the menu
    [lyrMain addChild:mnu_orientation_toggle];

    
    
    
    //////////////////////////////
    //Create the controller sprite
    //////////////////////////////
    controller = [BPMControllerSprite sprite];
    controller.position = ccp(320,180);

    //Make it a bit smaller
    //controller.scale = 0.85;
    
    //Set the player to 1
    controller.selectedPlayer = 1;
    
    //Add it
    [lyrMain addChild:controller];
    
    
    
    ///////////////////
    //Create DevTool Layer
    ///////////////////
    lyrDevTool = [[CCLayer alloc] init];
    lyrDevTool.visible = NO;
    
    //Create its background
    CCSprite* bgDevTool = [CCSprite spriteWithFile:@"bgDevTool.png"];
    bgDevTool.ignoreAnchorPointForPosition = YES;
    bgDevTool.position = ccp(26,15);
    

    
    //Create label
    lblDevTool = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(428, 248) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeWordWrap  fontName:@"Courier New" fontSize:10.0];
    lblDevTool.position = ccp(30,13);
    lblDevTool.ignoreAnchorPointForPosition = YES;    

    //Become the logging delegate for all the controller kit classes.
    [BPMKeystrokeParser singleton].loggingDelegate = self;
    [BPMKeyboardListener singleton].loggingDelegate = self;
    [BPMMediaKeysListenerWindow singleton].loggingDelegate = self;

    //Create log array and mutable string
    arrayLog = [[NSMutableArray alloc] init];
    strLog = [[NSMutableString alloc] init];

    
    //Create dateFormatter
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    [dateFormat setTimeStyle:NSDateFormatterLongStyle];
    
    
    //Add Children
    [lyrDevTool addChild:bgDevTool];
    [lyrDevTool addChild:lblDevTool];
    
    
    
    ///////////////////
    //Create Instructions Layer
    ///////////////////
    lyrInstructions = [[CCLayer alloc] init];
    lyrInstructions.visible = NO;
    
    CCSprite* bgInstructions = [CCSprite spriteWithFile:@"bgInstructions.png"];
    bgInstructions.ignoreAnchorPointForPosition = YES;
    [lyrInstructions addChild:bgInstructions];
    
    //////////////////////////
    //Create Media Key Sprites
    //////////////////////////
    CGPoint mediaKeyOverlayPosition = ccp(480/2, 320/2);
    
    mediaPlayPause = [CCSprite spriteWithFile:@"media_playpause_overlay.png"];
    mediaPlayPause.position = mediaKeyOverlayPosition;
    mediaPlayPause.opacity = 0;
    
    mediaNextTrack = [CCSprite spriteWithFile:@"media_nexttrack_overlay.png"];
    mediaNextTrack.position = mediaKeyOverlayPosition;
    mediaNextTrack.opacity = 0;
    
    mediaPreviousTrack = [CCSprite spriteWithFile:@"media_previoustrack_overlay.png"];
    mediaPreviousTrack.position = mediaKeyOverlayPosition;
    mediaPreviousTrack.opacity = 0;
    
    mediaSeekBackward = [CCSprite spriteWithFile:@"media_seekback_overlay.png"];
    mediaSeekBackward.position = mediaKeyOverlayPosition;
    mediaSeekBackward.opacity = 0;
    
    mediaSeekForward = [CCSprite spriteWithFile:@"media_seekforward_overlay.png"];
    mediaSeekForward.position = mediaKeyOverlayPosition;
    mediaSeekForward.opacity = 0;
    
    
    //Media Keys
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYPAUSE:) name:@"NOTIFICATION_PLAYPAUSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PREVIOUSTRACK:) name:@"NOTIFICATION_PREVIOUSTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_NEXTTRACK:) name:@"NOTIFICATION_NEXTTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_BEGIN:) name:@"NOTIFICATION_SEEKFORWARD_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_END:) name:@"NOTIFICATION_SEEKFORWARD_END" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_BEGIN:) name:@"NOTIFICATION_SEEKBACK_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_END:) name:@"NOTIFICATION_SEEKBACK_END" object:nil];
    
    
    ///////////////////////
    //Add children to self
    ///////////////////////

    //Add the bg
    [self addChild:bg];

    //Add the layers that contain the tab content
    [self addChild:lyrDevTool];
    [self addChild:lyrInstructions];
    [self addChild:lyrMain];

    //Add the tabs above the layers
    [self addChild:tabMenu];
    
    //Add media sprites above everything
    [self addChild:mediaPlayPause];
    [self addChild:mediaNextTrack];
    [self addChild:mediaPreviousTrack];
    [self addChild:mediaSeekBackward];
    [self addChild:mediaSeekForward];
    
    //Select the Main tab
    [mnuMain activate];
    
    //Put a message into the log so that it looks ready to receive input.
    [self log:@"DEVTOOL READY TO ACCEPT CONTROLLER INPUT."];
}

#pragma mark - Menu Button Callbacks
- (void) callback_mnuDevTool: (CCMenuItem  *) menuItem
{
    //DebugLogWhereAmI();
    
    //Treat the menu as radio buttons
    [BPMUtilities cocosRadioButtons:menuItem];

    //Toggle layer visibility
    lyrMain.visible = NO;
    lyrInstructions.visible = NO;
    lyrDevTool.visible = YES;
}

- (void) callback_mnuInstructions: (CCMenuItem  *) menuItem
{
    //DebugLogWhereAmI();
    
    //Treat the menu as radio buttons
    [BPMUtilities cocosRadioButtons:menuItem];
    
    //Toggle layer visibility
    lyrMain.visible = NO;
    lyrInstructions.visible = YES;
    lyrDevTool.visible = NO;
}

- (void) callback_mnuMain: (CCMenuItem  *) menuItem
{
    //DebugLogWhereAmI();
    
    //Treat the menu as radio buttons
    [BPMUtilities cocosRadioButtons:menuItem];
    
    //Toggle layer visibility
    lyrMain.visible = YES;
    lyrInstructions.visible = NO;
    lyrDevTool.visible = NO;
}

#pragma mark - Main Page Button Callbacks

- (void) callback_btn_game_media_toggle: (CCMenuItemToggle  *) menuItem
{
    if (menuItem.selectedIndex == 0)
    {
        DebugLog(@"Game Mode");
    }
    else if (menuItem.selectedIndex == 1)
    {
        DebugLog(@"Media Mode");
    }
}

- (void) callback_btn_os_toggle: (CCMenuItemToggle  *) menuItem
{
    //Clear all highlights
    [controller reset];
    
    if (menuItem.selectedIndex == 0)
    {
        DebugLog(@"iOS Mode");
        [BPMControllerState singleton].selectedOS = BPMControllerOSiOS;
    }
    else if (menuItem.selectedIndex == 1)
    {
        DebugLog(@"MAW Mode");
        [BPMControllerState singleton].selectedOS = BPMControllerOSMAW;
    }
    
    //Set up the keystroke parser for the newly-selected OS
    [[BPMKeystrokeParser singleton] parseConfFile];
}

- (void) callback_btn_player_toggle: (CCMenuItemToggle  *) menuItem
{
    //Clear all highlights
    [controller reset];
    
    if (menuItem.selectedIndex == 0)
    {
        DebugLog(@"Player 1");
        controller.selectedPlayer = 1;
    }
    else if (menuItem.selectedIndex == 1)
    {
        DebugLog(@"Player 2");
        controller.selectedPlayer = 2;
    }
}

- (void) callback_btn_orientation_toggle: (CCMenuItemToggle  *) menuItem
{
    if (menuItem.selectedIndex == 0)
    {
        DebugLog(@"Right-Handed Mode");
        [controller setSouthpawMode:NO];
    }
    else if (menuItem.selectedIndex == 1)
    {
        DebugLog(@"Southpaw Mode");
        [controller setSouthpawMode:YES];
    }
}

#pragma mark - BPMKeystrokeParserLoggingDelegate
- (void) log:(NSString*)message
{
    //Force onto main thread
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self log:message];
        });
        
        return;
    }
    

    //Create the log message
    NSString* strDate = [dateFormat stringFromDate:[NSDate date]];
    NSString* logMessage = [NSString stringWithFormat:@"[%@] %@", strDate, message];
    
    //Add it to the rolling log
    [arrayLog addObject:logMessage];
    
    //If it's more than 20 items, remove the oldest.
    if ([arrayLog count] > 20)
    {
        [arrayLog removeObjectAtIndex:0];
    }
    
    //Walk the array and make the string that will go into the label
    for (NSString* msg in arrayLog)
    {
        [strLog appendFormat:@"%@\n", msg];
    }
    
    //Set the label string
    lblDevTool.string = strLog;
    
    //Wipe out strLog
    [strLog setString:@""];
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
    mediaSeekForward.opacity = 255;
}

- (void) observer_NOTIFICATION_SEEKFORWARD_END:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaSeekForward runAction:[CCFadeOut actionWithDuration:1.0]];
}

- (void) observer_NOTIFICATION_SEEKBACK_BEGIN:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    mediaSeekBackward.opacity = 255;
}

- (void) observer_NOTIFICATION_SEEKBACK_END:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [mediaSeekBackward runAction:[CCFadeOut actionWithDuration:1.0]];
}



@end
