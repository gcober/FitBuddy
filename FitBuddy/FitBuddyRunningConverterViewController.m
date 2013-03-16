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
/*@property int timeInSeconds;
@property double distance;*/

@end

@implementation FitBuddyRunningConverterViewController

/*@synthesize timeInSeconds = _timeInSeconds;
@synthesize distance = _distance;*/

@synthesize textTimeHours = _textTimeHours;
@synthesize textTimeMinutes = _textTimeMinutes;
@synthesize textTimeSeconds = _textTimeSeconds;
@synthesize labelSpeedPace = _labelSpeedPace;
@synthesize textDistance = _textDistance;
@synthesize labelCalcualtedSpeedPace = _labelCalcualtedSpeedPace;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.labelCalcualtedSpeedPace.text = @"";
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
    [self.textDistance resignFirstResponder];
    
    self.labelCalcualtedSpeedPace.text = [NSString stringWithFormat:@"%f", [self calculatePaceFromTimeInSeconds:[self getTimeInSecondsFromLabels] andDistance:[self.textDistance.text doubleValue]]];
}

- (IBAction)clearTextOnEditDidBegin:(UITextField*)sender {
    sender.text = @"";
    
}

- (IBAction)actionHourEditingChanged:(id)sender {
    if(self.textTimeHours.text.length == 2)
    {
        [self.textTimeHours resignFirstResponder];
        [self.textTimeMinutes becomeFirstResponder];
    }
}

- (IBAction)actionMinEditingChanged:(id)sender {
    if(self.textTimeMinutes.text.length == 2)
    {
        [self.textTimeMinutes resignFirstResponder];
        [self.textTimeSeconds becomeFirstResponder];
    }
}

- (IBAction)actionSecEditingChanged:(id)sender {
    if(self.textTimeSeconds.text.length == 2)
    {
        [self.textTimeSeconds resignFirstResponder];
        [self.textDistance becomeFirstResponder];
    }
}

- (BOOL)hasValidInput
{
    return YES;
}

- (int)getTimeInSecondsFromLabels
{
    return [self.textTimeHours.text intValue]*3600 + [self.textTimeMinutes.text intValue]*60 + [self.textTimeSeconds.text intValue];
}

// "Model" functions (easier to just leave in the view controller)
- (double)calculatePaceFromTimeInSeconds:(int)seconds andDistance:(double)distance
{
    
    return (double)seconds / distance / 60.0;
}

@end
