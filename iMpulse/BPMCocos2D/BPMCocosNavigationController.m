//
//  BPMCocosNavigationController.m
//  iMpulse
//
//  Created by Scott McCoy on 1/16/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "BPMCocosNavigationController.h"

@implementation BPMCocosNavigationController

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}


@end
