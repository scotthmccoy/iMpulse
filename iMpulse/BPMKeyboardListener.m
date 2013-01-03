//
//  BPMKeyboardListener.m
//  iMpulse
//
//  Created by Scott McCoy on 12/28/12.
//  Copyright (c) 2012 Scott McCoy. All rights reserved.
//

//Header
#import "BPMKeyboardListener.h"

//State Machine for Controller
#import "BPMControllerState.h"




//For +instance Singleton method
static BPMKeyboardListener* _instance = nil;

@implementation BPMKeyboardListener


//Singleton method
+ (id)instance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _instance = [[BPMKeyboardListener alloc] init];
    });
    
    return _instance;
}


- (id) init
{
    self = [super init];
    
    if (self)
    {
        //Create the TextView that will act as the listener.
        txtListener = [[UITextField alloc] init];
        
        //////////////////////////////////////////////////
        //Make the Text Field as unobtrusive as possible.
        //////////////////////////////////////////////////
        
        //Make the frame very small, and position it off-screen.
        txtListener.frame = CGRectMake(-100, -100, 1, 1);
        
        //Make the color, alpha and BG color transparent
        txtListener.backgroundColor = [UIColor clearColor];
        txtListener.textColor = [UIColor clearColor];
        txtListener.alpha = 0;
        
        //Set the input view to a blank UIView.
        //This will prevent the keyboard from showing up when we set the txtListener as the firstResponder
        txtListener.inputView = [[UIView alloc] init];
        

        //Call keyPressed when the text view changes
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(observer_UITextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object: nil];
    }
    return self;
}


- (void) setParentView:(UIView*)parent
{
    //Remove it from whatever view it's in
    [txtListener removeFromSuperview];
    
    //Add it to the passed-in view
    [parent addSubview: txtListener];
    
    //Have it start consuming keyboard input
    [txtListener becomeFirstResponder];
}


- (void)observer_UITextFieldTextDidChangeNotification:(NSNotification *)aNotification
{
    NSLog(@"[%@]", txtListener.text);
    
    [[BPMControllerState instance] takeInput:txtListener.text];
    
    txtListener.text = @"";
}

@end
