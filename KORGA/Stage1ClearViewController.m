//
//  Stage1ClearViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Stage1ClearViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"

@interface Stage1ClearViewController ()

@end

@implementation Stage1ClearViewController

@synthesize chapter, day, wrong, elapsedTime, wrongTrialLabel, elapsedTimeLabel, nextBtn, completeLabel, stageLabel, settingBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day wrongTrial:(NSInteger)_wrong elapsedTime:(NSString *)_elapsedTime {
    self.chapter = _chapter;
    self.day = _day;
    self.wrong = _wrong;
    self.elapsedTime = _elapsedTime;
    
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

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
    elapsedTimeLabel.text = [NSString stringWithFormat:@"Elapsed Time: %@", elapsedTime];
    wrongTrialLabel.text = [NSString stringWithFormat:@"Wrong Trial: %d", wrong];
    
    self.completeLabel.transform=CGAffineTransformMakeScale(0.1, 0.1);
    self.completeLabel.alpha = 0;
    
    [UIView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        self.completeLabel.transform=CGAffineTransformMakeScale(1, 1); 
        self.completeLabel.alpha = 1;
    } completion:^(BOOL finished){
        self.completeLabel.transform=CGAffineTransformIdentity;
    }];
    
    self.stageLabel.transform=CGAffineTransformMakeScale(0.1, 0.1);
    self.stageLabel.alpha = 0;
    
    [UIView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        self.stageLabel.transform=CGAffineTransformMakeScale(1, 1); 
        self.stageLabel.alpha = 1;
    } completion:^(BOOL finished){
        self.stageLabel.transform=CGAffineTransformIdentity;
    }];
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

- (IBAction)nextBtnClicked:(id)sender {
    NSLog(@"next game start");
    
    [self.view removeFromSuperview];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createStage3StartViewControllerWithChapter:chapter AndDay:day];
    }
}

- (void)settingBtnPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate.menuViewController showMenuViewWithStage:1 chapter:chapter day:day];
    }
}

@end
