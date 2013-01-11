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





@interface BPMKeyboardListener (Private)

@end



@implementation BPMKeyboardListener

@synthesize parentView;

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
    
    //Keep this for if the selection changes and we have to destroy and re-create the txtListener
    self.parentView = inParentView;
    
    DebugLog(@"textListener address = [%p]", txtListener);
    
    
    //////////////////////////////////////////////////
    //Create the Listener
    //////////////////////////////////////////////////
    
    //Setup the txtListener
    if (txtListener)
    {

        //isResetting = YES;
        
        
        dispatch_async(dispatch_get_main_queue(),^{
            DebugLog(@"Swapping");
            

            
            //Create a new spare
            txtListener2 = [self createListener];
            
            //Add it to the passed-in view
            [self.parentView addSubview: txtListener2];
            
            //Now that it's in a view, it can receive focus.
            //Have the main one start consuming keyboard input.
            //

            
            //Wind down the listener
            txtListener.delegate = nil;
            //[txtListener resignFirstResponder];
            [txtListener removeFromSuperview];

            isResetting = YES;
            [txtListener2 becomeFirstResponder];
            txtListener2.selectedRange = NSMakeRange(2, 0);
            isResetting = NO;
            
            //Swap
            txtListener = txtListener2;
    
        });
        
    }
    else
    {
        isResetting = YES;
        
        //Create the TextView that will act as the listener, and a spare.
        txtListener = [self createListener];
        txtListener2 = [self createListener];
        
        //Add it to the passed-in view
        [self.parentView addSubview: txtListener];
        
        //Now that it's in a view, it can receive focus.
        //Have the main one start consuming keyboard input.
        [txtListener becomeFirstResponder];
        txtListener.selectedRange = NSMakeRange(2, 0);

        isResetting = NO;
    }
        
}



- (UITextView*)createListener
{
    
    UITextView* txtView = [[UITextView alloc] init];
    
    txtView.delegate = self;
    
    isResetting = YES;
    
    txtView.text = @"aaaa";
    

    
    
    //////////////////////////////////////////////////
    //Make the Text Field as unobtrusive as possible.
    //////////////////////////////////////////////////
    
    if (DEBUG_MODE_VISIBLE_TEXT_ENTRY)
    {
        txtView.frame = CGRectMake(25, 25, 50, 20);
        txtView.backgroundColor = [BPMUtilities debugLayoutColor];
        txtView.textColor = [UIColor whiteColor];
    }
    else
    {
        //Make the frame very small, and position it off-screen.
        txtView.frame = CGRectMake(-100, -100, 1, 1);
        
        //Make the color, alpha and BG color transparent
        txtView.backgroundColor = [UIColor clearColor];
        txtView.textColor = [UIColor clearColor];
        txtView.alpha = 0;
    }
    
    //Set the input view to a blank UIView.
    //This will prevent the keyboard from showing up when we set the txtListener as the firstResponder
    txtView.inputView = [[UIView alloc] init];
    
    
    DebugLog(@"txtView address = [%p]", txtView);
    
    //Begin receiving selection changes.
    //Have to do this before changing the text and selectedRange or it will delay processing those events.
    
    return txtView;
}


/////////////////////
//Callbacks
/////////////////////

#pragma UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    DebugLog(@"textListener address = [%p]", txtListener);
    DebugLog(@"textView address = [%p]", textView);
    
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
    int pos = textView.selectedRange.location;


    
    //Don't process this if we're in the middle of resetting the UITextView.
    if (isResetting)
    {
        DebugLog(@"Resetting. Bailing with pos = [%i]", pos);
        return;
    }

    
    //DebugLog(@"textListener address = [%p]", txtListener);
    //DebugLog(@"textView address = [%p]", textView);
    

    

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
    DebugLog(@"leaving");
}

@end
