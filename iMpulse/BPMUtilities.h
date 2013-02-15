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
+ (NSString*) sizeToString:(CGSize)size;

+ (void) cocosRadioButtons:(CCMenuItem*)menuItem;
+ (void) runAction:(CCAction*) action onChildrenOfNode: (CCNode*) node;

#import <UIKit/UIDevice.h>

/*  DETERMINE THE DEVICE USED  */
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (NO)
#endif

/*  NORMAL DETAILS */
#define kScreenHeight       480
#define kScreenWidth        320

/* OFFSETS TO ACCOMMODATE IPAD */
#define kXoffsetiPad        32
#define kYoffsetiPad        64

#define SD_PNG      @".png"
#define HD_PNG      @"-hd.png"

#define ADJUST_CCP(__p__)       \
(IS_IPAD() == YES ?             \
ccp( ( __p__.x * 2 ) + kXoffsetiPad, ( __p__.y * 2 ) + kYoffsetiPad ) : __p__)

#define ADJUST_REL(__p__)       \
(IS_IPAD() == YES ?             \
ccp( ( __p__.x * 2 ) , ( __p__.y * 2 ) ) : __p__)

#define REVERSE_CCP(__p__)      \
(IS_IPAD() == YES ?             \
ccp( ( __p__.x - kXoffsetiPad ) / 2, ( __p__.y - kYoffsetiPad ) / 2 ) : __p__)

#define ADJUST_XY(__x__, __y__)     \
(IS_IPAD() == YES ?                     \
ccp( ( __x__ * 2 ) + kXoffsetiPad, ( __y__ * 2 ) + kYoffsetiPad ) : ccp(__x__, __y__))

#define ADJUST_X(__x__)         \
(IS_IPAD() == YES ?             \
( __x__ * 2 ) + kXoffsetiPad : __x__)

#define ADJUST_Y(__y__)         \
(IS_IPAD() == YES ?             \
( __y__ * 2 ) + kYoffsetiPad : __y__)

#define HD_PIXELS(__pixels__)       \
(IS_IPAD() == YES ?             \
( __pixels__ * 2 ) : __pixels__)

#define HD_TEXT(__size__)   \
(IS_IPAD() == YES ?         \
( __size__ * 1.5 ) :  __size__)

#define SD_OR_HD(__filename__)  \
(IS_IPAD() == YES ?             \
[__filename__ stringByReplacingOccurrencesOfString:SD_PNG withString:HD_PNG] :  __filename__)

@end
