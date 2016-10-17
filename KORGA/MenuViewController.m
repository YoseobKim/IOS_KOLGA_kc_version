//
//  MenuViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "StudyPageAppViewController.h"
#import "StudyPageViewController.h"
#import "Stage1ViewController.h"
#import "Stage1StartViewController.h"
#import "Stage1ClearViewController.h"
#import "Stage3StartViewController.h"
#import "Stage3ViewController.h"
#import "DayClearViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize homeBtn, backBtn, skipBtn, restartBtn, dayBtn, ch1Skip;

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

- (void)showMenuViewWithStage:(NSInteger)_stage chapter:(NSInteger)_chapter day:(NSInteger)_day {
    [self.view bringSubviewToFront:self.view];
    self.view.hidden = NO;
    
    stage = _stage;
    chapter = _chapter;
    day = _day;
    
    self.skipBtn.enabled = YES;
    
    if(stage == 4) {
        self.skipBtn.enabled = NO;
    }
}

- (void)hiddenThisView {
    [self.view removeFromSuperview];
}

- (void)homeBtnPressed:(id)sender {
    self.view.hidden = YES;
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(stage == 0) {
        if(appDelegate != nil) {
            [appDelegate.studyViewController.view removeFromSuperview];
            [appDelegate.studyPageViewController.view removeFromSuperview];
        }
    } else if(stage == 1) {
        if(appDelegate != nil) {
            [appDelegate.stage1ViewController.view removeFromSuperview];
            [appDelegate.stage1StartViewController.view removeFromSuperview];
        }
    } else if(stage == 3) {
        if(appDelegate != nil) {
            [appDelegate.stage3ViewController.view removeFromSuperview];
            [appDelegate.stage3StartViewController.view removeFromSuperview];
        }
    } else if(stage == 4) {
        if(appDelegate != nil) {
            [appDelegate.dayClearViewController.view removeFromSuperview];
        }
    }
    
    if(appDelegate != nil) {
        [appDelegate createChapterViewController];
    }
    [self.view removeFromSuperview];
}

- (void)backBtnPressed:(id)sender {
    if(stage == 1) {
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [appDelegate.stage1ViewController timerResume];
    }
    [self.view removeFromSuperview];
}

- (void)skipBtnPressed:(id)sender {
    self.view.hidden = YES;
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(stage == 0) {
        if(appDelegate != nil) {
            [appDelegate.studyViewController.view removeFromSuperview];
            [appDelegate.studyPageViewController.view removeFromSuperview];
            [appDelegate createStage1StartViewControllerWithChapter:chapter AndDay:day];
        }
    } else if(stage == 1) {
        if(appDelegate != nil) {
            appDelegate.ch1Skip = YES;
            [appDelegate.stage1ViewController.view removeFromSuperview];
            [appDelegate.stage1StartViewController.view removeFromSuperview];
            [appDelegate createStage3StartViewControllerWithChapter:chapter AndDay:day];
        }
    } else if(stage == 3) {
        if(appDelegate != nil) {
            [appDelegate.stage3ViewController.view removeFromSuperview];
            [appDelegate.stage3StartViewController.view removeFromSuperview];
            [appDelegate createDayViewController:chapter];
        }
    }
    [self.view removeFromSuperview];
}

- (void)restartBtnPressed:(id)sender {
    self.view.hidden = YES;
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(stage == 0) {
        if(appDelegate != nil) {
            [appDelegate.studyViewController.view removeFromSuperview];
            [appDelegate.studyPageViewController.view removeFromSuperview];
            [appDelegate createStudyViewControllerWithChapter:chapter AndDay:day];
        }
    } else if(stage == 1) {
        if(appDelegate != nil) {
            [appDelegate.stage1ViewController.view removeFromSuperview];
            [appDelegate createStage1ViewController:self Chapter:chapter AndDay:day];
        }
    } else if(stage == 3) {
        if(appDelegate != nil) {
            [appDelegate.stage3ViewController.view removeFromSuperview];
            [appDelegate createStage3ViewController:self Chapter:chapter AndDay:day];
        }
    } else if(stage == 4) {
        if(appDelegate != nil) {
            [appDelegate.dayClearViewController.view removeFromSuperview];
            [appDelegate createStage3StartViewControllerWithChapter:chapter AndDay:day];
        }
    }
    
    [self.view removeFromSuperview];
}

- (void)dayBtnPressed:(id)sender {
    self.view.hidden = YES;
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(stage == 0) {
        if(appDelegate != nil) {
            [appDelegate.studyViewController.view removeFromSuperview];
            [appDelegate.studyPageViewController.view removeFromSuperview];
        }
    } else if(stage == 1) {
        if(appDelegate != nil) {
            [appDelegate.stage1ViewController.view removeFromSuperview];
            [appDelegate.stage1StartViewController.view removeFromSuperview];
        }
    } else if(stage == 3) {
        if(appDelegate != nil) {
            [appDelegate.stage3ViewController.view removeFromSuperview];
            [appDelegate.stage3StartViewController.view removeFromSuperview];
        }
    } else if(stage == 4) {
        if(appDelegate != nil) {
            [appDelegate.dayClearViewController.view removeFromSuperview];
        }
    }
    
    if(appDelegate != nil) {
        [appDelegate createDayViewController:chapter];
    }
    [self.view removeFromSuperview];
}

@end
