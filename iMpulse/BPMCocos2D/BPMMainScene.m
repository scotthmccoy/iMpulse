//
//  BPMScene.m
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Header
#import "BPMMainScene.h"

//Cocos
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "BPMControllerSprite.h"
#import "BPMStartupLayer.h"

//For logging delegate
#import "BPMKeystrokeParser.h"
#import "BPMMediaKeysListenerWindow.h"
#import "BPMKeyboardListener.h"

//Other
#import "BPMUtilities.h"
#import "BPMControllerState.h"

//disable debug test areas on left
#define TOUCHTOGGLE NO  // YES=enable; NO==disable
#define TOUCHOPAQUE 255 // 0==enable; 255==disable

@implementation BPMMainScene

@synthesize allowModeChangeOverlays = _allowModeChangeOverlays;

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
    CCSprite* bg = [CCSprite spriteWithFile:SD_OR_HD(@"bgScene.png")];
    bg.position = ADJUST_CCP(ccp(0,0));
    bg.ignoreAnchorPointForPosition = YES;
    
    ///////////////
    //Create tabs
    ///////////////
    CCMenuItemImage* mnuDevTool = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_devtool_inactive.png")
                                                         selectedImage:SD_OR_HD(@"btn_devtool_active.png")
                                                                target:self
                                                              selector:@selector(callback_mnuDevTool:)];
    
    CCMenuItemImage* mnuInstructions = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_instructions_inactive.png")
                                                              selectedImage:SD_OR_HD(@"btn_instructions_active.png")
                                                                     target:self
                                                                   selector:@selector(callback_mnuInstructions:)];
        
    
    CCMenuItemImage* mnuMain = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_main_inactive.png")
                                                        selectedImage:SD_OR_HD(@"btn_main_active.png")
                                                                target:self
                                                              selector:@selector(callback_mnuMain:)];
    
    
    // Create a menu and add your menu items to it
    tabMenu = [CCMenu menuWithItems:mnuDevTool, mnuInstructions, mnuMain, nil];
    
    //Position the menu
    tabMenu.position = ADJUST_CCP(ccp(415,297));
    mnuDevTool.position = ADJUST_REL(ccp(-43,0));
    mnuInstructions.position = ADJUST_REL(ccp(0,0));
    mnuMain.position = ADJUST_REL(ccp(43,0));
    
    
    ///////////////////
    //Create Main Layer
    ///////////////////
    lyrMain = [[CCLayer alloc] init];
    lyrMain.visible = NO;

    ////////////////////////////////////
    //Add OS iOS/MAW mode buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_os_ios = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_os_ios.png")
                                                         selectedImage:SD_OR_HD(@"btn_os_maw.png")
                                                                target:self
                                                              selector:nil];
    
    btn_os_maw = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_os_maw.png")
                                                         selectedImage:SD_OR_HD(@"btn_os_ios.png")
                                                                target:self
                                                              selector:nil];
    
    //Create a toggleItem out of the buttons
    btn_os_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_os_toggle:) items:btn_os_ios, btn_os_maw, nil];
    btn_os_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    mnu_os_toggle = [CCMenu menuWithItems:btn_os_toggle, nil];
    
    //Position the menu
    mnu_os_toggle.position = ADJUST_CCP(ccp(3, 216));
    mnu_os_toggle.isTouchEnabled = TOUCHTOGGLE;

    
    //Add the menu
    [lyrMain addChild:mnu_os_toggle];
    
    
    
    
    
    ////////////////////////////////////
    //Add media mode / game mode buttons
    ////////////////////////////////////    

    //Add Buttons
    btn_game = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_game.png")
                                                       selectedImage:SD_OR_HD(@"btn_media.png")
                                                              target:self
                                                            selector:nil];

    btn_media = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_media.png")
                                                      selectedImage:SD_OR_HD(@"btn_game.png")
                                                             target:self
                                                           selector:nil];
    
    //Create a toggleItem out of the buttons
    btn_game_media_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_game_media_toggle:) items:btn_game, btn_media, nil];
    btn_game_media_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    mnu_game_media_toggle = [CCMenu menuWithItems:btn_game_media_toggle, nil];
    
    //Position the menu
    mnu_game_media_toggle.position = ADJUST_CCP(ccp(3, 178));
    mnu_game_media_toggle.isTouchEnabled = TOUCHTOGGLE;

    
    //Add the menu
    [lyrMain addChild:mnu_game_media_toggle];
    
    
    ////////////////////////////////////
    //Add player 1 & player 2 buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_player_1 = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_player_1.png")
                                                       selectedImage:SD_OR_HD(@"btn_player_2.png")
                                                              target:self
                                                            selector:nil];
    
    btn_player_2 = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_player_2.png")
                                                        selectedImage:SD_OR_HD(@"btn_player_1.png")
                                                               target:self
                                                             selector:nil];
    
    //Create a toggleItem out of the buttons
    btn_player_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_player_toggle:) items:btn_player_1, btn_player_2, nil];
    btn_player_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    mnu_player_toggle = [CCMenu menuWithItems:btn_player_toggle, nil];
    
    //Position the menu
    mnu_player_toggle.position = ADJUST_CCP(ccp(3, 66));
    mnu_player_toggle.isTouchEnabled = TOUCHTOGGLE;
    
    
    //Add the menu
    [lyrMain addChild:mnu_player_toggle];
    
    
    ////////////////////////////////////
    //Add orientations buttons
    ////////////////////////////////////
    
    //Add Buttons
    btn_orientation_right = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_orientation_right.png")
                                                           selectedImage:SD_OR_HD(@"btn_orientation_left.png")
                                                                  target:self
                                                                selector:nil];
    
    btn_orientation_left = [CCMenuItemImage itemWithNormalImage:SD_OR_HD(@"btn_orientation_left.png")
                                                           selectedImage:SD_OR_HD(@"btn_orientation_right.png")
                                                                  target:self
                                                                selector:nil];
    
    //Create a toggleItem out of the buttons
    btn_orientation_toggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(callback_btn_orientation_toggle:) items:btn_orientation_right, btn_orientation_left, nil];
    btn_orientation_toggle.ignoreAnchorPointForPosition = YES;
    
    //Create a single-item menu out of the toggle item
    mnu_orientation_toggle = [CCMenu menuWithItems:btn_orientation_toggle, nil];
    
    //Position the menu
    mnu_orientation_toggle.position = ADJUST_CCP(ccp(3, 2));
    mnu_orientation_toggle.isTouchEnabled = TOUCHTOGGLE;
    
    //Add the menu
    [lyrMain addChild:mnu_orientation_toggle];

    
    
    //////////////////////////////////////////////////////////////////////////////////////////
    //Create hidden overlay to block Orientation and Player Select buttons while in Media mode
    //////////////////////////////////////////////////////////////////////////////////////////
    mediaModeButtonBlockerOverlay = [CCSprite spriteWithFile:SD_OR_HD(@"media_player_and_orientation_overlay.png")];
    mediaModeButtonBlockerOverlay.ignoreAnchorPointForPosition = YES;
    mediaModeButtonBlockerOverlay.position = ADJUST_CCP(ccp(2,3));
    mediaModeButtonBlockerOverlay.opacity = 0;
    [lyrMain addChild:mediaModeButtonBlockerOverlay];
    
    
    //////////////////////////////////////////////////////////////////////////////////////////
    //Create hidden overlay to block OS buttons while in Media mode
    //////////////////////////////////////////////////////////////////////////////////////////
    mediaModeOSButtonBlockerOverlay = [CCSprite spriteWithFile:SD_OR_HD(@"btn_os_media_overlay.png")];
    mediaModeOSButtonBlockerOverlay.ignoreAnchorPointForPosition = YES;
    mediaModeOSButtonBlockerOverlay.position = ADJUST_CCP(ccp(3,216));
    mediaModeOSButtonBlockerOverlay.opacity = 0;
    [lyrMain addChild:mediaModeOSButtonBlockerOverlay];
    
    
    //////////////////////////////
    //Create the controller sprite
    //////////////////////////////
    controller = [BPMControllerSprite sprite];
    controller.position = basePosition;

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
    CCSprite* bgDevTool = [CCSprite spriteWithFile:SD_OR_HD(@"bgDevTool.png")];
    bgDevTool.ignoreAnchorPointForPosition = YES;
    bgDevTool.position = ADJUST_CCP(ccp(26,15));
    

    
    //Create label
//    lblDevTool = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(428, 248) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeWordWrap  fontName:@"Courier New" fontSize:9.75];
    lblDevTool = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(HD_PIXELS(428), HD_PIXELS(248)) hAlignment:kCCTextAlignmentLeft lineBreakMode:kCCLineBreakModeWordWrap  fontName:@"Courier New" fontSize:HD_PIXELS(10)];
    lblDevTool.position = ADJUST_CCP(ccp(30,13));
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
    [dateFormat setDateFormat:@"HH:mm:ss"];
    
    //Add Children
    [lyrDevTool addChild:bgDevTool];
    [lyrDevTool addChild:lblDevTool];
    
    
    
    ///////////////////
    //Create Instructions Layer
    ///////////////////
    lyrInstructions = [[CCLayer alloc] init];
    lyrInstructions.visible = NO;
    
    CCSprite* bgInstructions = [CCSprite spriteWithFile:SD_OR_HD(@"bgInstructions.png")];
    bgInstructions.position=ADJUST_CCP(ccp(0,0));
    bgInstructions.ignoreAnchorPointForPosition = YES;
    [lyrInstructions addChild:bgInstructions];
    
    //////////////////////////
    //Create Media Key Sprites
    //////////////////////////
    CGPoint overlayPosition = ADJUST_CCP(ccp(480/2, 320/2));
    
    mediaPlayPause = [CCSprite spriteWithFile:@"media_playpause_overlay.png"];
    mediaPlayPause.position = overlayPosition;
    mediaPlayPause.opacity = 0;
    
    mediaNextTrack = [CCSprite spriteWithFile:@"media_nexttrack_overlay.png"];
    mediaNextTrack.position = overlayPosition;
    mediaNextTrack.opacity = 0;
    
    mediaPreviousTrack = [CCSprite spriteWithFile:@"media_previoustrack_overlay.png"];
    mediaPreviousTrack.position = overlayPosition;
    mediaPreviousTrack.opacity = 0;
    
    mediaSeekBackward = [CCSprite spriteWithFile:@"media_seekback_overlay.png"];
    mediaSeekBackward.position = overlayPosition;
    mediaSeekBackward.opacity = 0;
    
    mediaSeekForward = [CCSprite spriteWithFile:@"media_seekforward_overlay.png"];
    mediaSeekForward.position = overlayPosition;
    mediaSeekForward.opacity = 0;
    
    
    //Create mode overlay sprite
    modeGame = [CCSprite spriteWithFile:SD_OR_HD(@"mode_game_overlay.png")];
    modeGame.position = overlayPosition;
    modeGame.opacity = 0;
    
    modeMedia = [CCSprite spriteWithFile:SD_OR_HD(@"mode_media_overlay.png")];
    modeMedia.position = overlayPosition;
    modeMedia.opacity = 0;

    modeIOS = [CCSprite spriteWithFile:SD_OR_HD(@"mode_ios_overlay.png")];
    modeIOS.position = overlayPosition;
    modeIOS.opacity = 0;
    
    modeMAW = [CCSprite spriteWithFile:SD_OR_HD(@"mode_maw_overlay.png")];
    modeMAW.position = overlayPosition;
    modeMAW.opacity = 0;
    
    modeLeft = [CCSprite spriteWithFile:SD_OR_HD(@"mode_left_overlay.png")];
    modeLeft.position = overlayPosition;
    modeLeft.opacity = 0;
    
    modeRight = [CCSprite spriteWithFile:SD_OR_HD(@"mode_right_overlay.png")];
    modeRight.position = overlayPosition;
    modeRight.opacity = 0;
    
    modePlayer1 = [CCSprite spriteWithFile:SD_OR_HD(@"mode_player1_overlay.png")];
    modePlayer1.position = overlayPosition;
    modePlayer1.opacity = 0;
    
    modePlayer2 = [CCSprite spriteWithFile:SD_OR_HD(@"mode_player2_overlay.png")];
    modePlayer2.position = overlayPosition;
    modePlayer2.opacity = 0;
    
    //////////////////////
    //Create Startup Layer
    //////////////////////
    startupLayer = [BPMStartupLayer layer];
    startupLayer.scene = self;

    //Don't allow mode change overlays yet
    self.allowModeChangeOverlays = NO;
    
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
    
    [self addChild:modeGame];
    [self addChild:modeMedia];
    [self addChild:modeIOS];
    [self addChild:modeMAW];
    [self addChild:modeLeft];
    [self addChild:modeRight];
    [self addChild:modePlayer1];
    [self addChild:modePlayer2];
    
    [self addChild:startupLayer];

    
    
    
    /////////////
    //Other setup
    /////////////
    
    //Add observers for Mode Change notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_MEDIA:) name:@"NOTIFICATION_MODE_MEDIA" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_GAME:) name:@"NOTIFICATION_MODE_GAME" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_MAW:) name:@"NOTIFICATION_MODE_MAW" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_IOS:) name:@"NOTIFICATION_MODE_IOS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_LEFT:) name:@"NOTIFICATION_MODE_LEFT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_RIGHT:) name:@"NOTIFICATION_MODE_RIGHT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_PLAYER1:) name:@"NOTIFICATION_MODE_PLAYER1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_MODE_PLAYER2:) name:@"NOTIFICATION_MODE_PLAYER2" object:nil];
    
    //Add observers for Media Key notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PLAYPAUSE:) name:@"NOTIFICATION_PLAYPAUSE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_PREVIOUSTRACK:) name:@"NOTIFICATION_PREVIOUSTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_NEXTTRACK:) name:@"NOTIFICATION_NEXTTRACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_BEGIN:) name:@"NOTIFICATION_SEEKFORWARD_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKFORWARD_END:) name:@"NOTIFICATION_SEEKFORWARD_END" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_BEGIN:) name:@"NOTIFICATION_SEEKBACK_BEGIN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observer_NOTIFICATION_SEEKBACK_END:) name:@"NOTIFICATION_SEEKBACK_END" object:nil];

    
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
        
        //Put the controller sprite into media mode
        [controller setMediaMode:NO];

        //Hide the overlay
        mediaModeButtonBlockerOverlay.opacity = 0;
        mediaModeOSButtonBlockerOverlay.opacity = 0;
        
        //Enable the menus
        mnu_player_toggle.isTouchEnabled = TOUCHTOGGLE;
        mnu_orientation_toggle.isTouchEnabled = TOUCHTOGGLE;
        
        //Unhide the Player Menu
        mnu_player_toggle.opacity = 255;
    }
    else if (menuItem.selectedIndex == 1)
    {
        DebugLog(@"Media Mode");
        
        //Take the controller sprite out of media mode
        [controller setMediaMode:YES];
        
        //Hide the overlay
        mediaModeButtonBlockerOverlay.opacity = 255;
        mediaModeOSButtonBlockerOverlay.opacity = 255;
        
        //Disable the menus
        mnu_player_toggle.isTouchEnabled = NO;
        mnu_orientation_toggle.isTouchEnabled = NO;
        
        //Hide the Player Menu
        mnu_player_toggle.opacity = 0;
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
    
    //Replace Newlines
    logMessage = [logMessage stringByReplacingOccurrencesOfString:@"\n" withString:@"NEWLINE"];
    
    //Truncate to 70 chars
    if ([logMessage length] > 70)
    {
        // define the range you're interested in
        NSRange stringRange = {0, MIN([logMessage length], 67)};
        
        // adjust the range to include dependent chars
        stringRange = [logMessage rangeOfComposedCharacterSequencesForRange:stringRange];
        
        // Now you can create the short string
        logMessage = [logMessage substringWithRange:stringRange];
        
        // Add ellipses
        logMessage = [NSString stringWithFormat:@"%@...", logMessage];
    }
    
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




#pragma mark - Observers - Mode Changes
- (void) observer_NOTIFICATION_MODE_MEDIA:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeMedia];
    
    //Select Media Mode
    btn_game_media_toggle.selectedIndex = 0;
    [btn_game_media_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_GAME:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeGame];
    
    //Select Game Mode
    btn_game_media_toggle.selectedIndex = 1;
    [btn_game_media_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_MAW:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeMAW];
    
    //Select OS Mode
    btn_os_toggle.selectedIndex = 0;
    [btn_os_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_IOS:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeIOS];
    
    //Select OS Mode
    btn_os_toggle.selectedIndex = 1;
    [btn_os_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_LEFT:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeLeft];
    
    //Select Orientation Mode
    btn_orientation_toggle.selectedIndex = 0;
    [btn_orientation_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_RIGHT:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modeRight];
    
    //Select Orientation Mode
    btn_orientation_toggle.selectedIndex = 1;
    [btn_orientation_toggle activate];
    
}

- (void) observer_NOTIFICATION_MODE_PLAYER1:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modePlayer1];
    
    //Select Player 1
    btn_player_toggle.selectedIndex = 1;
    [btn_player_toggle activate];
}

- (void) observer_NOTIFICATION_MODE_PLAYER2:(NSNotification*)aNotification
{
    DebugLogWhereAmI();
    [self modeChangeFadeout:modePlayer2];
    
    //Select Player 2
    btn_player_toggle.selectedIndex = 0;
    [btn_player_toggle activate];
}


#pragma mark - Mode Change Fadeout
- (void) modeChangeFadeout:(CCSprite*) sprite
{
    if (!self.allowModeChangeOverlays)
        return;
    
    //Fade in the mode change overlay
    [sprite runAction:[CCSequence actions:
                       [CCFadeIn actionWithDuration:0.25],
                       [CCDelayTime actionWithDuration:1.0],
                       [CCFadeOut actionWithDuration:0.25],
                       nil]];
    
    //Play a sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"mode_change_detected.wav"];
}

@end
