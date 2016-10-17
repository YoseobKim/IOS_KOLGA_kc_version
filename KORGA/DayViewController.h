//
//  DayViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 7..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TutorialViewController;

@interface DayViewController : UIViewController {
    NSInteger _chapter;
    UIButton *backButton;
    UIView *bgView;
    UIButton *optionBtn;
    NSArray *scores;
    TutorialViewController *tv;
}

@property (nonatomic, retain) IBOutlet UIView *bgView;
@property (nonatomic) NSInteger _chapter;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property(nonatomic, retain) IBOutlet UIButton *optionBtn;

-(IBAction)backBtnPressed:(id)sender;
-(void) setChapter:(NSInteger)chapter;
-(IBAction)optionBtnPressed:(id)sender;

@end
