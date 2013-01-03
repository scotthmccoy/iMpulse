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

@end
