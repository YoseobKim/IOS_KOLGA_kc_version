//
//  Stage1ViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 13..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define STATE_KOR YES
#define STATE_ENG NO
#define NOT_SELECTED INT_MAX

@class Stage1StartViewController;

@interface Stage1ViewController : UIViewController {
    int chapter;
    int day;
    
    UIView *bgBaseView;
    UIImageView *bgBaseImageView;
    UIImageView *bgImageView;
    UIButton *settingBtn;
    UIButton *explainBtn;
    UILabel *elapsedTimeLabel;
    UILabel *addTimeLabel;
    UIImageView *oxImageView;
    
    NSMutableArray *engDatas;
    NSMutableArray *korDatas;
    
    int answers[7];
    int selectedEng;
    int selectedKor;
    int answerCount;
    int wrongCount;

    BOOL alreadyPressed_Eng;
    BOOL alreadyPressed_Kor;
    BOOL start;
    
    UIButton *preSelected_Eng;
    UIButton *preSelected_Kor;
    
    NSTimer *stopWatchTimer;
    NSDate *startDate;
    NSTimeInterval pauseDate;
    UIImage *oImage;
    UIImage *xImage;
}

@property (nonatomic, retain) IBOutlet UIView *bgBaseView;
@property (nonatomic, retain) IBOutlet UIImageView *bgBaseImageView;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;
@property (nonatomic, retain) IBOutlet UILabel *elapsedTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *addTimeLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *oxImageView;
@property (nonatomic, retain) IBOutlet UIButton *explainBtn;

- (IBAction)settingBtnPressed:(id)sender;
- (IBAction)explainBtnPressed:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day;
- (void)timerResume;

@end
