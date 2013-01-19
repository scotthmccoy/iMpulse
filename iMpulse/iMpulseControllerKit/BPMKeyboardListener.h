//
//  BPMKeyboardListener.h
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

//Protocol
#import "BPMLoggingDelegate.h"

@interface BPMKeyboardListener : NSObject <UITextViewDelegate>
{
    @private
    UITextView* txtListener;
    BOOL isResetting;
}

@property (readwrite) id<BPMLoggingDelegate> loggingDelegate;

+ (BPMKeyboardListener*)singleton;
- (id) init;
- (void) setupWithParentView:(UIView*)parent;

@end
