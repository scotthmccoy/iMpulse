//
//  BPMControllerState.h
//  iMpulse
//
//  Created by Scott McCoy on 1/3/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

//There are 10 buttons on the controller.
#define NUM_BUTTONS 10

//IDs for each button
typedef enum
{
	BPMControllerButtonDPadUp = 0,
	BPMControllerButtonDPadRight = 1,
	BPMControllerButtonDPadDown = 2,
	BPMControllerButtonDPadLeft = 3,
    BPMControllerButtonM = 4,
    BPMControllerButtonV = 5,
    BPMControllerButtonW = 6,
    BPMControllerButtonA = 7,
    BPMControllerButtonRightShoulder = 8,    //"U"
    BPMControllerButtonLeftShoulder = 9,     //"N"
} BPMControllerButton;

//IDs for the OSes.
typedef enum
{
	BPMControllerOSiOS = 0,
	BPMControllerOSMAW = 1
} BPMControllerOS;



@interface BPMControllerState : NSObject
{
    NSMutableArray* buttonStates;
}


+ (BPMControllerState*)singleton;


#pragma mark - getters and setters
- (void) setState:(BOOL)isPressed forPlayer:(int)playerNumber andButtonID:(BPMControllerButton)buttonID;
- (BOOL) getStateForPlayer:(int)playerNumber andButtonID:(BPMControllerButton)buttonID;

#pragma mark - OS
@property BPMControllerOS selectedOS;
- (NSString*) selectedOSString;
+ (NSString*) stringForBPMControllerOS:(BPMControllerOS)input;



@end