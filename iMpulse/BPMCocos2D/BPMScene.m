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
    CCSprite* bg = [CCSprite spriteWithFile:@"background.png"];
    bg.ignoreAnchorPointForPosition = YES;
    
    ///////////////
    //Create tabs
    ///////////////
    CCMenuItemImage * menuItem1 = [CCMenuItemImage itemWithNormalImage:@"btn_help_inactive.png"
                                                         selectedImage: @"btn_help_active.png"
                                                                target:self
                                                              selector:@selector(doSomethingOne:)];
    
    CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"btn_info_inactive.png"
                                                         selectedImage: @"btn_info_active.png"
                                                                target:self
                                                              selector:@selector(doSomethingTwo:)];
    
    
    CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"btn_main_inactive.png"
                                                         selectedImage: @"btn_main_active.png"
                                                                target:self
                                                              selector:@selector(doSomethingThree:)]; 
    
    
    // Create a menu and add your menu items to it
    CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    
    // Arrange the menu items vertically
    [myMenu alignItemsHorizontally];
    myMenu.position = ccp(415,297);

    
    
    
    //Create the controller sprite
    controller = [BPMControllerSprite sprite];
    controller.position = ccp(315,180);
    
    //Add Sprites
    [self addChild:bg];
    [self addChild:controller];
    [self addChild:myMenu];    
    
}
                      
                      
- (void) doSomethingOne: (CCMenuItem  *) menuItem
{
	NSLog(@"The first menu was called");
}
- (void) doSomethingTwo: (CCMenuItem  *) menuItem
{
	NSLog(@"The second menu was called");
}
- (void) doSomethingThree: (CCMenuItem  *) menuItem
{
	NSLog(@"The third menu was called");
}








@end
