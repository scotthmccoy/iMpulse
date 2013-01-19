//
//  BPMKeystrokeParserLoggingDelegate.h
//  iMpulse
//
//  Created by Scott McCoy on 1/19/13.
//  Copyright (c) 2013 Scott McCoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPMLoggingDelegate <NSObject>
    - (void) log:(NSString*)message;
@end
