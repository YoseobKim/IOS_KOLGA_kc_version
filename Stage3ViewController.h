//
//  Stage3ViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalScrollMenuView.h"

#define NUM_OF_EXAMPLES_PER_ROW 3

@interface Stage3ViewController : UIViewController {
    NSInteger chapter;
    NSInteger day;
    HorizontalScrollMenuView *scrollMenuView1;
    HorizontalScrollMenuView *scrollMenuView2;
    HorizontalScrollMenuView *scrollMenuView3;
    HorizontalScrollMenuView *scrollMenuView4;
    HorizontalScrollMenuView *scrollMenuView5;
    UIImageView *scrollBGImageView1;
    UIImageView *scrollBGImageView2;
    UIImageView *scrollBGImageView3;
    UIImageView *scrollBGImageView4;
    UIImageView *scrollBGImageView5;
    UIImageView *oxImageView;
    UIImageView *baseImage;
    UIButton *bgImageButton;
    UIButton *explainBtn;
    
    UIImage *oImage;
    UIImage *xImage;
    
    UIButton *checkBtn;
    UIButton *settingBtn;
    UILabel *qLabel;
    
    NSInteger numOfQuestions;
    NSInteger numOfExamples;
    NSInteger questionIndex;
    NSInteger wrongCount;
    NSInteger totalWrongCount;
    
    NSMutableArray *questions;
    NSMutableArray *examples;
    NSMutableArray *qNumOfRows;
    NSMutableArray *answers;
    
    NSMutableArray *qArray1;
    NSMutableArray *qArray2;
    NSMutableArray *qArray3;
    NSMutableArray *qArray4;
    NSMutableArray *qArray5;
    
    NSMutableString *lastAnswer;
    
    NSTimer *timer;
    BOOL isHIT;
}

@property (nonatomic, retain) HorizontalScrollMenuView *scrollMenuView1;
@property (nonatomic, retain) HorizontalScrollMenuView *scrollMenuView2;
@property (nonatomic, retain) HorizontalScrollMenuView *scrollMenuView3;
@property (nonatomic, retain) HorizontalScrollMenuView *scrollMenuView4;
@property (nonatomic, retain) HorizontalScrollMenuView *scrollMenuView5;
@property (nonatomic, retain) IBOutlet UIButton *checkBtn;
@property (nonatomic, retain) IBOutlet UILabel *qLabel;
@property (nonatomic, retain) IBOutlet UIButton *settingBtn;
@property (nonatomic, retain) IBOutlet UIButton *explainBtn;
@property (nonatomic, retain) IBOutlet UIImageView *scrollBGImageView1;
@property (nonatomic, retain) IBOutlet UIImageView *scrollBGImageView2;
@property (nonatomic, retain) IBOutlet UIImageView *scrollBGImageView3;
@property (nonatomic, retain) IBOutlet UIImageView *scrollBGImageView4;
@property (nonatomic, retain) IBOutlet UIImageView *scrollBGImageView5;
@property (nonatomic, retain) IBOutlet UIImageView *oxImageView;
@property (nonatomic, retain) IBOutlet UIImageView *baseImage;
@property (nonatomic, retain) IBOutlet UIButton *bgImageButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day;
- (IBAction)checkBtnClicked:(id)sender;
- (IBAction)settingBtnPressed:(id)sender;
- (IBAction)bgImageClicked:(id)sender;
- (IBAction)explainBtnPressed:(id)sender;

@end
