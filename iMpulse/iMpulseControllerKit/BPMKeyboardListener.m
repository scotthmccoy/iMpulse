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
#import "BPMKeystrokeParser.h"

//Utils
#import "BPMUtilities.h"

#define TEXT @"aaaa"


@implementation BPMKeyboardListener


//For +singleton method
static BPMKeyboardListener* _singleton = nil;
//Singleton method
+ (id)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Set the ivar
        _singleton = [[BPMKeyboardListener alloc] init];
    });
    
    return _singleton;
}


- (id) init
{
    self = [super init];
    
    if (self)
    {
        //Touch the BMPControllerState
        //Why do we do this again?
        [BPMKeystrokeParser singleton];
    }
    return self;
}


- (void) setupWithParentView:(UIView*)inParentView
{
    //Create the TextView that will act as the listener
    txtListener = [[UITextView alloc] init];
 
    
    //////////////////////////////////////////////////
    //Make the Text Field as unobtrusive as possible.
    //////////////////////////////////////////////////
    
    if (DEBUG_MODE_VISIBLE_TEXT_ENTRY)
    {
        //If the debug mode is on, put it right spang in the middle of the screen.
        
        txtListener.frame = CGRectMake(25, 25, 50, 20);
        txtListener.backgroundColor = [BPMUtilities debugLayoutColor];
        txtListener.textColor = [UIColor whiteColor];
    }
    else
    {
        //Make the frame very small, and position it off-screen.
        txtListener.frame = CGRectMake(-100, -100, 50, 20);
        
        //Make the color, alpha and BG color transparent
        txtListener.backgroundColor = [UIColor clearColor];
        txtListener.textColor = [UIColor clearColor];
        txtListener.alpha = 0;
    }
    
    //Set the input view to a blank UIView.
    //This will prevent the keyboard from showing up when we set the txtListener as the firstResponder
    txtListener.inputView = [[UIView alloc] init];
    
    
    //Add it to the passed-in view
    [inParentView addSubview: txtListener];

    
    /////////////////////////////////////////////
    //Begin receiving selection and text changes.
    /////////////////////////////////////////////

    //Have to do this before changing the text and selectedRange or it will delay processing those events.
    txtListener.delegate = self;

    //Prevent processing events for setting up the listener.
    isResetting = YES;    
    
    //Change text. We use 4 letters and place the cursor in the middle.
    //If the user hits left or right, the cursor moves one space, but if they hit up or down, it moves to the beginning or end of the line.
    //We can detect changes in the cursor position using textViewDidChangeSelection.
    txtListener.text = @"aaaa";  
        
    //Now that it's been added as a subView, it can receive focus.
    [txtListener becomeFirstResponder];
    
    //It's slightly better to change the selectedRange after becoming firstResponder so that
    //it doesn't start scrolled slightly downwards.
    txtListener.selectedRange = NSMakeRange(2, 0);

    //Allow processing of events.
    isResetting = NO;
}






/////////////////////
//Callbacks
/////////////////////

#pragma UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (isResetting)
    {
        //DebugLog(@"Resetting. Bailing..");
        return YES;
    }
    
    //Send the input to the parser
    [[BPMKeystrokeParser singleton] takeInput:text];
    
    //Tell it not to actually change the text.
    return NO;
}


//When the controller is in MAW mode and player1 mode, it sends arrow key events instead of characters.
//To parse these, we set up a UITextView and watch for the cursor changing positions.
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    //Get the cursor location
    int cursorLocation = textView.selectedRange.location;
    
    //Don't process this if we're in the middle of resetting the UITextView.
    if (isResetting)
    {
        DebugLog(@"Resetting. Bailing with pos = [%i]", cursorLocation);
        return;
    }
    

    DebugLog(@"pos = [%i]", cursorLocation);

    NSString* notificationName = nil;
    
    //Where is the cursor?
    switch (cursorLocation)
    {
        case 0:
            DebugLog(@"Up Arrow Pressed");
            notificationName = @"NOTIFICATION_PLAYER_1_D_PAD_UP_PRESS";
            break;
            
        case 1:
            DebugLog(@"Left Arrow Pressed");
            notificationName = @"NOTIFICATION_PLAYER_1_D_PAD_LEFT_PRESS";
            break;
            
        case 3:
            DebugLog(@"Right Arrow Pressed");
            notificationName = @"NOTIFICATION_PLAYER_1_D_PAD_RIGHT_PRESS";
            break;
            
        case 4:
            DebugLog(@"Down Arrow Pressed");
            notificationName = @"NOTIFICATION_PLAYER_1_D_PAD_DOWN_PRESS";            
            break;
            
        default:
            DebugLog(@"Unknwown arrow input. Pos = [%i]", cursorLocation);
            break;
    }

    //Post the notification
    if (notificationName)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    //We have to textViewDidChangeSelection finish completely before changing the selectedRange
    //So, we do it off the main thread.
    ///////////////////////////////////////////////////////////////////////////////////////////    

    //Halt any modifications until the thread completes
    isResetting = YES;
    
    //Dispatch a thread
    dispatch_async(dispatch_get_main_queue(),^{
        
        //Change cursor position
        txtListener.selectedRange = NSMakeRange(2, 0);

        //Re-allow modifications
        isResetting = NO;
    });
    
}

@end