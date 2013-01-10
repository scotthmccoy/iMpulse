//
//  BPMUtilities.m
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import "BPMUtilities.h"

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

@end
