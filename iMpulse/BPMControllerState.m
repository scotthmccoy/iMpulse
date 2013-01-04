//
//  BPMControllerState.m
//  iMpulse
//
//  Created by Scott McCoy on 1/3/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "BPMControllerState.h"

@implementation BPMControllerState

//For +singleton method
static BPMControllerState* _singleton = nil;

//Singleton method
+ (id)singleton
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

    }
    return self;
}

- (BOOL) isKeyDown:(NSString*)keyName
{
    return YES;
}


#pragma mark - OS
- (BPMControllerOS) selectedOS
{
    //TODO MAW mode as well
    return BPMControllerOSiOS;
}

- (NSString*) selectedOSString
{
    return [BPMControllerState stringForBPMControllerOS:[self selectedOS]];
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
