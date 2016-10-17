//
//  GNDPageViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "GNDPageViewController.h"
#import "AppDelegate.h"
#import "GNDPageAppViewController.h"

@interface GNDPageViewController ()

@end

@implementation GNDPageViewController

@synthesize bgImage, bgImageView, closeBtn, pageLabel, pageString, leftArrawImageView, rightArrawImageView, index, maxPage;

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
    bgImageView.image = bgImage;
    pageLabel.text = pageString;
    
    if(index == 0) {
        self.leftArrawImageView.hidden = YES;
        self.rightArrawImageView.hidden = NO;
    } else if(index >= self.maxPage - 1) {
        self.leftArrawImageView.hidden = NO;
        self.rightArrawImageView.hidden = YES;
    } else {
        self.leftArrawImageView.hidden = NO;
        self.rightArrawImageView.hidden = NO;
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

- (IBAction)closeBtnClicked:(id)sender {
    NSLog(@"CloseBtnClicked");
    
    [self.view removeFromSuperview];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(appDelegate != nil) {
        [appDelegate.gndPageAppViewController.view removeFromSuperview];
    }
}

@end
