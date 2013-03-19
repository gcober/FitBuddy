//
//  FitBuddySecondViewController.h
//  FitBuddy
//
//  Created by Greg Cober on 3/15/13.
//  Copyright (c) 2013 CoberCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitBuddyRunningConverterViewController : UIViewController

// Actions
- (IBAction)calculateButtonPushed:(id)sender;
- (IBAction)clearTextOnEditDidBegin:(UITextField*)sender;
- (IBAction)actionHourEditingChanged:(id)sender;
- (IBAction)actionMinEditingChanged:(id)sender;
- (IBAction)actionSecEditingChanged:(id)sender;
- (IBAction)actionConvertMileToKM:(id)sender;

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *textTimeHours;
@property (weak, nonatomic) IBOutlet UITextField *textTimeMinutes;
@property (weak, nonatomic) IBOutlet UITextField *textTimeSeconds;
@property (weak, nonatomic) IBOutlet UITextField *textDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelSpeedPace;
@property (weak, nonatomic) IBOutlet UILabel *labelCalcualtedSpeedPace;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segctrlPaceSpeed;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segctrlMilesKilometers;


@end
