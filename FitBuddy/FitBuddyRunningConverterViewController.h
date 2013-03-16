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

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *textTimeHours;
@property (weak, nonatomic) IBOutlet UITextField *textTimeMinutes;
@property (weak, nonatomic) IBOutlet UITextField *textTimeSeconds;


@end
