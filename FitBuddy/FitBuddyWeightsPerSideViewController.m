//
//  FitBuddyFirstViewController.m
//  FitBuddy
//
//  Created by Greg Cober on 3/15/13.
//  Copyright (c) 2013 CoberCo. All rights reserved.
//

#import "FitBuddyWeightsPerSideViewController.h"

@interface FitBuddyWeightsPerSideViewController ()

@end

@implementation FitBuddyWeightsPerSideViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize textWeight;
@synthesize labelPlates;
@synthesize segPoundsKilos;
@synthesize labelBarWeight;
@synthesize weightsPerSide = _weightsPerSide;
@synthesize isPounds = _isPounds;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.isPounds = true;
}

- (void)viewDidUnload
{
    [self setTextWeight:nil];
    [self setLabelPlates:nil];
    [self setSegPoundsKilos:nil];
    [self setLabelBarWeight:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}*/

- (IBAction)changeUnits:(id)sender {
    
    float weight = [self.textWeight.text floatValue];
    
    if(self.segPoundsKilos.selectedSegmentIndex == 1) {
        self.isPounds = false;
        weight = weight*0.45359237;
        self.textWeight.text = [NSString stringWithFormat:@"%.1f", weight];
    }
    else {
        self.isPounds = true;
        weight = weight/0.45359237;
        self.textWeight.text = [NSString stringWithFormat:@"%.1f", weight];
    }
    
    [self calculateButtonClicked:self];
    
}

- (IBAction)calculateButtonClicked:(id)sender {
    
    // First set the weightsPerSide property to blank
    self.weightsPerSide = @"";
    
    int barWeight = 20;
    if(self.isPounds)
        barWeight = 45;
    
    int maxWeight = 454;
    if(self.isPounds)
        maxWeight = 1000;
    
    // Next we need to check our input to make sure it's valid.
    //
    // Let's start off by converting the string to a float and then rounding the
    // input in case the user somehow got a decimal point in there.
    float weight = [self.textWeight.text floatValue];
    float initialWeight = weight;
    weight = roundf(weight);
    
    // We'll artificially limit this to 1000 pounds (which can't be displayed
    // properly anyways).
    if(weight > maxWeight)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woah!"
                                                        message:@"You are a beast!  This app was not made for you, sorry"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        self.labelPlates.text = self.weightsPerSide;
        [self.textWeight resignFirstResponder];
        
        return;
    }
    
    // If the weight is the bar or less there is nothing to do.
    if(weight < barWeight)
    {
        self.labelPlates.text = self.weightsPerSide;
        [self.textWeight resignFirstResponder];
        
        return;
    }
    
    // If the user picked a weight that was not an increment of 5 we need to
    // tell them and then round the number to the nearest increment of 5.
    if(self.isPounds && (int)weight % 5 != 0){
        // Display message that the input must be incrememnts of 5
        // and round the weight appropriately and update the text box
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Weight"
         message:@"The weight entered must be an increment of 5.  The weight will be automatically rounded to the nearest 5 lb incrememnt."
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];*/
        
        int modVal = (int)weight % 5;
        if(modVal == 1)
            weight = weight - 1;
        else if(modVal == 2)
            weight = weight -2;
        else if(modVal == 3)
            weight = weight + 2;
        else if(modVal == 4)
            weight = weight + 1;
        
    }
    else if(!self.isPounds && (int)weight*10 % 25 != 0){
        
        int modVal = (int) weight*10 % 25;
        if(modVal <= 12){
            while(modVal > 0) {
                weight = weight - .1;
                modVal--;
            }
        }
        else {
            while(modVal < 25){
                weight = weight + .1;
                modVal++;
            }
        }
        
    }
    if(weight != initialWeight){
        if(self.isPounds)
            self.labelBarWeight.text = [NSString stringWithFormat:@"Lift Weight: %d", (int)weight];
        else
            self.labelBarWeight.text = [NSString stringWithFormat:@"Lift Weight: %.1f", weight];
    }
    else {
        self.labelBarWeight.text = @"";
    }
    
    if(self.isPounds)
        self.weightsPerSide = [FitBuddyWeightsPerSideViewController stringOfPlatesFromWeightInPounds:weight];
    else
        self.weightsPerSide = [FitBuddyWeightsPerSideViewController stringOfPlatesFromWeightInKilos:weight];
    
    self.labelPlates.text = self.weightsPerSide;
    
    [self.textWeight resignFirstResponder];
    
    NSLog(@"textbox = \n%@", self.weightsPerSide);
}

- (IBAction)textFieldTouched:(id)sender {
    self.textWeight.text = @"";
}

+ (NSString*)stringOfPlatesFromWeightInKilos:(float)weight {
    
    NSString* weightsPerSide = @"";
    // Let's build the string for the weights per side
    int n20s = 0;
    int n15s = 0;
    int n10s = 0;
    int n5s = 0;
    int n2s = 0;
    int n1s = 0;
    
    //remove the barbell weight
    weight = weight-20;
    
    //split the weight to figure it out per side
    weight = weight/2;
    
    // Count how many 45's we can have
    n20s = weight / 20; // relies on the fact that n45s is an int
    weight = (int)weight % 20;
    
    // Count how many 35's we can have
    n15s = weight / 15;
    weight = (int)weight % 15;
    
    // Count how many 25's we can have
    n10s = weight / 10;
    weight = (int)weight % 10;
    
    // Count how many 10's we can have
    n5s = weight / 5;
    weight = (int)weight % 5;
    
    // Count how many 5's we can have
    n2s = weight / 2;
    weight = (int)weight % 2;
    
    //Count how many 2.5's we can have
    if(weight > 0)
        n1s = 1;
    
    // Build the string to display
    /*while(n20s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"20\n"];
        n20s--;
    }*/
    if(n20s > 1)
    {
        weightsPerSide = [weightsPerSide stringByAppendingFormat:@"20's x %d\n", n20s];
    }
    else if(n20s == 1)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"20\n"];
        
    }
    while(n15s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"15\n"];
        n15s--;
    }
    while(n10s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"10\n"];
        n10s--;
    }
    while(n5s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"5\n"];
        n5s--;
    }
    while(n2s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"2.5\n"];
        n2s--;
    }
    if(n1s > 0)
        weightsPerSide = [weightsPerSide stringByAppendingString:@"1.25"];
    
    // Let's check to see if there is an '-' at the end of the string
    if([weightsPerSide length] > 0 &&
       [[weightsPerSide substringFromIndex:[weightsPerSide length]-1] isEqualToString:@"-"]){
        
        NSMutableString *string = [NSMutableString stringWithString:weightsPerSide];
        NSCharacterSet *characerSet = [NSCharacterSet characterSetWithCharactersInString: @"\n"];
        weightsPerSide = [string stringByTrimmingCharactersInSet: characerSet];
        
    }
    
    return weightsPerSide;
}

+ (NSString*)stringOfPlatesFromWeightInPounds:(float)weight {
    
    NSString* weightsPerSide = @"";
    // Let's build the string for the weights per side
    int n45s = 0;
    int n35s = 0;
    int n25s = 0;
    int n10s = 0;
    int n5s = 0;
    int n2s = 0;
    
    //remove the barbell weight
    weight = weight-45;
    
    //split the weight to figure it out per side
    weight = weight/2;
    
    // Count how many 45's we can have
    n45s = weight / 45; // relies on the fact that n45s is an int
    weight = (int)weight % 45;
    
    // Count how many 35's we can have
    n35s = weight / 35;
    weight = (int)weight % 35;
    
    // Count how many 25's we can have
    n25s = weight / 25;
    weight = (int)weight % 25;
    
    // Count how many 10's we can have
    n10s = weight / 10;
    weight = (int)weight % 10;
    
    // Count how many 5's we can have
    n5s = weight / 5;
    weight = (int)weight % 5;
    
    //Count how many 2.5's we can have
    if(weight > 0)
        n2s = 1;
    
    // Build the string to display
    /*while(n45s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"45\n"];
        n45s--;
    }*/
    if(n45s > 1)
    {
        weightsPerSide = [weightsPerSide stringByAppendingFormat:@"45's x %d\n", n45s];
    }
    else if(n45s == 1)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"45\n"];

    }
    while(n35s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"35\n"];
        n35s--;
    }
    while(n25s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"25\n"];
        n25s--;
    }
    while(n10s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"10\n"];
        n10s--;
    }
    while(n5s > 0)
    {
        weightsPerSide = [weightsPerSide stringByAppendingString:@"5\n"];
        n5s--;
    }
    if(n2s > 0)
        weightsPerSide = [weightsPerSide stringByAppendingString:@"2.5"];
    
    // Let's check to see if there is an '-' at the end of the string
    if([weightsPerSide length] > 0 &&
       [[weightsPerSide substringFromIndex:[weightsPerSide length]-1] isEqualToString:@"-"]){
        
        NSMutableString *string = [NSMutableString stringWithString:weightsPerSide];
        NSCharacterSet *characerSet = [NSCharacterSet characterSetWithCharactersInString: @"\n"];
        weightsPerSide = [string stringByTrimmingCharactersInSet: characerSet];
        
    }
    
    return weightsPerSide;
}

@end
