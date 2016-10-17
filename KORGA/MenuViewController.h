//
//  MenuViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController {
    UIButton *homeBtn;
    UIButton *dayBtn;
    UIButton *backBtn;
    UIButton *skipBtn;
    UIButton *restartBtn;
    
    NSInteger stage;
    NSInteger chapter;
    NSInteger day;
    
    BOOL ch1Skip;
    BOOL timerStart;
}

@property (nonatomic, retain) IBOutlet UIButton *homeBtn;
@property (nonatomic, retain) IBOutlet UIButton *dayBtn;
@property (nonatomic, retain) IBOutlet UIButton *backBtn;
@property (nonatomic, retain) IBOutlet UIButton *skipBtn;
@property (nonatomic, retain) IBOutlet UIButton *restartBtn;
@property (nonatomic) BOOL ch1Skip;

- (void)showMenuViewWithStage:(NSInteger)_stage chapter:(NSInteger)_chapter day:(NSInteger)_day;
- (void)hiddenThisView;
- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)dayBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)skipBtnPressed:(id)sender;
- (IBAction)restartBtnPressed:(id)sender;

@end
