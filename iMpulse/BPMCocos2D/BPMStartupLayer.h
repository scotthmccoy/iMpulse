//
//  BPMStartupScene.h
//  iMpulse
//
//  Created by Scott McCoy on 2/6/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import "cocos2d.h"

@interface BPMStartupLayer :CCLayer

+ (id) layer;
- (void) doneSetupWithIsMAW:(BOOL)isMaw andIsMedia:(BOOL)isMedia andIsPlayer2:(BOOL)isPlayer2 andIsSouthPaw:(BOOL)isSouthPaw;

@end
