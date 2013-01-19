//
//  BPMUtilities.h
//  iMpulse
//
//  Created by Scott McCoy on 12/29/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCMenuItem;
@class CCAction;
@class CCNode;

@interface BPMUtilities : NSObject

+ (NSString *) pathForResource: (NSString *) resource;
+ (UIColor *) debugLayoutColor;

+ (NSString*) rectToString:(CGRect)rect;
+ (NSString*) pointToString:(CGPoint)point;

+ (void) cocosRadioButtons:(CCMenuItem*)menuItem;
+ (void) runAction:(CCAction*) action onChildrenOfNode: (CCNode*) node;

@end
