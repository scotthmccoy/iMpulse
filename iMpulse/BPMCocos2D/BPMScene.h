//
//  BPMScene.h
//  iMpulse
//
//  Created by Scott McCoy on 1/15/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

//Superclass
#import "CCScene.h"


//@class CCSprite;
@class BPMControllerSprite;

@interface BPMScene : CCScene
{
    BPMControllerSprite* controller;
}



@end
