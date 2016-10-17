//
//  Stage1ViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 13..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Stage1ViewController.h"
#import "AppDelegate.h"
#import "Stage1StartViewController.h"
#import "MenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Settings.h"
#import "SoundManager.h"

@interface Stage1ViewController ()

@end

@implementation Stage1ViewController

@synthesize bgBaseImageView, bgBaseView, bgImageView, settingBtn, elapsedTimeLabel, addTimeLabel, oxImageView, explainBtn;

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
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"stage_one_%d_%d.plist", chapter + 1, day + 1]];
        NSMutableDictionary *studyPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
        korDatas = (NSMutableArray *)[studyPlist objectForKey:@"Kor"];
        engDatas = (NSMutableArray *)[studyPlist objectForKey:@"Eng"];
        selectedEng = selectedKor = NOT_SELECTED;
        answerCount = wrongCount = 0;
        alreadyPressed_Eng = NO;
        alreadyPressed_Kor = NO;
        start = NO;
        
        for(int i = 0; i < 7; i++) {
            NSLog(@"%@", [korDatas objectAtIndex:i]);
            answers[i] = i;
        }
        
        [self shuffleQuestions];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSInteger btnXPos = 4;
    NSInteger btnYPos = 22;
    BOOL state = STATE_ENG;
    self.oxImageView.hidden = YES;
    self.explainBtn.hidden = YES;
    
    oImage = [UIImage imageNamed:@"o.png"];
    xImage = [UIImage imageNamed:@"x.png"];
    self.bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"game_1_item%d_%d.jpg", chapter + 1, day + 1]];
    
    for (int i = 0; i < 14; i++) {
        UIImage *img_normal = [UIImage imageNamed:@"Game1_button_00.png"];
        UIImage *img_clicked = [UIImage imageNamed:@"Game1_button_01.png"];
        
        UIButton *stoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stoneBtn setBackgroundImage:img_normal forState:(UIControlStateNormal)];
        [stoneBtn setBackgroundImage:img_clicked forState:(UIControlStateHighlighted)];
        [stoneBtn setBackgroundImage:img_clicked forState:(UIControlStateSelected)];
        //UIButton *dayImgBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        stoneBtn.frame = CGRectMake(btnXPos, btnYPos, img_normal.size.width, img_normal.size.height);
        [stoneBtn addTarget:self action:@selector(stoneBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [stoneBtn setTag:i];
        
        if(state == STATE_ENG) {
            NSString *titleString = (NSString *)[engDatas objectAtIndex:i / 2];
            
            [stoneBtn setTitle:titleString forState:(UIControlStateNormal)];
            [stoneBtn setTitle:titleString forState:(UIControlStateHighlighted)];
            [stoneBtn setTitle:titleString forState:(UIControlStateSelected)];
            [stoneBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
            
            state = !state;
        } else {
            NSString *titleString = (NSString *)[korDatas objectAtIndex:i / 2];
            [stoneBtn setTitle:titleString forState:(UIControlStateNormal)];
            [stoneBtn setTitle:titleString forState:(UIControlStateHighlighted)];
            [stoneBtn setTitle:titleString forState:(UIControlStateSelected)];
            [stoneBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
            
            state = !state;
        }
        
        [bgBaseView addSubview:stoneBtn];
        btnXPos += 155;
        
        if((i + 1) % 2 == 0) {
            btnYPos += 66;
            btnXPos = 4;
        }
    }
    //애니메이션 설정
    bgBaseImageView.animationImages = [NSArray arrayWithObjects: [UIImage imageNamed:@"Game1_base_ani00.png"], [UIImage imageNamed:@"Game1_base_ani01.png"], [UIImage imageNamed:@"Game1_base_ani02.png"], [UIImage imageNamed:@"Game1_base_ani03.png"], [UIImage imageNamed:@"Game1_base_ani04.png"], [UIImage imageNamed:@"Game1_base_ani05.png"], [UIImage imageNamed:@"Game1_base_ani06.png"], [UIImage imageNamed:@"Game1_base_ani07.png"], [UIImage imageNamed:@"Game1_base_ani08.png"], nil];
    
    bgBaseImageView.animationDuration = 1.0; //애니메이션 시간
    bgBaseImageView.animationRepeatCount = 1;
    
    //이미지 뷰 터치 이벤트 설정
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    //[tapRecognizer setDelegate:self];
    //Don't forget to set the userInteractionEnabled to YES, by default It's NO.
    bgImageView.userInteractionEnabled = YES;
    [bgImageView addGestureRecognizer:tapRecognizer];
    
    [self.view bringSubviewToFront:self.oxImageView];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil && !appDelegate.tutorialSkip) {
        TutorialViewController *tempView = [appDelegate createTutorialViewControllerWithViewType:Stage1View];
        tempView.view.frame = CGRectMake(0, 0, 320, 480);
        [self.view addSubview:tempView.view];
    }
}

- (void)stoneBtnPressed:(id)sender {
    BOOL state = !((UIButton *)sender).selected;
    NSInteger btnTag = ((UIButton *)sender).tag;
    NSLog(@"Btn %d Selected!", btnTag);
    [[SoundManager sharedSoundManager] playSystemSound:@"button" fileType:@"wav"];
    
    if(start == NO){
        // After shuffle, start timer.
        startDate = [[NSDate date] retain];
        pauseDate = [[NSDate date] timeIntervalSinceDate: startDate];
        // Create the stop watch timer that fires every 10 ms
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [self updateTimer];
        start = YES;
    }
    
    if(btnTag % 2 == 0) { //English Button
        if(alreadyPressed_Eng) {
            if(preSelected_Eng.tag == ((UIButton *)sender).tag) { //선택 해제
                [((UIButton *)sender) setSelected:NO];
                alreadyPressed_Eng = NO;
                selectedEng = NOT_SELECTED;
                return;
            }
            [((UIButton *)sender) setSelected:NO]; //영어 버튼이 이미 선택되어 있을 때
            return;
        }
        alreadyPressed_Eng = YES;
        preSelected_Eng = ((UIButton *)sender);
        selectedEng = btnTag / 2;
        NSLog(@"%@", [engDatas objectAtIndex:selectedEng]);
    } else if(btnTag % 2 != 0) { //Korean Button
        if(alreadyPressed_Kor) {
            if(preSelected_Kor.tag == ((UIButton *)sender).tag) { //선택 해제
                [((UIButton *)sender) setSelected:NO];
                alreadyPressed_Kor = NO;
                selectedKor = NOT_SELECTED;
                return;
            }
            [((UIButton *)sender) setSelected:NO]; //한국어 버튼이 이미 선택되어 있을 때
            return;
        }
        alreadyPressed_Kor = YES;
        preSelected_Kor = ((UIButton *)sender);
        selectedKor = (btnTag - 1) / 2;
        NSLog(@"%@", [korDatas objectAtIndex:selectedKor]);
    }
    
    if([self isHitAnswerWithSelectedEng:selectedEng selectedKor:selectedKor]) {
        preSelected_Kor.hidden = YES; // 버튼 사라짐
        preSelected_Eng.hidden = YES;
        alreadyPressed_Kor = NO; // 버튼 선택 해제
        alreadyPressed_Eng = NO;
        self.oxImageView.hidden = NO;
        self.oxImageView.image = oImage;
        [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
        NSLog(@"HIT");
        [[SoundManager sharedSoundManager] playSystemSound:@"button_ok" fileType:@"wav"];
        
        if(answerCount >= 7) { //7개 모두 맞추면 클리어
            NSLog(@"Clear");
            [[SoundManager sharedSoundManager] playSystemSound:@"correct" fileType:@"wav"];
            [stopWatchTimer invalidate];
            stopWatchTimer = nil;
            [self updateTimer];
            [bgBaseImageView startAnimating];
            [self performSelector:@selector(animationDone) withObject:nil afterDelay:1.0];
            self.explainBtn.hidden = NO;
        }
        return;
    } else {
        if(alreadyPressed_Eng && alreadyPressed_Kor) {
            NSLog(@"Wrong");
            [[SoundManager sharedSoundManager] playSystemSound:@"wrong" fileType:@"wav"];
            
            if([[Settings sharedSetting] getVibrationOnValue] == YES) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            wrongCount ++;
            addTimeLabel.text = [NSString stringWithFormat:@"Wrong: %2d", wrongCount];
            [((UIButton *)sender) setSelected:NO];
            self.oxImageView.hidden = NO;
            self.oxImageView.image = xImage;
            [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
            
            if(btnTag % 2 == 0) {
                alreadyPressed_Eng = NO; 
            } else if(btnTag % 2 != 0) {
                alreadyPressed_Kor = NO; 
            }
            return;
        }
    }
    
    [((UIButton *)sender) setSelected:state];
}

- (void)animationDone {
    bgBaseImageView.hidden = YES;
}

- (void)oxDone {
    self.oxImageView.hidden = YES;
}

- (BOOL)isHitAnswerWithSelectedEng:(NSInteger)_selectedEng selectedKor:(NSInteger)_selectedKor {
    NSInteger answer = answers[_selectedKor];
    if(_selectedEng == answer) {
        answerCount ++;
        return YES;
    }
    return NO;
}

- (void)settingBtnPressed:(id)sender {
    NSLog(@"Pressed");
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    pauseDate += [[NSDate date] timeIntervalSinceDate: startDate];
    [stopWatchTimer invalidate];
    
    if(appDelegate != nil) {
        [appDelegate createMenuViewControllerWithStage:1 Chapter:chapter Day:day];
    }
}

- (void)timerResume {
    if(start) {
        startDate = [[NSDate date] retain];
        
        //start the timer to update ui again
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
}

- (void)shuffleQuestions {
    static BOOL seeded = NO;
    if(!seeded)
    {
        seeded = YES;
        srandom(time(NULL));
    }
    
    NSUInteger count = [korDatas count];
    for (int i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (random() % nElements) + i;
        [korDatas exchangeObjectAtIndex:i withObjectAtIndex:n];
        
        int temp = answers[n];
        answers[n] = answers[i];
        answers[i] = temp;
    }
    for(int i = 0; i < count; i++) {
        NSLog(@"%d", answers[i]);
    }
}

- (void)updateTimer {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate] + pauseDate;
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    elapsedTimeLabel.text = timeString;
    [dateFormatter release];
}

-(IBAction) ClickEventOnImage:(UIGestureRecognizer *) sender {
    NSLog(@"Picture Touched");
    [self.view removeFromSuperview];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createStage1ClearViewControllerWithChapter:chapter Day:day ElapsedTime:elapsedTimeLabel.text AndWrongTrial:wrongCount];
        [appDelegate.stage1StartViewController.view removeFromSuperview];
    }
}

- (IBAction)explainBtnPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createExplainPageViewControllerWithChapter:chapter AndDay:day AndGameStage:1];
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

@end
