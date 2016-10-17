//
//  TutorialViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TutorialViewController.h"
#import "Settings.h"
#import "AppDelegate.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

@synthesize closeBtn, bgImageView, type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if([[Settings sharedSetting] getTutorialOffValue]) {
        [self.view removeFromSuperview];
        
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        if(appDelegate != nil) {
            appDelegate.tutorialSkip = YES;
        }
    }
    
    if(type == ChapterView) {
        bgImage = [UIImage imageNamed:@"tutorial_chapter.png"];
    }
    if(type == DayView) {
        bgImage = [UIImage imageNamed:@"tutorial_day.png"];
    }
    if(type == Stage1View) {
        bgImage = [UIImage imageNamed:@"tutorial_stage1.png"];
    }
    if(type == Stage2View) {
        bgImage = [UIImage imageNamed:@"tutorial_stage2.png"];
        Settings *setting = [Settings sharedSetting];
        [setting saveSettings:[setting getNumOfRepeationValue] vibrate:[setting getVibrationOnValue] tutorialOff:YES];
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        if(appDelegate != nil) {
            appDelegate.tutorialSkip = YES;
        }

    }
    if(type == StudyView) {
        bgImage = [UIImage imageNamed:@"tutorial_study.png"];
    }
    
    bgImageView.image = bgImage;
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

- (IBAction)closeBtnPressed:(id)sender {
    [self.view removeFromSuperview];
}

@end
