//
//  OptionViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"
#import "Settings.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface OptionViewController ()

@end

@implementation OptionViewController

@synthesize soundRepeatBtn1, soundRepeatBtn2, soundRepeatBtn3, vibrationSwitchBtn, creditBtn, optionBtn, repeatTime, vibrateOn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[Settings sharedSetting] loadSettings];
        repeatTime = [[Settings sharedSetting] getNumOfRepeationValue];
        vibrateOn = [[Settings sharedSetting] getVibrationOnValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(repeatTime == 1) {
        soundRepeatBtn1.selected = YES;
        soundRepeatBtn2.selected = NO;
        soundRepeatBtn3.selected = NO;
    } else if(repeatTime == 2) {
        soundRepeatBtn1.selected = NO;
        soundRepeatBtn2.selected = YES;
        soundRepeatBtn3.selected = NO;
    } else {
        soundRepeatBtn1.selected = NO;
        soundRepeatBtn2.selected = NO;
        soundRepeatBtn3.selected = YES;
    }
    
    if(vibrateOn) {
        vibrationSwitchBtn.selected = NO;
    }
    else {
        vibrationSwitchBtn.selected = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)soundRepeatBtn1Pressed:(id)sender {
    soundRepeatBtn1.selected = YES;
    soundRepeatBtn2.selected = NO;
    soundRepeatBtn3.selected = NO;
    repeatTime = 1;
}

- (IBAction)soundRepeatBtn2Pressed:(id)sender {
    soundRepeatBtn1.selected = NO;
    soundRepeatBtn2.selected = YES;
    soundRepeatBtn3.selected = NO;
    repeatTime = 2;
}

- (IBAction)soundRepeatBtn3Pressed:(id)sender {
    soundRepeatBtn1.selected = NO;
    soundRepeatBtn2.selected = NO;
    soundRepeatBtn3.selected = YES;
    repeatTime = 3;
}

- (IBAction)creditBtnPressed:(id)sender {
    NSLog(@"BtnCredit Pressed");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createCreditViewController];
    }
}

- (IBAction)toggleEnabledVibrationSW:(id)sender {
    vibrateOn = !vibrateOn;
    
    if(vibrateOn) {
        vibrationSwitchBtn.selected = NO;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    else {
        vibrationSwitchBtn.selected = YES;
    }
}

- (void)saveSetting {
    [[Settings sharedSetting] saveSettings:repeatTime vibrate:vibrateOn tutorialOff:[[Settings sharedSetting] getTutorialOffValue]];
}

- (void)showOptionView {
    self.view.hidden = NO;
}

- (void)hiddenThisView {
    [self saveSetting];
    [self.view removeFromSuperview];
}

@end
