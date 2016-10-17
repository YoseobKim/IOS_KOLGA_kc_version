//
//  StudyPageViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "StudyPageViewController.h"
#import "AppDelegate.h"
#import "HelloWorldLayer.h"
#import "StudyPageAppViewController.h"
#import "MenuViewController.h"
#import "Settings.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface StudyPageViewController ()

@end

@implementation StudyPageViewController

@synthesize _mDayLabel, _mDownContentLabel, _mMidContentLabel, _mPageLabel, _mUpContentLabel, finderBtn, settingBtn, gameStartBtn, soundBtn, _titleLabel;
@synthesize _mDayString, _mDownContentString, _mMidContentString, _mPageString, _mUpContentString;
@synthesize chapter, page, day, maxPage, bgView;
@synthesize parent;
@synthesize rightImageView;
@synthesize filePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bgImage_f = [UIImage imageNamed:@"pre_study_front.jpg"];
        bgImage_n = [UIImage imageNamed:@"pre_study_base.jpg"];
        bgImage_e = [UIImage imageNamed:@"pre_study_end.jpg"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self._mDownContentLabel.lineBreakMode = UILineBreakModeWordWrap;
    self._mDownContentLabel.numberOfLines = 0;
    
    self._mUpContentLabel.text = self._mUpContentString;
    self._mMidContentLabel.text = self._mMidContentString;
    self._mDownContentLabel.text = self._mDownContentString;
    self._mPageLabel.text = self._mPageString;
    self._mDayLabel.text = self._mDayString;
        
    if(self.page == 0) { 
        bgView.image = bgImage_f;
        self.soundBtn.hidden = YES;
        self._mMidContentLabel.hidden = YES;
        self._mDownContentLabel.textAlignment = UITextAlignmentCenter;
        self._mPageLabel.hidden = YES;
        self.finderBtn.hidden = YES;
        self.gameStartBtn.hidden = YES;
        self._mUpContentLabel.hidden = YES;
        self.settingBtn.hidden = YES;
        rightImageView.hidden = NO;
    }
    else if(self.page > maxPage) {
        bgView.image = bgImage_e;
        self.soundBtn.hidden = YES;
        self._mUpContentLabel.hidden = YES;
        self._mMidContentLabel.hidden = YES;
        self._mDownContentLabel.hidden = YES;
        self._mPageLabel.hidden = YES;
        self._mDayLabel.hidden = YES;
        self.finderBtn.hidden = YES;
        self.gameStartBtn.hidden = NO;
        self._titleLabel.hidden = YES;
        self.settingBtn.hidden = YES;
        rightImageView.hidden = YES;
    }
    else {
        bgView.image = bgImage_n;
        self._mUpContentLabel.hidden = NO;
        self._mMidContentLabel.hidden = NO;
        self._mDownContentLabel.hidden = NO;
        self._mPageLabel.hidden = NO;
        self._mDayLabel.hidden = NO;
        self.gameStartBtn.hidden = YES;
        self._titleLabel.hidden = YES;
        self.settingBtn.hidden = NO;
        rightImageView.hidden = YES;
    }
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        appDelegate.studyPageViewController = self;
    }
    
    if(self.page == 1) {
        if(appDelegate != nil && !appDelegate.tutorialSkip) {
            TutorialViewController *tempView = [appDelegate createTutorialViewControllerWithViewType:StudyView];
            [self.view addSubview:tempView.view];
        }
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

-(void)settingBtnPressed:(id)sender {
    //[self.view removeFromSuperview];
    //[parent performSelector:@selector(removeThisView)];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createMenuViewControllerWithStage:0 Chapter:chapter Day:day];
    }
}

-(void)finderBtnPressed:(id)sender {
    NSLog(@"FinderBtnPressed!");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createGNDPageAppViewController];
    }
}

-(void)gameStartBtnPressed:(id)sender {
    NSLog(@"GameStartBtnPressed!");

    [self.view removeFromSuperview];
    //[parent performSelector:@selector(removeThisView)];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate.studyViewController.view removeFromSuperview];
        [appDelegate createStage1StartViewControllerWithChapter:chapter AndDay:day];
    }
}

-(void) soundBtnPressed:(id)sender {
    NSLog(@"SoundBtnPressed!");
    NSInteger numOfRepeats = [[Settings sharedSetting] getNumOfRepeationValue];
    NSLog(@"%d", numOfRepeats);
    //[AudioPlayer sharedAudioPlayer].numOfLoops = numOfRepeats;
    //[[AudioPlayer sharedAudioPlayer] playAudio:kAudio_Kor soundFileName:filePath];
    
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"mp3"];
    NSLog(@"filePath: %@", audioPath);
    
    AVAudioPlayer *tmpAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioPath] error:NULL];
    
    tmpAudioPlayer.numberOfLoops = numOfRepeats - 1;
    tmpAudioPlayer.volume = 1.0;
    
    //[tmpAudioPlayer prepareToPlay];
    [tmpAudioPlayer play];
    //[tmpAudioPlayer autorelease];
    
    //return tmpAudioPlayer;
}

@end
