//
//  FitBuddyFirstViewController.h
//  FitBuddy
//
//  Created by Greg Cober on 3/15/13.
//  Copyright (c) 2013 CoberCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FitBuddyWeightsPerSideViewController : UIViewController

// Actions
- (IBAction)changeUnits:(id)sender;
- (IBAction)calculateButtonClicked:(id)sender;
- (IBAction)textFieldTouched:(id)sender;

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *textWeight;
@property (weak, nonatomic) IBOutlet UILabel *labelPlates;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPoundsKilos;
@property (weak, nonatomic) IBOutlet UILabel *labelBarWeight;

// Model (not really necessary to put in another class)
// Properties
@property (copy, nonatomic) NSString *weightsPerSide;
@property bool isPounds;
+ (NSString*)stringOfPlatesFromWeightInPounds:(float)weight;
+ (NSString*)stringOfPlatesFromWeightInKilos:(float)weight;


@end
