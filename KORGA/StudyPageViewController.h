//
//  StudyPageViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StudyPageAppViewController;

@interface StudyPageViewController : UIViewController {
    NSString *_mDayString;
    NSString *_mPageString;
    NSString *_mUpContentString;
    NSString *_mMidContentString;
    NSString *_mDownContentString;
    NSInteger chapter;
    NSInteger page;
    NSInteger maxPage;
    NSInteger day;
    
    UILabel *_mDayLabel;
    UILabel *_mPageLabel;
    UILabel *_mUpContentLabel;
    UILabel *_mMidContentLabel;
    UILabel *_mDownContentLabel;
    UILabel *_titleLabel;
    
    UIButton *settingBtn;
    UIButton *finderBtn;
    UIButton *gameStartBtn;
    UIButton *soundBtn;
    
    UIImageView *bgView;
    UIImage *bgImage_f;
    UIImage *bgImage_n;
    UIImage *bgImage_e;
    UIImageView *rightImageView;
    
    StudyPageAppViewController* parent;
    
    NSString *filePath;
}

@property (nonatomic, strong) IBOutlet UILabel *_mDayLabel;
@property (nonatomic, strong) IBOutlet UILabel *_mPageLabel;
@property (nonatomic, strong) IBOutlet UILabel *_mUpContentLabel;
@property (nonatomic, strong) IBOutlet UILabel *_mMidContentLabel;
@property (nonatomic, strong) IBOutlet UILabel *_mDownContentLabel;
@property (nonatomic, strong) IBOutlet UILabel *_titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bgView;
@property (nonatomic, retain) IBOutlet UIImageView *rightImageView;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;
@property (nonatomic, retain) IBOutlet UIButton *finderBtn;
@property (nonatomic, retain) IBOutlet UIButton *gameStartBtn;
@property (nonatomic, retain) IBOutlet UIButton *soundBtn;

@property (nonatomic, strong) NSString *_mDayString;
@property (nonatomic, strong) NSString *_mPageString;
@property (nonatomic, strong) NSString *_mUpContentString;
@property (nonatomic, strong) NSString *_mMidContentString;
@property (nonatomic, strong) NSString *_mDownContentString;
@property (nonatomic) NSInteger chapter;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger maxPage;
@property (nonatomic) NSInteger day;

@property (nonatomic, retain) StudyPageAppViewController* parent;

@property (nonatomic, retain) NSString *filePath;

-(IBAction)settingBtnPressed:(id)sender;
-(IBAction)finderBtnPressed:(id)sender;
-(IBAction)gameStartBtnPressed:(id)sender;
-(IBAction)soundBtnPressed:(id)sender;

@end
