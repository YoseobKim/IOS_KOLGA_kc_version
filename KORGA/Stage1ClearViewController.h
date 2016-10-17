//
//  Stage1ClearViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Stage1ClearViewController : UIViewController {
    NSInteger chapter;
    NSInteger day;
    NSInteger wrong;
    NSString *elapsedTime;
    UILabel *elapsedTimeLabel;
    UILabel *wrongTrialLabel;
    UILabel *stageLabel;
    UIButton *nextBtn;
    UIButton *settingBtn;
    UILabel *completeLabel;
}

@property (nonatomic) NSInteger chapter;
@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger wrong;
@property (nonatomic, retain) NSString *elapsedTime;
@property (nonatomic, retain) IBOutlet UILabel *elapsedTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *wrongTrialLabel;
@property (nonatomic, retain) IBOutlet UIButton *nextBtn;
@property (nonatomic, retain) IBOutlet UILabel *completeLabel;
@property (nonatomic, retain) IBOutlet UILabel *stageLabel;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day wrongTrial:(NSInteger)_wrong elapsedTime:(NSString *)_elapsedTime;
- (IBAction)nextBtnClicked:(id)sender;
- (IBAction)settingBtnPressed:(id)sender;

@end
