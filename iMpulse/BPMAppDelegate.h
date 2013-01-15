//
//  BPMAppDelegate.h
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d-iphone-2.0/cocos2d/cocos2d.h"

@interface BPMAppDelegate : UIResponder <UIApplicationDelegate, CCDirectorDelegate>
{
    CCDirectorIOS* director;
}

@property (strong, nonatomic) UIWindow *window;

@end
