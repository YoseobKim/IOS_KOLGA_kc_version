//
//  Stage3StartViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Stage3StartViewController : UIViewController {
    NSInteger chapter;
    NSInteger day;
    
    UIButton *bgBtn;
    UIButton *settingBtn;
}

@property (nonatomic, retain) IBOutlet UIButton *bgBtn;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day;
- (void)removeThisView;
- (IBAction)bgBtnTouched:(id)sender;
- (IBAction)settingBtnPressed:(id)sender;

@end
