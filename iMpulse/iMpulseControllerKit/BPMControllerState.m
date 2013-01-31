//
//  BPMControllerState.m
//  iMpulse
//
//  Created by Scott McCoy on 1/3/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "BPMControllerState.h"

@implementation BPMControllerState


//This assumes that both players will be using the same OS Mode.
//At some point we might let each player use a different OS mode for some crazy hacking or something.
@synthesize selectedOS;

//For +singleton method
static BPMControllerState* _singleton = nil;

//Singleton method
+ (BPMControllerState*)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _singleton = [[BPMControllerState alloc] init];
    });
    
    return _singleton;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        //Default to iOS
        self.selectedOS = BPMControllerOSiOS;
        
        buttonStates = [[NSMutableArray alloc] init];
        [buttonStates addObject:[NSNull null]];                 //Treat the array as being 1-based
        [buttonStates addObject:[self createPlayerArray]];      //This is player 1
        [buttonStates addObject:[self createPlayerArray]];      //This is player 2
    }
    return self;
}

- (NSMutableArray*) createPlayerArray
{
    //Create an array
    NSMutableArray* player = [[NSMutableArray alloc] init];
    
    //Add a "false" entry for each button, indicating that the button is currently off.
    for (int i=0; i<NUM_BUTTONS; i++)
    {
        [player addObject:[NSNumber numberWithBool:NO]];
    }
    
    return player;
}


#pragma mark - Setters
- (void) setState:(BOOL)isPressed forPlayer:(int)playerNumber andButtonID:(BPMControllerButton)buttonID
{
    //DebugLogWhereAmI();
    
    //In MAW mode, we don't get key up events, so we treat the buttons as always being off.
    if (self.selectedOS == BPMControllerOSMAW)
    {
        return;
    }
    
    //Get the array of buttons owned by this player
    NSMutableArray* player = [buttonStates objectAtIndex:playerNumber];
    
    //Create a new NSNumber and replace the old one.
    [player replaceObjectAtIndex:buttonID withObject:[NSNumber numberWithBool:isPressed]];
    
    //DebugLog(@"buttonStates = [%@]", buttonStates);
}

- (BOOL) getStateForPlayer:(int)playerNumber andButtonID:(BPMControllerButton)buttonID
{
    DebugLogWhereAmI();
    
    //In MAW mode, we don't get key up events, so we treat the buttons as always being off.
    if (self.selectedOS == BPMControllerOSMAW)
    {
        return NO;
    }
    
    //Get the array of buttons owned by this player
    NSMutableArray* player = [buttonStates objectAtIndex:playerNumber];
    
    //Get the state
    NSNumber* buttonState = [player objectAtIndex:buttonID];
    
    //Return the bool value
    return [buttonState boolValue];
}


#pragma mark - OS
- (NSString*) selectedOSString
{
    return [BPMControllerState stringForBPMControllerOS:self.selectedOS];
}


+ (NSString*) stringForBPMControllerOS:(BPMControllerOS)input
{
    switch(input)
    {
        case BPMControllerOSiOS:
            return @"iOS";
            break;

        case BPMControllerOSMAW:
            return @"MAW";
            break;
    }
}


@end
