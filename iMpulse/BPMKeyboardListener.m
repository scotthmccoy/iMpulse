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

//For +singleton method
static BPMKeyboardListener* _singleton = nil;


@interface BPMKeyboardListener (Private)

@end

@implementation BPMKeyboardListener

@synthesize parentView;


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
    
    //Keep this for if the selection changes and we have to destroy and re-create the txtListener
    self.parentView = inParentView;
    

    
    
    //////////////////////////////////////////////////
    //Create the Listener
    //////////////////////////////////////////////////
    
    //Setup the txtListener
    if (txtListener)
    {
        //Remove it from whatever view it's in
        [txtListener resignFirstResponder];
        [txtListener removeFromSuperview];
        txtListener = nil;
    }
    
    //Create the TextView that will act as the listener.
    txtListener = [[UITextView alloc] init];
    
    //Begin receiving selection changes.
    //Have to do this before changing the text and selectedRange or it will delay processing those events.
    txtListener.delegate = self;
    
    isResetting = YES;
    
    txtListener.text = @"aaaa";
    
    txtListener.selectedRange = NSMakeRange(2, 0);
    
    //isResetting = NO;
    
    //////////////////////////////////////////////////
    //Make the Text Field as unobtrusive as possible.
    //////////////////////////////////////////////////
    
    if (DEBUG_MODE_VISIBLE_TEXT_ENTRY)
    {
        txtListener.frame = CGRectMake(100, 100, 320, 480);
        txtListener.backgroundColor = [BPMUtilities debugLayoutColor];
        txtListener.textColor = [UIColor blackColor];
    }
    else
    {
        //Make the frame very small, and position it off-screen.
        txtListener.frame = CGRectMake(-100, -100, 1, 1);
        
        //Make the color, alpha and BG color transparent
        txtListener.backgroundColor = [UIColor clearColor];
        txtListener.textColor = [UIColor clearColor];
        txtListener.alpha = 0;
    }
    
    //Set the input view to a blank UIView.
    //This will prevent the keyboard from showing up when we set the txtListener as the firstResponder
    txtListener.inputView = [[UIView alloc] init];
    

    
    //////////////////////////////////////////////////
    //Finish Setup
    //////////////////////////////////////////////////
    
    //Add it to the passed-in view
    [self.parentView addSubview: txtListener];
    
    //Have it start consuming keyboard input
    [txtListener becomeFirstResponder];
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
    
    //Get the character
    NSString* input = [textView.text substringWithRange:range];
    
    //Send the input to the parser
    [[BPMKeystrokeParser singleton] takeInput:input];
    
    //Tell it not to actually change the text.
    return NO;
}



- (void)textViewDidChangeSelection:(UITextView *)textView
{
    //Don't process this if we're in the middle of resetting the UITextView.
    if (isResetting)
    {
        //DebugLog(@"Resetting. Bailing..");
        isResetting = NO;
        return;
    }
    
    int pos = textView.selectedRange.location;
    
    DebugLog(@"pos = [%i]", pos);
    

    //For aaaa
    switch (pos)
    {
        case 0:
            DebugLog(@"Up Arrow Pressed");
            break;
            
        case 1:
            DebugLog(@"Left Arrow Pressed");
            break;
            
        case 3:
            DebugLog(@"Right Arrow Pressed");
            break;
            
        case 4:
            DebugLog(@"Down Arrow Pressed");
            break;
            
        default:
            DebugLog(@"Unknwown arrow input. Pos = [%i]", pos);
            break;
    }

    
    [self setupWithParentView:self.parentView];
}

@end
