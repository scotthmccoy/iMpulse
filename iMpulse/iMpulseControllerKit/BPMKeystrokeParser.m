//
//  BPMControllerState.m
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

//Header
#import "BPMKeystrokeParser.h"

//Other
#import "BPMControllerState.h"
#import "BPMUtilities.h"

//Keys for dictionaries
#define KEY_NOTIFICATION_STRING @"notificationString"
#define KEY_NOTIFICATION_STRING_AUTO_RELEASE @"notificationStringAutoRelease"
#define KEY_BUTTON_ID @"buttonId"
#define KEY_PLAYER_NUMBER @"playerNumber"
#define KEY_IS_PRESSED @"isPressed"

//"Private" methods
@interface BPMControllerState (private)

- (NSString*) notificationStringWithBase:(NSString*)base andPlayerNumber:(int)playerNumber andPressed:(BOOL)pressed;

- (void) setKeyMapWithButtonId:(int)buttonIdInt andCharacter:(NSString*)character notificationBase:(NSString*)notificationBase playerNumber:(int)playerNumberInt isPressed:(BOOL)isPressedBool;

@end


@implementation BPMKeystrokeParser

@synthesize loggingDelegate;

//For +singleton method
static BPMKeystrokeParser* _singleton = nil;

//Singleton method
+ (BPMKeystrokeParser*)singleton
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
        //Parse the conf file!
        [self parseConfFile];
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
    {
        DebugLog(@"WARNING! truncated input: [%@]", input);
        input = [input substringToIndex:1];
    }
    
    //Get which controller event this character maps to, if any
    NSDictionary* keyMap;
    
    //The @ character (and probably other characters) cannot be encoded.
    @try
    {
         keyMap = [_keyMappings valueForKey:input];
    }
    @catch (id exception)
    {
        //Bail
        DebugLog(@"Exception: [%@] Could not map key [%@]. Bailing.", exception, input);
        return;
    }

    
    //Does a mapping for that key exist?
    if (keyMap)
    {
        //Successfully matched the key to an event. Log it.
        DebugLog(@"Key [%@] mapped to [%@]", input, keyMap);
    }
    else
    {
        //Bail
        DebugLog(@"Could not map key [%@]. Bailing.", input);

        //Log the message to the logger
        if (self.loggingDelegate)
        {
            [self.loggingDelegate log:[NSString stringWithFormat:@"Could not map key [%@].", input]];
        }
        
        return;
    }
    
    //Extract values
    NSString* notificationName = [keyMap objectForKey:KEY_NOTIFICATION_STRING];
    NSNumber* numButtonID = [keyMap objectForKey:KEY_BUTTON_ID];
    NSNumber* numIsPressed = [keyMap objectForKey:KEY_IS_PRESSED];
    NSNumber* numPlayerNumber = [keyMap objectForKey:KEY_PLAYER_NUMBER];
    
    //Convert to primitive types
    BPMControllerButton buttonID = [numButtonID intValue];
    int isPressed = [numIsPressed boolValue];
    int playerNumber = [numPlayerNumber intValue];
    
    //Consume that data
    [self updateControllerStateForButtonID:buttonID setState:isPressed forPlayer:playerNumber andPostNotification:notificationName];
    
    //Are we in MAW mode?
    if ([[BPMControllerState singleton] selectedOS] == BPMControllerOSMAW)
    {
        //Get the auto-release notification
        NSString* autoReleaseNotificationName = [keyMap objectForKey:KEY_NOTIFICATION_STRING_AUTO_RELEASE];

        //In a fraction of a second, consume the data.
        dispatch_after
        (
             dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC),
             dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
             ^{
                [self updateControllerStateForButtonID:buttonID setState:isPressed forPlayer:playerNumber andPostNotification:autoReleaseNotificationName];
             }
        );
    }
}


- (void) updateControllerStateForButtonID:(BPMControllerButton)buttonID setState:(BOOL)isPressed forPlayer:(int)playerNumber andPostNotification:(NSString*)notificationName
{
    //Update controller state
    [[BPMControllerState singleton] setState:isPressed forPlayer:playerNumber andButtonID:buttonID];
    
    //Post a notification
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
    
    //Log the message to the logger
    if (self.loggingDelegate)
    {
        [self.loggingDelegate log:notificationName];
    }
}

#pragma mark - Configuration File
- (NSString*) confFileName
{
    return @"iMpulseControllerKeyMapping.plist";
}

- (NSString*) confFilePath
{
    //Get the full path to the file
    NSString* path = [BPMUtilities pathForResource:[self confFileName]];

    //Check if it exists
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        return path;
    
    return nil;
}

- (void) parseConfFile
{
    DebugLogWhereAmI();
    
    //Set up the keyMappings dict
    _keyMappings = [[NSMutableDictionary alloc] init];
    
    //Read in the conf file
    NSDictionary* confFile = [NSDictionary dictionaryWithContentsOfFile:[self confFilePath]];
    
    //Get the controller's selected operating system.
    BPMControllerOS OS = [[BPMControllerState singleton] selectedOS];
    
    
    
    
    //Walk the data from the conf file. Extract the character, button, new state, and notification name for each.
    for (NSString* key in confFile)
    {
        //Get a dict representing a single button on the controller
        NSDictionary* button = [confFile objectForKey:key];
        
        if (OS == BPMControllerOSiOS)
        {
            BPMControllerButton buttonId = [[button valueForKeyPath:KEY_BUTTON_ID] intValue];
            
            NSString* notificationBase = [button valueForKeyPath:KEY_NOTIFICATION_STRING];

            NSString* player1KeyPress = [button valueForKeyPath:@"OS.iOS.player1KeyPress"];
            NSString* player2KeyPress = [button valueForKeyPath:@"OS.iOS.player2KeyPress"];
            
            //If it's iOS, we also need the release character            
            NSString* player1KeyRelease = [button valueForKeyPath:@"OS.iOS.player1KeyRelease"];
            NSString* player2KeyRelease = [button valueForKeyPath:@"OS.iOS.player2KeyRelease"];

            //Make key Mappings
            [self setKeyMapWithButtonId:buttonId andCharacter:player1KeyPress notificationBase:notificationBase playerNumber:1 isPressed:YES];
            [self setKeyMapWithButtonId:buttonId andCharacter:player2KeyPress notificationBase:notificationBase playerNumber:2 isPressed:YES];
            [self setKeyMapWithButtonId:buttonId andCharacter:player1KeyRelease notificationBase:notificationBase playerNumber:1 isPressed:NO];
            [self setKeyMapWithButtonId:buttonId andCharacter:player2KeyRelease notificationBase:notificationBase playerNumber:2 isPressed:NO];
        }
        else if (OS == BPMControllerOSMAW)
        {
            BPMControllerButton buttonId = [[button valueForKeyPath:KEY_BUTTON_ID] intValue];
            
            NSString* notificationBase = [button valueForKeyPath:KEY_NOTIFICATION_STRING];
            
            //For MAW mode, we don't have a mapping for the release key.
            NSString* player1KeyPress = [button valueForKeyPath:@"OS.MAW.player1KeyPress"];
            NSString* player2KeyPress = [button valueForKeyPath:@"OS.MAW.player2KeyPress"];
            
            //Make key Mappings. This will also create the auto release.
            [self setKeyMapWithButtonId:buttonId andCharacter:player1KeyPress notificationBase:notificationBase playerNumber:1 isPressed:YES];
            [self setKeyMapWithButtonId:buttonId andCharacter:player2KeyPress notificationBase:notificationBase playerNumber:2 isPressed:YES];
        }
    }
    
    DebugLog(@"_keyMappings = [%@]", _keyMappings);
}

//Concatenates together the notification string. Result is something like "NOTIFICATION_PLAYER_1_D_PAD_LEFT_RELEASE"
- (NSString*) notificationStringWithBase:(NSString*)base andPlayerNumber:(int)playerNumber andPressed:(BOOL)pressed
{
    NSString* playerString = nil;
    NSString* pressedString = nil;
    
    //Translate player number
    if (playerNumber == 1)
    {
        playerString = @"PLAYER_1";
    }
    else if (playerNumber == 2)
    {
        playerString = @"PLAYER_2";
    }
    
    //Translate pressed
    if (pressed)
    {
        pressedString = @"PRESS";
    }
    else
    {
        pressedString = @"RELEASE";
    }
    
    //Create ret
    NSString* ret = [NSString stringWithFormat:@"NOTIFICATION_%@_%@_%@", playerString, base, pressedString];
    
    //DebugLog(@"ret = [%@]", ret);
    
    return ret;
}

//Creates a button map dictionary and adds it to the collection.
//TODO: Use a data structure class (instead of NSDictionary) with getters and setters for faster access
- (void) setKeyMapWithButtonId:(int)buttonIdInt andCharacter:(NSString*)character notificationBase:(NSString*)notificationBase playerNumber:(int)playerNumberInt isPressed:(BOOL)isPressedBool
{
    //Create a dict to hold data
    NSMutableDictionary* keyMap = [[NSMutableDictionary alloc] init];
    
    //Create and set the notification string
    NSString* notification = [self notificationStringWithBase:notificationBase andPlayerNumber:playerNumberInt andPressed:isPressedBool];
    [keyMap setValue:notification forKey:KEY_NOTIFICATION_STRING];

    //Are we in MAW mode?
    if ([[BPMControllerState singleton] selectedOS] == BPMControllerOSMAW)
    {
        //Also create an auto-release notification
        //Create and set the notification string
        NSString* notification = [self notificationStringWithBase:notificationBase andPlayerNumber:playerNumberInt andPressed:NO];
        [keyMap setValue:notification forKey:KEY_NOTIFICATION_STRING_AUTO_RELEASE];
    }
    
    //Create and set the buttonID
    NSNumber* buttonId = [NSNumber numberWithInt:buttonIdInt];
    [keyMap setValue:buttonId forKey:KEY_BUTTON_ID];
    
    //Create and set the playerNumber
    NSNumber* playerNumber = [NSNumber numberWithInt:playerNumberInt];
    [keyMap setValue:playerNumber forKey:KEY_PLAYER_NUMBER];
    
    //Create and set the isPressed
    NSNumber* isPressed = [NSNumber numberWithBool:isPressedBool];
    [keyMap setValue:isPressed forKey:KEY_IS_PRESSED];
    
    //Add the keyMap to _keyMappings
    [_keyMappings setValue:keyMap forKey:character];
}


@end
