//
//  BPMUtilities.m
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

//Header
#import "BPMUtilities.h"

//Cocos2d
#import "cocos2d.h"


@implementation BPMUtilities


+ (NSString *) pathForResource: (NSString *) resource
{
	NSString *basename = [[resource lastPathComponent] stringByDeletingPathExtension];
	NSString *extension = [resource pathExtension];
    
	return [[NSBundle mainBundle] pathForResource: basename ofType: extension];
}


//Successive calls cycle through a small pallete of debug colors
+ (UIColor *)debugLayoutColor
{
    //Cursor will keep a value of 1-num_debug_colors.
    static int cursor = 0;
    
    cursor++;
    
    if (cursor > 5)
        cursor = 1;
    
    switch (cursor)
    {
        default:
        case 1:
            //Red
            return [UIColor colorWithRed:255.0 green:0 blue:0 alpha:0.25];
            
        case 2:
            //Green
            return [UIColor colorWithRed:0 green:255.0 blue:0 alpha:0.25];
            
        case 3:
            //Blue
            return [UIColor colorWithRed:0 green:0 blue:255.0 alpha:0.25];
            
            
        case 4:
            //Purple
            return [UIColor colorWithRed:255.0 green:0 blue:255.0 alpha:0.25];
            
        case 5:
            //Orange
            return [UIColor colorWithRed:255.0 green:125.0 blue:125.0 alpha:0.25];
            
    }
}

+ (NSString*) pointToString:(CGPoint)point
{
    return [NSString stringWithFormat:@"(%f,%f)", point.x, point.y];
}

+ (NSString*) rectToString:(CGRect)rect
{
    return [NSString stringWithFormat:@"(%f,%f),(%fx%f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

+ (NSString*) sizeToString:(CGSize)size
{
    return [NSString stringWithFormat:@"(%fx%f)", size.width, size.height];
}

#pragma mark - Cocos Stuff that should really be in categories

//This seems to be a feature missing from cocos2d -
//The ability to make radio buttons. Drop this into a callback for a CCMenu and it will set selected on the
//current menuItem and unselected on every other one.
+ (void) cocosRadioButtons:(CCMenuItem*)menuItem
{
    for (CCMenuItem* item in menuItem.parent.children)
    {
        if (item == menuItem)
        {
            [menuItem selected];
        }
        else
        {
            [item unselected];
        }
    }
}


+ (void) runAction:(CCAction*) action onChildrenOfNode: (CCNode*) node
{
    for( CCNode *childNode in [node children])
    {
        //Visit children of nodes recursively
        [BPMUtilities runAction:action onChildrenOfNode:childNode];

        //Have to make a copy of the action, or else only the first node visited actually performs it.
        [childNode runAction:[action copy]];
    }
}

//Pass in a CCMenuItem, it returns the index of its parent's selected menu item.
+ (int) getMenuSelectedIndex:(CCMenuItem*) menuItem
{
    int selectedIndex = 0;
    
    for (CCMenuItem* item in menuItem.parent.children)
    {
        if (item == menuItem)
            return selectedIndex;
        
        selectedIndex++;
    }
    
    return -1;
}

@end
