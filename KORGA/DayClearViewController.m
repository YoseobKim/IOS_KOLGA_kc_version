//
//  DayClearViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 17..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DayClearViewController.h"
#import "AppDelegate.h"
#import "Stage3ViewController.h"
#import "HighScores.h"
#import "MenuViewController.h"
#import "SoundManager.h"

@interface DayClearViewController ()

@end

@implementation DayClearViewController

@synthesize chapterLabel, dayLabel, wrongLabel, smile1, smile2, smile3, settingBtn, nextBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day wrongCount:(NSInteger)_wrong {
    chapter = _chapter;
    day = _day;
    wrongCount = _wrong;
    
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    smileImage = [UIImage imageNamed:@"smile.png"];
    empty_smileImage = [UIImage imageNamed:@"smile_empty.png"];
    
    [chapterLabel setText:[NSString stringWithFormat:@"%d", chapter + 1]];
    [dayLabel setText:[NSString stringWithFormat:@"%d", day + 1]];
    [wrongLabel setText:[NSString stringWithFormat:@"%d", wrongCount]];
    [[SoundManager sharedSoundManager] playSystemSound:@"clear" fileType:@"wav"];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(appDelegate != nil) {
        ch1Skip = appDelegate.ch1Skip;
        appDelegate.ch1Skip = NO;
    }
    
    if(wrongCount <= 4 && !ch1Skip) {
        smile1.image = smileImage;
        smile2.image = smileImage;
        smile3.image = smileImage;
        [[HighScores sharedHighScores] saveNewRecord:3 chapter:chapter day:day];
    } else if(wrongCount >= 5 && wrongCount <= 15) {
        smile1.image = smileImage;
        smile2.image = smileImage;
        smile3.image = empty_smileImage;
        [[HighScores sharedHighScores] saveNewRecord:2 chapter:chapter day:day];
    } else {
        smile1.image = smileImage;
        smile2.image = empty_smileImage;
        smile3.image = empty_smileImage;
        [[HighScores sharedHighScores] saveNewRecord:1 chapter:chapter day:day];
    }
    
    self.smile1.transform=CGAffineTransformMakeScale(0.1, 0.1);
    self.smile1.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        self.smile1.transform=CGAffineTransformMakeScale(1, 1); 
        self.smile1.alpha = 1;
    } completion:^(BOOL finished){
        self.smile1.transform=CGAffineTransformIdentity;
    }];
    
    self.smile2.transform=CGAffineTransformMakeScale(0.1, 0.1);
    self.smile2.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        self.smile2.transform=CGAffineTransformMakeScale(1, 1); 
        self.smile2.alpha = 1;
    } completion:^(BOOL finished){
        self.smile2.transform=CGAffineTransformIdentity;
    }];
    
    self.smile3.transform=CGAffineTransformMakeScale(0.1, 0.1);
    self.smile3.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        self.smile3.transform=CGAffineTransformMakeScale(1, 1); 
        self.smile3.alpha = 1;
    } completion:^(BOOL finished){
        self.smile3.transform=CGAffineTransformIdentity;
    }];
}

- (IBAction)settingBtnPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate createMenuViewControllerWithStage:4 Chapter:chapter Day:day];
    }
}

- (IBAction)nextBtn:(id)sender {
    NSLog(@"GOTO NEXT DAY");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if(day == 11) {
        if(chapter == 1) {
            [self.view removeFromSuperview];
            [appDelegate.stage3ViewController.view removeFromSuperview];
            [appDelegate createDayViewController:chapter];
            return;
        }
        chapter++;
        day = 0;
    } else {
        day++;
    }
    
    [self.view removeFromSuperview];
    //[parent performSelector:@selector(removeThisView)];
    //AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [appDelegate.stage3ViewController.view removeFromSuperview];
        [appDelegate createStudyViewControllerWithChapter:chapter AndDay:day];
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
