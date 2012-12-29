//
//  BPMKeyboardListener.h
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPMKeyboardListener : NSObject
{
    @private
    UITextField* txtListener;
}

+ (id) instance;
- (id) init;
- (void) setParentView:(UIView*)parent;

@end