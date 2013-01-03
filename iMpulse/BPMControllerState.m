//
//  BPMControllerState.m
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import "BPMControllerState.h"
#import "BPMUtilities.h"

@implementation BPMControllerState

//For +instance Singleton method
static BPMControllerState* _instance = nil;

//Singleton method
+ (id)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _instance = [[BPMControllerState alloc] init];
    });
    
    return _instance;
}


- (id) init
{
    self = [super init];
    
    if (self)
    {
        //Read in a conf file and set up a dictionary of key names, down signal character, up signal character, and isDown key state
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[self confFilePath]];
        DebugLog(@"dict = [%@]", dict);
    }
    return self;
}


#pragma mark - input
- (void) takeInput:(NSString*) input
{
    
    
}

#pragma mark - Configuration File

- (NSString*) confFileName
{
    return @"iMpulseControllerKeyMapping.plist";
}

- (NSString*) confFilePath
{
    NSString* path = [BPMUtilities pathForResource:[self confFileName]];

    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        return path;
    
    return nil;
}

@end
