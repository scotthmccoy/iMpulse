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

//For +singleton method
static BPMKeyboardListener* _singleton = nil;

@implementation BPMKeyboardListener


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
        [BPMKeystrokeParser singleton];
        
        //Create the TextView that will act as the listener.
        txtListener = [[UITextView alloc] init];
        
        //////////////////////////////////////////////////
        //Make the Text Field as unobtrusive as possible.
        //////////////////////////////////////////////////
        
        if (DEBUG_MODE_VISIBLE_TEXT_ENTRY)
        {
            txtListener.frame = CGRectMake(100, 100, 320, 480);
            txtListener.backgroundColor = [UIColor whiteColor];
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
        //Set up callbacks
        //////////////////////////////////////////////////
        
        //Call observer_UITextFieldTextDidChangeNotification when the text view changes
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(observer_UITextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object: nil];
        
        //Begin receiving selection changes
        txtListener.delegate = self;
    }
    return self;
}


- (void) setParentView:(UIView*)parent
{
    //Remove it from whatever view it's in
    [txtListener removeFromSuperview];
    
    //Add it to the passed-in view
    [parent addSubview: txtListener];
    
    //Reset the field for input
    [self resetText];
    
    //Have it start consuming keyboard input
    [txtListener becomeFirstResponder];
}

- (void) resetText
{
    DebugLogWhereAmI();
    
    //Supress delegate responses to the reset
    isResetting = YES;
    
    //Set the text to a three-line block
    txtListener.text = @"a\nbb\nc";
    
    //TODO: Right after creation, the UITextField has a null beginningOfDocument for some reason.
    //This prevents me from setting the cursor position, and therefore, if the the first input the field receives is an arrow key, it will be ignored.
    
    //If beginningOfDocument is null, we have no way of setting the cursor position.
    if (txtListener.beginningOfDocument == NULL)
    {
        txtListener.text = @"";
        return;
    }
    

    //Get a UITextPosition representing the 3rd character in the string (between the 2 b's)
    UITextPosition *newPosition = [txtListener positionFromPosition:txtListener.beginningOfDocument offset:3];
    
    //Use that position to calculate a zero-length range at that position.
    UITextRange *newRange = [txtListener textRangeFromPosition:newPosition toPosition:newPosition];
    
    //Set the range. This will set the cursor position.
    [txtListener setSelectedTextRange:newRange];
    
    
    // Calculate the existing position, relative to the beginning
    int pos = [txtListener offsetFromPosition:txtListener.beginningOfDocument toPosition:txtListener.selectedTextRange.start];
    
    if (pos != 3)
        DebugLog(@"pos = [%i]", pos);
    
    //Re-allow responses
    isResetting = NO;
}


/////////////////////
//Callbacks
/////////////////////
- (void)observer_UITextFieldTextDidChangeNotification:(NSNotification *)aNotification
{
    //Don't process this if we're in the middle of resetting the UITextView.
    if (isResetting)
    {
        //DebugLog(@"Resetting. Bailing..");
        return;
    }
    
    //Character key was pressed.
    
    //Get the character
    NSString* input = [txtListener.text substringWithRange:NSMakeRange(3,1)];
    
    //Send the input to the parser
    [[BPMKeystrokeParser singleton] takeInput:input];
    
    //Reset the text field for new input
    [self resetText];
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
    //Don't process this if we're in the middle of resetting the UITextView.
    if (isResetting)
    {
        //DebugLog(@"Resetting. Bailing..");
        return;
    }
    
    //Arrow key was pressed.
    
    // Calculate the existing position, relative to the beginning
    int pos = [txtListener offsetFromPosition:txtListener.beginningOfDocument toPosition:txtListener.selectedTextRange.start];
    
    DebugLog(@"pos = [%i]", pos);
    
    //What is the new position?
    switch (pos)
    {
        case 1:
            DebugLog(@"Up Arrow Pressed");
            break;
            
        case 2:
            DebugLog(@"Left Arrow Pressed");
            break;
            
        case 4:
            DebugLog(@"Right Arrow Pressed");
            break;
            
        case 6:
            DebugLog(@"Down Arrow Pressed");
            break;
            
        default:
            DebugLog(@"Unknwown arrow input. Pos = [%i]", pos);
            break;
    }
    
    //Reset the text field for new input
    [self resetText];    
}

@end
