//
//  BPMControllerState.h
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPMControllerState : NSObject

+ (id) instance;
- (id) init;
- (void) takeInput:(NSString*) input;

@end
