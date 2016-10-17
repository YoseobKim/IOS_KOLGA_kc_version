//
//  OptionViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController {
    UIButton *soundRepeatBtn1;
    UIButton *soundRepeatBtn2;
    UIButton *soundRepeatBtn3;
    UIButton *vibrationSwitchBtn;
    UIButton *creditBtn;
    UIButton *optionBtn;
    
    NSInteger repeatTime;
    BOOL vibrateOn;
}

@property (nonatomic, retain) IBOutlet UIButton *soundRepeatBtn1;
@property (nonatomic, retain) IBOutlet UIButton *soundRepeatBtn2;
@property (nonatomic, retain) IBOutlet UIButton *soundRepeatBtn3;
@property (nonatomic, retain) IBOutlet UIButton *vibrationSwitchBtn;
@property (nonatomic, retain) IBOutlet UIButton *creditBtn;
@property (nonatomic, retain) IBOutlet UIButton *optionBtn;
@property (nonatomic) NSInteger repeatTime;
@property (nonatomic) BOOL vibrateOn;

- (void)showOptionView;
- (IBAction)hiddenThisView;
- (IBAction)soundRepeatBtn1Pressed:(id)sender;
- (IBAction)soundRepeatBtn2Pressed:(id)sender;
- (IBAction)soundRepeatBtn3Pressed:(id)sender;
- (IBAction)toggleEnabledVibrationSW:(id)sender;
- (IBAction)creditBtnPressed:(id)sender;
- (void)saveSetting;



@end
