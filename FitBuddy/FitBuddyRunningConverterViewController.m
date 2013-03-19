//
//  FitBuddySecondViewController.m
//  FitBuddy
//
//  Created by Greg Cober on 3/15/13.
//  Copyright (c) 2013 CoberCo. All rights reserved.
//

#import "FitBuddyRunningConverterViewController.h"

@interface FitBuddyRunningConverterViewController ()

@end

@implementation FitBuddyRunningConverterViewController

@synthesize textTimeHours = _textTimeHours;
@synthesize textTimeMinutes = _textTimeMinutes;
@synthesize textTimeSeconds = _textTimeSeconds;
@synthesize labelSpeedPace = _labelSpeedPace;
@synthesize textDistance = _textDistance;
@synthesize labelCalcualtedSpeedPace = _labelCalcualtedSpeedPace;
@synthesize segctrlMilesKilometers = _segctrlMilesKilometers;
@synthesize segctrlPaceSpeed = _segctrlPaceSpeed;

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
    
    // If they didn't enter a distance show that as the pace
    if(self.textDistance.text.length == 0)
    {
        self.labelCalcualtedSpeedPace.text = @"(enter distance)";
    }
    // Otherwise show the speed/pace
    else
    {
        // If the user wants pace show pace
        if(self.segctrlPaceSpeed.selectedSegmentIndex == 0)
        {
            double pace = [self calculatePaceFromTimeInSeconds:[self getTimeInSecondsFromLabels] andDistance:[self.textDistance.text doubleValue]];
            self.labelCalcualtedSpeedPace.text = [NSString stringWithFormat:@"%@", [self timeStringFromMinutesAsDouble:pace]];
        }
        else{
            double speed = [self.textDistance.text doubleValue] / ([self getTimeInSecondsFromLabels] / 3600);
            self.labelCalcualtedSpeedPace.text = [NSString stringWithFormat:@"%5.2f %@", speed, self.segctrlMilesKilometers.selectedSegmentIndex==0?@"mph":@"kph"];
                                                                            
        }
    }
}

// Clears the text on entering the field (makes it easier to enter text)
- (IBAction)clearTextOnEditDidBegin:(UITextField*)sender {
    sender.text = @"";
    
}

// After entering 2 chars it moves to the next field (mins)
- (IBAction)actionHourEditingChanged:(id)sender {
    if(self.textTimeHours.text.length == 2 && self.textTimeMinutes.text.length == 0)
    {
        [self.textTimeHours resignFirstResponder];
        [self.textTimeMinutes becomeFirstResponder];
    }
}

// After entering 2 chars it moves to the next field (secs)
- (IBAction)actionMinEditingChanged:(id)sender {
    if(self.textTimeMinutes.text.length == 2 && self.textTimeSeconds.text.length == 0)
    {
        [self.textTimeMinutes resignFirstResponder];
        [self.textTimeSeconds becomeFirstResponder];
    }
}

// After entering 2 chars it moves to the next field (distance).  Only if there is no distance currently
- (IBAction)actionSecEditingChanged:(id)sender {
    if(self.textTimeSeconds.text.length == 2 && self.textDistance.text.length == 0)
    {
        [self.textTimeSeconds resignFirstResponder];
        [self.textDistance becomeFirstResponder];
    }
}

- (IBAction)actionConvertMileToKM:(id)sender {
    double newDisplayValue = 0.0;
    if(self.segctrlMilesKilometers.selectedSegmentIndex == 0)//Convert to miles
    {
        double distanceInKilometers = [self.textDistance.text doubleValue];
        newDisplayValue = distanceInKilometers * 0.621371;
        
    }
    else//convert to km
    {
        double distanceInMiles = [self.textDistance.text doubleValue];
        newDisplayValue = distanceInMiles / 0.621371;
    }
    self.textDistance.text = [NSString stringWithFormat:@"%6.2f", newDisplayValue ];
    
    // Recalculate the pace/speed
    [self calculateButtonPushed:sender];
}

- (double)getTimeInSecondsFromLabels
{
    return [self.textTimeHours.text doubleValue]*3600.0 + [self.textTimeMinutes.text doubleValue]*60.0 + [self.textTimeSeconds.text doubleValue];
}

// "Model" functions (easier to just leave in the view controller)
- (double)calculatePaceFromTimeInSeconds:(double)seconds andDistance:(double)distance
{
    
    return (double)seconds / distance / 60.0;
}

- (NSString *)timeStringFromMinutesAsDouble:(double)time
{
    double fractionPart = time - (long)time;
    int integerPart = (long)time;
    
    NSString *units;
    if(self.segctrlMilesKilometers.selectedSegmentIndex == 0)
        units = @"min/mile";
    else
        units = @"min/km";
    
    return [NSString stringWithFormat:@"%d:%02.0f %@", integerPart, (fractionPart*60), units];
}

@end
