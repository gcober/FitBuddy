//
//  FitBuddySecondViewController.m
//  FitBuddy
//
//  Created by Greg Cober on 3/15/13.
//  Copyright (c) 2013 CoberCo. All rights reserved.
//

#import "FitBuddyRunningConverterViewController.h"

@interface FitBuddyRunningConverterViewController ()

// Private properties
@property int timeInSeconds;

@end

@implementation FitBuddyRunningConverterViewController

@synthesize textTimeHours = _textTimeHours;
@synthesize textTimeMinutes = _textTimeMinutes;
@synthesize textTimeSeconds = _textTimeSeconds;
@synthesize timeInSeconds = _timeInSeconds;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.timeInSeconds = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateButtonPushed:(id)sender {
    // Let's resolveFirstResponder for all text fields
    [self.textTimeHours resignFirstResponder];
    [self.textTimeMinutes resignFirstResponder];
    [self.textTimeSeconds resignFirstResponder];
    
    
    
}

- (IBAction)clearTextOnEditDidBegin:(UITextField*)sender {
    sender.text = @"";
    
}

- (BOOL)hasValidInput
{
    return YES;
}

// "Model" functions (easier to just leave in the view controller)
- (double)calculatePaceFromTimeInSeconds:(int)seconds andDistance:(double)distance
{
    
    return (double)seconds / distance / 60.0;
}

@end
