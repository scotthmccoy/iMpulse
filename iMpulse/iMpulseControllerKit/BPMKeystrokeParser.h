//
//  BPMControllerState.h
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

//Protocol
#import "BPMLoggingDelegate.h"

//For enum
#import "BPMControllerState.h"

@interface BPMKeystrokeParser : NSObject
{
    NSDictionary* _keyMappings;
}

@property (readwrite) id<BPMLoggingDelegate> loggingDelegate;

+ (BPMKeystrokeParser*)singleton;
- (id) init;
- (void) takeInput:(NSString*) input;
- (NSString*) notificationStringWithBase:(NSString*)base andPlayerNumber:(int)playerNumber andPressed:(BOOL)pressed;

- (void) parseConfFile;
- (void) updateControllerStateForButtonID:(BPMControllerButton)buttonID setState:(BOOL)isPressed forPlayer:(int)playerNumber andPostNotification:(NSString*)notificationName withKeyName:(NSString*)input andLog:(NSString*)logMessage;
@end