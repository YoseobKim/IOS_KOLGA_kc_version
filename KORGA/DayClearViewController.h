//
//  DayClearViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 17..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayClearViewController : UIViewController {
    NSInteger chapter;
    NSInteger day;
    NSInteger wrongCount;
    NSInteger numOfSmile;
    
    UILabel *chapterLabel;
    UILabel *dayLabel;
    UILabel *wrongLabel;
    UIImageView *smile1;
    UIImageView *smile2;
    UIImageView *smile3;
    UIImage *smileImage;
    UIImage *empty_smileImage;
    UIButton *settingBtn;
    UIButton *nextBtn;
    
    BOOL ch1Skip;
}

@property (nonatomic, retain) IBOutlet UILabel *chapterLabel;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;
@property (nonatomic, retain) IBOutlet UILabel *wrongLabel;
@property (nonatomic, retain) IBOutlet UIImageView *smile1;
@property (nonatomic, retain) IBOutlet UIImageView *smile2;
@property (nonatomic, retain) IBOutlet UIImageView *smile3;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;
@property (nonatomic, retain) IBOutlet UIButton *nextBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day wrongCount:(NSInteger)_wrong;
- (IBAction)settingBtnPressed:(id)sender;
- (IBAction)nextBtn:(id)sender;

@end
