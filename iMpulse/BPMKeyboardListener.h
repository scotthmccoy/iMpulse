//
//  BPMKeyboardListener.h
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPMKeyboardListener : NSObject <UITextViewDelegate>
{
    @private
    UITextView* txtListener;
    UITextView* txtListener2;
    BOOL isResetting;
    int numListeners;
}

@property (readwrite, strong) UIView *parentView;


+ (id) singleton;
- (id) init;
- (void) setupWithParentView:(UIView*)parent;

@end
