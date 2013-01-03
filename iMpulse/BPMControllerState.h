//
//  BPMControllerState.h
//  iMpulse
//
//  Created by Scott McCoy on 1/3/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	BPMControllerButtonDPadUp = 0,
	BPMControllerButtonDPadRight,
	BPMControllerButtonDPadDown,
	BPMControllerButtonDPadLeft,
    BPMControllerButtonM,
    BPMControllerButtonV,
    BPMControllerButtonW,
    BPMControllerButtonA,
    BPMControllerButtonRightShoulder,    //"U"
    BPMControllerButtonLeftShoulder,     //"N"
} BPMControllerState;



@interface BPMControllerState : NSObject
{
}


+ (id) singleton;

@end