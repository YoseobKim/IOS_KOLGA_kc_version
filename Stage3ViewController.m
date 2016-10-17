//
//  Stage3ViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Stage3ViewController.h"
#import "AppDelegate.h"
#import "Stage3StartViewController.h"
#import "Stage1ClearViewController.h"
#import "MenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Settings.h"
#import "SoundManager.h"

@interface Stage3ViewController ()

@end

@implementation Stage3ViewController

@synthesize scrollMenuView1, scrollMenuView2, scrollMenuView3, scrollMenuView4, scrollMenuView5, checkBtn, qLabel, settingBtn, scrollBGImageView1, scrollBGImageView2, scrollBGImageView3, scrollBGImageView4, scrollBGImageView5, oxImageView, baseImage, bgImageButton, explainBtn;

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
        wrongCount = 0;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"stage_three_%d_%d.plist", chapter + 1, day + 1]];
        NSMutableDictionary *studyPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
        questions = (NSMutableArray *)[studyPlist objectForKey:@"Questions"];
        qNumOfRows = (NSMutableArray *)[studyPlist objectForKey:@"QNumOfRows"];
        answers = (NSMutableArray *)[studyPlist objectForKey:@"Answers"];
        
        questionIndex = 0;
        examples = [[NSMutableArray alloc] init];
        for(NSInteger i = 0; i < questions.count; i++) {
            [examples addObject: (NSMutableArray *)[studyPlist objectForKey:[NSString stringWithFormat:@"QExamples%d",i + 1]]];
            [self shuffleExamples:[examples objectAtIndex:i]];
            NSLog(@"QExamples%d", i + 1);
            for(NSInteger j = 0; j < [[examples objectAtIndex:i] count]; j++) {
                NSLog(@"%@", [[examples objectAtIndex:i] objectAtIndex:j]);
            }
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [qLabel setText:(NSString *)[questions objectAtIndex:questionIndex]];
    NSLog(@"%@", qLabel.text);
    explainBtn.hidden = YES;
    
    self.oxImageView.hidden = YES;
    oImage = [UIImage imageNamed:@"o.png"];
    xImage = [UIImage imageNamed:@"x.png"];
    
    qArray1 = [[NSMutableArray alloc] init];
    qArray2 = [[NSMutableArray alloc] init];
    qArray3 = [[NSMutableArray alloc] init];
    qArray4 = [[NSMutableArray alloc] init];
    qArray5 = [[NSMutableArray alloc] init];
    
    bgImageButton.hidden = YES;
    
    UIImage *bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"game_3_item%d_%d.jpg", chapter + 1, day + 1]];
    
    [bgImageButton setImage:bgImg forState:(UIControlStateNormal)];
    
    for (int i = 0; i < NUM_OF_EXAMPLES_PER_ROW; i++) {
		// 커스텀 타입의 버튼 생성.
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
		UIImage *buttonBackground = [UIImage imageNamed:@"Game_3_text.jpg"];
		
		[btn setFrame:CGRectMake(0.0f, 0.0f, 240.0f, 34.0f)];
		[btn setBackgroundImage:buttonBackground forState:UIControlStateDisabled];
		[btn setTag:i];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [btn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        
        [btn setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i]] forState:UIControlStateDisabled];
        
		[qArray1 addObject:btn];
		
        btn.enabled = NO;
		[btn release];
        
        // 커스텀 타입의 버튼 생성.
		btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		[btn setFrame:CGRectMake(0.0f, 0.0f, 240.0f, 34.0f)];
		[btn setBackgroundImage:buttonBackground forState:UIControlStateDisabled];
		[btn setTag:i];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [btn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        [btn setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 3]] forState:UIControlStateDisabled];
        
		[qArray2 addObject:btn];
        
        btn.enabled = NO;
        [btn release];
        
        // 커스텀 타입의 버튼 생성.
		btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
		[btn setFrame:CGRectMake(0.0f, 0.0f, 240.0f, 34.0f)];
		[btn setBackgroundImage:buttonBackground forState:UIControlStateDisabled];
		[btn setTag:i];
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:(UIControlStateDisabled)]; //By default.
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [btn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 3) {
            [btn setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 6]] forState:UIControlStateDisabled];
        }
        
		[qArray3 addObject:btn];
        
        btn.enabled = NO;
        [btn release];
        
        // 커스텀 타입의 버튼 생성.
		btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		[btn setFrame:CGRectMake(0.0f, 0.0f, 240.0f, 34.0f)];
		[btn setBackgroundImage:buttonBackground forState:UIControlStateDisabled];
		[btn setTag:i];
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:(UIControlStateDisabled)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [btn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 4) {
            [btn setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 9]] forState:UIControlStateDisabled];
        }
        
		[qArray4 addObject:btn];
        
        btn.enabled = NO;
        [btn release];
        
        // 커스텀 타입의 버튼 생성.
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		
		[btn setFrame:CGRectMake(0.0f, 0.0f, 240.0f, 34.0f)];
		[btn setBackgroundImage:buttonBackground forState:UIControlStateDisabled];
		[btn setTag:i];
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:(UIControlStateDisabled)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [btn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 5) {
            [btn setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 12]] forState:UIControlStateDisabled];
        }
        
		[qArray5 addObject:btn];
        
        btn.enabled = NO;
        [btn release];
	}
    
    scrollMenuView1 = [[HorizontalScrollMenuView alloc] initWithFrameColorAndButtons:CGRectMake(40.0f, 103.0f, 240.0f,  34.0f) backgroundColor:[UIColor blackColor]  buttons:qArray1];
    scrollMenuView2 = [[HorizontalScrollMenuView alloc] initWithFrameColorAndButtons:CGRectMake(40.0f, 161.0f, 240.0f,  34.0f) backgroundColor:[UIColor blackColor]  buttons:qArray2];
    scrollMenuView3 = [[HorizontalScrollMenuView alloc] initWithFrameColorAndButtons:CGRectMake(40.0f, 219.0f, 240.0f,  34.0f) backgroundColor:[UIColor blackColor]  buttons:qArray3];
    scrollMenuView4 = [[HorizontalScrollMenuView alloc] initWithFrameColorAndButtons:CGRectMake(40.0f, 277.0f, 240.0f,  34.0f) backgroundColor:[UIColor blackColor]  buttons:qArray4];
    scrollMenuView5 = [[HorizontalScrollMenuView alloc] initWithFrameColorAndButtons:CGRectMake(40.0f, 335.0f, 240.0f,  34.0f) backgroundColor:[UIColor blackColor]  buttons:qArray5];
    
    [self.view addSubview:scrollMenuView1];
    [self.view addSubview:scrollMenuView2];
    [self.view addSubview:scrollMenuView3];
    [self.view addSubview:scrollMenuView4];
    [self.view addSubview:scrollMenuView5];
    
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) <= 2) {
        scrollMenuView3.hidden = YES;
        scrollMenuView4.hidden = YES;
        scrollMenuView5.hidden = YES;
        scrollBGImageView3.hidden = YES;
        scrollBGImageView4.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) <= 3) {
        scrollMenuView4.hidden = YES;
        scrollMenuView5.hidden = YES;
        scrollBGImageView4.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue])<= 4) {
        scrollMenuView5.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
    
    self.checkBtn.imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Game_3_Key_00.png"],[UIImage imageNamed:@"Game_3_Key_01.png"], [UIImage imageNamed:@"Game_3_Key_02.png"], [UIImage imageNamed:@"Game_3_Key_03.png"], [UIImage imageNamed:@"Game_3_Key_04.png"], [UIImage imageNamed:@"Game_3_Key_03.png"], [UIImage imageNamed:@"Game_3_Key_02.png"], [UIImage imageNamed:@"Game_3_Key_01.png"], nil];
    self.checkBtn.imageView.animationDuration = 1.5f;
    self.checkBtn.imageView.animationRepeatCount = 0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(correctionCheck) userInfo:nil repeats:YES];
    [self.checkBtn.imageView startAnimating];
    
    [self.view bringSubviewToFront:self.oxImageView];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil && !appDelegate.tutorialSkip) {
        TutorialViewController *temp = [appDelegate createTutorialViewControllerWithViewType:Stage2View];
        temp.view.frame = CGRectMake(0, 0, 320, 480);
        [self.view addSubview:temp.view];
    }
}

- (IBAction)settingBtnPressed:(id)sender {
    NSLog(@"settingBtnPressed");
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createMenuViewControllerWithStage:3 Chapter:chapter Day:day];
    }
}

- (IBAction)explainBtnPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createExplainPageViewControllerWithChapter:chapter AndDay:day AndGameStage:3];
    }
}

- (IBAction)checkBtnClicked:(id)sender {
    if((questionIndex + 1) >= questions.count) {
        NSLog(@"no more questions");
        if(isHIT) {
            NSLog(@"Clear");
            [[SoundManager sharedSoundManager] playSystemSound:@"lock" fileType:@"wav"];
            oxImageView.hidden = NO;
            explainBtn.hidden = NO;
            oxImageView.image = oImage;
            [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
            scrollMenuView1.hidden = YES;
            scrollMenuView2.hidden = YES;
            scrollMenuView3.hidden = YES;
            scrollMenuView4.hidden = YES;
            scrollMenuView5.hidden = YES;
            scrollBGImageView1.hidden = YES;
            scrollBGImageView2.hidden = YES;
            scrollBGImageView3.hidden = YES;
            scrollBGImageView4.hidden = YES;
            scrollBGImageView5.hidden = YES;
            checkBtn.hidden = YES;
            qLabel.hidden = YES;
            bgImageButton.hidden = NO;
            
            [self gameClearAnimation:baseImage duration:1.0 curve:UIViewAnimationCurveLinear x:0.0f y:-480.0f];
            [self performSelector:@selector(gameClearAnimationDone) withObject:nil afterDelay:1.0];
            return;
        }
        else {
            NSLog(@"Wrong");
            [[SoundManager sharedSoundManager] playSystemSound:@"wrong" fileType:@"wav"];
            wrongCount++;
            oxImageView.hidden = NO;
            oxImageView.image = xImage;
            if([[Settings sharedSetting] getVibrationOnValue] == YES) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
        }
    } else {
        if(isHIT) {
            oxImageView.hidden = NO;
            oxImageView.image = oImage;
            [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
            
            NSLog(@"Hit");
            [[SoundManager sharedSoundManager] playSystemSound:@"correct" fileType:@"wav"];
            questionIndex++;
            [self nextQuestion];
        } else {
            oxImageView.hidden = NO;
            oxImageView.image = xImage;
            if([[Settings sharedSetting] getVibrationOnValue] == YES) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
            [self performSelector:@selector(oxDone) withObject:nil afterDelay:0.5];
            wrongCount++;
            [[SoundManager sharedSoundManager] playSystemSound:@"wrong" fileType:@"wav"];
            NSLog(@"Wrong");
        }
        
    }
    
    scrollMenuView1.hidden = NO;
    scrollMenuView2.hidden = NO;
    scrollMenuView3.hidden = NO;
    scrollMenuView4.hidden = NO;
    scrollMenuView5.hidden = NO;
    scrollBGImageView1.hidden = NO;
    scrollBGImageView2.hidden = NO;
    scrollBGImageView3.hidden = NO;
    scrollBGImageView4.hidden = NO;
    scrollBGImageView5.hidden = NO;
    
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) <= 2) {
        scrollMenuView3.hidden = YES;
        scrollMenuView4.hidden = YES;
        scrollMenuView5.hidden = YES;
        scrollBGImageView3.hidden = YES;
        scrollBGImageView4.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) <= 3) {
        scrollMenuView4.hidden = YES;
        scrollMenuView5.hidden = YES;
        scrollBGImageView4.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue])<= 4) {
        scrollMenuView5.hidden = YES;
        scrollBGImageView5.hidden = YES;
    }
}

- (IBAction)bgImageClicked:(id)sender {
    [self.view removeFromSuperview];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate.stage3StartViewController.view removeFromSuperview];
        totalWrongCount = wrongCount + appDelegate.stage1ClearViewController.wrong;
        [appDelegate createDayClearViewControllerWithChapter:chapter Day:day WrongCount:totalWrongCount];
    }
}

- (void)oxDone {
    self.oxImageView.hidden = YES;
}

- (void)gameClearAnimationDone {
    self.baseImage.hidden = YES;
}

- (void)nextQuestion {
    [qLabel setText:[questions objectAtIndex: questionIndex]];
    
    for (int i = 0; i < NUM_OF_EXAMPLES_PER_ROW; i++) {
        [((UIButton *)[qArray1 objectAtIndex:i]) setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i]] forState:UIControlStateDisabled];
        [((UIButton *)[qArray2 objectAtIndex:i]) setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 3]] forState:UIControlStateDisabled];
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 3) {
            [((UIButton *)[qArray3 objectAtIndex:i]) setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 6]] forState:UIControlStateDisabled];
        }
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 4) {
            [((UIButton *)[qArray4 objectAtIndex:i]) setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 9]] forState:UIControlStateDisabled];
        }
        if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 5) {
            [((UIButton *)[qArray5 objectAtIndex:i]) setTitle:[NSString stringWithFormat:@"%@", [[examples objectAtIndex:questionIndex] objectAtIndex: i + 12]] forState:UIControlStateDisabled];
        }
    }
}

- (void)gameClearAnimation:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y {
    // Setup the animation
    [self.checkBtn.imageView startAnimating];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (void)shuffleExamples:(NSMutableArray *)array {
    static BOOL seeded = NO;
    if(!seeded)
    {
        seeded = YES;
        srandom(time(NULL));
    }
    
    NSUInteger count = [array count];
    NSInteger numOfRows = count / 3;
    for(int i = 0; i < numOfRows; i++) {
        for (int j = i * 3; j < (i * 3) + 3; ++j) { // 3개씩 이루어진 예제 배열을 순차적으로 섞는다.
            // Select a random element between j and end of array to swap with.
            int nElements = (i * 3 + 3) - j;
            int n = (random() % nElements) + j;
            [array exchangeObjectAtIndex:j withObjectAtIndex:n];
        }
    }
}

- (void) correctionCheck {
    NSString *sel1 = ((UIButton *)[qArray1 objectAtIndex:(scrollMenuView1.curPage)]).titleLabel.text;
    NSString *sel2 = ((UIButton *)[qArray2 objectAtIndex:(scrollMenuView2.curPage)]).titleLabel.text;
    NSString *sel3 = ((UIButton *)[qArray3 objectAtIndex:(scrollMenuView3.curPage)]).titleLabel.text;
    NSString *sel4 = ((UIButton *)[qArray4 objectAtIndex:(scrollMenuView4.curPage)]).titleLabel.text;
    NSString *sel5 = ((UIButton *)[qArray5 objectAtIndex:(scrollMenuView5.curPage)]).titleLabel.text;
    
    lastAnswer = [NSMutableString stringWithFormat:@"%@ %@", sel1, sel2]; 
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 3) {
        [lastAnswer appendString:[NSString stringWithFormat:@" %@", sel3]];
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 4) {
        [lastAnswer appendString:[NSString stringWithFormat:@" %@", sel4]];
    }
    if(([[qNumOfRows objectAtIndex:questionIndex] intValue]) >= 5) {
        [lastAnswer appendString:[NSString stringWithFormat:@" %@", sel5]];
    }
    
    //NSLog(@"correctionCheck method called");
    if([lastAnswer isEqualToString:[answers objectAtIndex:questionIndex]]) {
        isHIT = YES;
    } else {
        isHIT = NO;
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
