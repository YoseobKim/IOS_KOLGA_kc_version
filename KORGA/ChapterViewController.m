//
//  ChapterViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ChapterViewController.h"
#import "AppDelegate.h"
#import "OptionViewController.h"
#import "HighScores.h"
#import "TutorialViewController.h"
#import "Settings.h"

@interface ChapterViewController ()

@end

@implementation ChapterViewController
@synthesize scrollView, pageControl, bgView, optionBtn, leftArrowImageView, rightArrowImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[HighScores sharedHighScores] loadHighScores:0];
        ch1Progress = [NSArray arrayWithArray:[HighScores sharedHighScores].scoreArr];
        [[HighScores sharedHighScores] loadHighScores:1];
        ch2Progress = [NSArray arrayWithArray:[HighScores sharedHighScores].scoreArr];
        
        [self calculatePercent];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    leftArrowImageView.hidden = YES;
    
    for(int i = 0; i < NUM_OF_CHAPTER_PAGES; i++) {
        UIImage *img_t = [UIImage imageNamed:[NSString stringWithFormat:@"apple_front_chapter%d.png", i + 1]];
        
        UIImage *img;
        if(i == 0) {
            img = [self addPie:img_t radius:75.0f xPosition:img_t.size.width / 2 - 1.8 yPosiyion:182.0f progress_in_percent:ch1Percent]; 
        } else if(i == 1) {
            img = [self addPie:img_t radius:75.0f xPosition:img_t.size.width / 2 - 1.8 yPosiyion:182.0f progress_in_percent:ch2Percent];
        } else {
            img = img_t;
        }
        
        UIButton *chapterImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [chapterImgBtn setBackgroundImage:img forState:UIControlStateNormal];
        chapterImgBtn.frame = CGRectMake(scrollView.frame.size.width * i + 52, 46.2, img.size.width, img.size.height);
        [chapterImgBtn addTarget:self action:@selector(chapterBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [chapterImgBtn setTag:i];
        
        [scrollView addSubview:chapterImgBtn];
    }
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * NUM_OF_CHAPTER_PAGES, scrollView.frame.size.height)];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    
    pageControl.currentPage = 0;
    pageControl.numberOfPages = NUM_OF_CHAPTER_PAGES;
    //pageControl.frame = CGRectMake(pageControl.frame.origin.x, pageControl.frame.origin.y, 150, 50);
    [pageControl addTarget:self action:@selector(pageChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:pageControl];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDelegate.tutorialSkip = [[Settings sharedSetting] getTutorialOffValue];
    
    if(appDelegate != nil && !appDelegate.tutorialSkip) {
        TutorialViewController *tutorialView = [appDelegate createTutorialViewControllerWithViewType:ChapterView];
        tutorialView.view.frame = CGRectMake(0, 0, 320, 480);
        [self.view addSubview:tutorialView.view];
    }
}

- (void) chapterBtnPressed:(id)sender {
    NSInteger chapter = ((UIButton *)sender).tag;
    NSLog(@"Chapter %d Selected!", chapter);
    if(chapter == 2) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        [self.view removeFromSuperview];
        [appDelegate createDayViewController:chapter];
    }
}

-(UIImage *)addPie:(UIImage *)img radius:(CGFloat)radius xPosition:(CGFloat)xPos yPosiyion:(CGFloat)yPos progress_in_percent:(CGFloat)percent{
    
    int w = img.size.width;
    int h = img.size.height;
    CGFloat endDegree = 360 * (percent / 100);
    
    NSLog(@"%f", endDegree);
    
    yPos = h - yPos;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.3);
    CGContextMoveToPoint(context, xPos, yPos);
    if(endDegree <= 90 && endDegree >= 0) {
        endDegree = ABS(endDegree - 90);
    }
    else if (endDegree <= 360 && endDegree > 90) {
        endDegree = - (endDegree - 90);
    } 
    
    CGContextAddArc(context, xPos, yPos, radius, (0 + 90) * M_PI / 180.0,  endDegree * M_PI / 180.0, 1);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
}

- (void) pageChangeValue:(id)sender {
    UIPageControl *pControl = (UIPageControl *) sender;
    [scrollView setContentOffset:CGPointMake(pControl.currentPage * 320, 0) animated:YES];
}

//스크롤이 변경될때 page의 currentPage 설정
- (void)scrollViewDidScroll:(UIScrollView *)sender {  
    CGFloat pageWidth = scrollView.frame.size.width;  
    pageControl.currentPage = floor((scrollView.contentOffset.x - pageWidth / NUM_OF_CHAPTER_PAGES) / pageWidth) + 1;
    if(pageControl.currentPage <= 0) {
        leftArrowImageView.hidden = YES;
        rightArrowImageView.hidden = NO;
    } else if (pageControl.currentPage >= NUM_OF_CHAPTER_PAGES - 1) {
        leftArrowImageView.hidden = NO;
        rightArrowImageView.hidden = YES;
    } else {
        leftArrowImageView.hidden = NO;
        rightArrowImageView.hidden = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [scrollView flashScrollIndicators]; // 스크롤바를 보였다가 사라지게 함
}

-(void)optionBtnPressed:(id)sender {
    NSLog(@"Option Button Pressed");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if(appDelegate != nil) {
        //[self.view removeFromSuperview];
        [appDelegate createOptionViewController];
    }
}

- (void)calculatePercent {
    NSInteger ch1Count = 0;
    NSInteger ch2Count = 0;
    
    for(int i = 0; i < [ch1Progress count]; i++) {
        if([self getScoresFromDayScoreArray:i Arr:ch1Progress] > 0) {
            ch1Count++;
        }
    }
    
    for(int i = 0; i < [ch1Progress count]; i++) {
        if([self getScoresFromDayScoreArray:i Arr:ch2Progress] > 0) {
            ch2Count++;
        }
    }
    
    ch1Percent = ((CGFloat) ch1Count / 12) * 100;
    ch2Percent = ((CGFloat) ch2Count / 12) * 100;
}

- (NSInteger)getScoresFromDayScoreArray:(NSInteger)day Arr:(NSArray *)scores {
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

@end
