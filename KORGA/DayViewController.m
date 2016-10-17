//
//  DayViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DayViewController.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "HighScores.h"
#import "OptionViewController.h"

@interface DayViewController ()

@end

@implementation DayViewController

@synthesize _chapter, backButton, optionBtn, bgView;

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
    [self loadHighScores];
    
    NSInteger btnXPos = 13;
    NSInteger btnYPos = 52;
    UIImage *smileImg = [UIImage imageNamed:@"smile.png"];
    UIImage *emptyImg = [UIImage imageNamed:@"smile_empty.png"];
    for (int i = 0; i < 12; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"Day%d.png", i + 1]];
        
        UIButton *dayImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dayImgBtn setBackgroundImage:img forState:UIControlStateNormal];
        //UIButton *dayImgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        dayImgBtn.frame = CGRectMake(btnXPos, btnYPos, img.size.width, img.size.height);
        [dayImgBtn addTarget:self action:@selector(dayBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [dayImgBtn setTag:i];
        
        NSInteger smileXPos = 8;
        for(int j = 0; j < 3; j++) {
            UIImageView *smileImgView;
            if([self getScoresFromDayScoreArray:i] > j) {
                smileImgView = [[UIImageView alloc] initWithImage:smileImg];
            }
            else {
                smileImgView = [[UIImageView alloc] initWithImage:emptyImg];
            }
            smileImgView.frame = CGRectMake(smileXPos, 45, smileImg.size.width, smileImg.size.height);
            [dayImgBtn addSubview:smileImgView];
            smileXPos += smileImg.size.width;
        }
        
        [bgView addSubview:dayImgBtn];
        btnXPos += 100;
        if((i + 1) % 3 == 0) {
            btnYPos += 105;
            btnXPos = 13;
        }
    }
    if(tv != nil) {
        [self.view bringSubviewToFront:tv.view];
    }
}

- (void) dayBtnPressed:(id)sender {
    NSInteger day = ((UIButton *)sender).tag;
    NSLog(@"Chapter %d, Day %d Selected!", _chapter, day);
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [self.view removeFromSuperview];
        [appDelegate createStudyViewControllerWithChapter:_chapter AndDay:day];
    }
}

- (void)loadHighScores {
    [[HighScores sharedHighScores] loadHighScores:_chapter];
    scores = [HighScores sharedHighScores].scoreArr;
}

- (NSInteger)getScoresFromDayScoreArray:(NSInteger)day {
    //[[HighScores sharedHighScores] loadHighScores:_chapter];
    return [[[HighScores sharedHighScores] getScoreFromRecord:[scores objectAtIndex:day]] integerValue];
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

-(void)backBtnPressed:(id)sender {
    [self.view removeFromSuperview];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createChapterViewController];
    }
}

-(void)setChapter:(NSInteger)chapter {
    self._chapter = chapter;
    NSLog(@"Chapter %d called", _chapter);
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil && !appDelegate.tutorialSkip) {
        tv = [appDelegate createTutorialViewControllerWithViewType:DayView];
        tv.view.frame = CGRectMake(0, 0, 320, 480);
        [self.view addSubview:tv.view];
    }
    [self viewDidLoad];
}

-(void)optionBtnPressed:(id)sender {
    NSLog(@"Option Button Pressed");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        //[self.view removeFromSuperview];
        [appDelegate createOptionViewController];
    }
}

@end
