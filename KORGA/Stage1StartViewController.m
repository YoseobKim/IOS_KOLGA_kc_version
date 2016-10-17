//
//  Stage1StartViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Stage1StartViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"

@interface Stage1StartViewController ()

@end

@implementation Stage1StartViewController

@synthesize bgBtn, settingBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day {
    chapter = _chapter;
    day = _day;
    
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

-(IBAction) bgBtnTouched:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createStage1ViewController:self Chapter:chapter AndDay:day];
    }
}

- (void)settingBtnPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate.menuViewController showMenuViewWithStage:1 chapter:chapter day:day];
    }
}

- (void)removeThisView {
    [self.view removeFromSuperview];
    [self release];
    self = nil;
}

@end
