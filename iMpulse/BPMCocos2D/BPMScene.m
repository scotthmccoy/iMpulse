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
    CCMenuItemImage* mnuInstructions = [CCMenuItemImage itemWithNormalImage:@"btn_instructions_inactive.png"
                                                         selectedImage: @"btn_instructions_active.png"
                                                                target:self
                                                              selector:@selector(callback_mnuInstructions:)];
    
    CCMenuItemImage* mnuDevTool = [CCMenuItemImage itemWithNormalImage:@"btn_devtool_inactive.png"
                                                         selectedImage: @"btn_devtool_active.png"
                                                                target:self
                                                              selector:@selector(callback_mnuDevTool:)];
    
    
    CCMenuItemImage* mnuMain = [CCMenuItemImage itemWithNormalImage:@"btn_main_inactive.png"
                                                         selectedImage: @"btn_main_active.png"
                                                                target:self
                                                              selector:@selector(callback_mnuMain:)];
    
    
    // Create a menu and add your menu items to it
    tabMenu = [CCMenu menuWithItems:mnuInstructions, mnuDevTool, mnuMain, nil];
    
    // Arrange the menu items vertically
    [tabMenu alignItemsHorizontally];
    tabMenu.position = ccp(415,297);

    
    
    
    ///////////////////
    //Create Main Layer
    ///////////////////
    lyrMain = [[CCLayer alloc] init];
    lyrMain.visible = NO;
    
    //Create the controller sprite
    controller = [BPMControllerSprite sprite];
    controller.position = ccp(315,180);
    [lyrMain addChild:controller];
    
    //TODO: add all the other buttons
    
    
    
    
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
    
    //TODO: add a UITextView

    //TODO: make the Kit have a delegate Logging method, and point it here.
    
    
    
    
    
    ///////////////////
    //Create Instructions Layer
    ///////////////////
    lyrInstructions = [[CCLayer alloc] init];
    lyrInstructions.visible = NO;
    
    CCSprite* bgInstructions = [CCSprite spriteWithFile:@"bgInstructions.png"];
    bgInstructions.ignoreAnchorPointForPosition = YES;
    [lyrInstructions addChild:bgInstructions];
    
    
    ///////////////////////
    //Add children to self
    ///////////////////////
    [self addChild:bg];

    [self addChild:lyrDevTool];
    [self addChild:lyrInstructions];
    [self addChild:lyrMain];
    
    [self addChild:tabMenu];
    
    //Select the Main tab
    [mnuMain activate];
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




@end
