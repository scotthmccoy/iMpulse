//
//  BPMControllerState.m
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import "BPMKeystrokeParser.h"
#import "BPMUtilities.h"

@implementation BPMKeystrokeParser

//For +singleton method
static BPMKeystrokeParser* _singleton = nil;

//Singleton method
+ (id)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _singleton = [[BPMKeystrokeParser alloc] init];
    });
    
    return _singleton;
}


- (id) init
{
    self = [super init];
    
    if (self)
    {
        //Set up the keyMappings dict
        _keyMappings = [[NSMutableDictionary alloc] init];
        
        //Read in the conf file
        NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[self confFilePath]];

        
        //Walk the data from the conf file. Extract the character and notification name for each.
        for (NSString* key in dict)
        {
            //Get a dict representing a single button on the controller
            NSDictionary* button = [dict objectForKey:key];
            
            //Extract some values
            NSString* pressCharacter = [button valueForKeyPath:@"press.character"];
            NSString* pressNotificationName = [button valueForKeyPath:@"press.notificationName"];
            
            NSString* releaseCharacter = [button valueForKeyPath:@"release.character"];
            NSString* releaseNotificationName = [button valueForKeyPath:@"release.notificationName"];
            
            //Set them into the keyMappings dict
            [_keyMappings setValue:pressNotificationName forKey:pressCharacter];
            [_keyMappings setValue:releaseNotificationName forKey:releaseCharacter];
        }
        
        DebugLog(@"_keyMappings = [%@]", _keyMappings);
            

    }
    return self;
}


#pragma mark - input
- (void) takeInput:(NSString*) input
{
    //Bail if there's nothing there
    if (input == nil || [input length] == 0)
        return;
    
    //Truncate to 1 character
    if ([input length] > 1)
        input = [input substringToIndex:1];
    
    //Get which controller event this character maps to, if any
    NSString* notificationName = [_keyMappings valueForKey:input];
    
    //Bail if it doesn't map to anything.
    if (!notificationName)
    {
        DebugLog(@"Ignorning junk data [%@] from input!", input);
        return;
    }
        
    //Successfully matched the key to an event. Log it.
    DebugLog(@"Key [%@] mapped to [%@]", input, notificationName);
    
    
    //Need to set the button state BEFORE posting a notification.
    
    
    //Post a notification
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
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
