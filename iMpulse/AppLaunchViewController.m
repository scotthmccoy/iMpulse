//
//  BPM.m
//  iMpulse
//
//  Created by Scott McCoy on 1/4/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "AppLaunchViewController.h"

@implementation AppLaunchViewController


- (void) viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    if (![self isFirstResponder])
    {
        DebugLogWhereAmI();
    }
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}



@end
