//
//  ExplainPageViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplainPageViewController : UIViewController {
    UIButton *btnExit;
    UILabel *korLabel;
    UILabel *engLabel;
    UILabel *descLabel;
    NSInteger day;
    NSInteger chapter;
    NSInteger gameStage;
    
    NSArray *korString;
    NSArray *engString;
    NSArray *descString;
}

@property (nonatomic, retain) IBOutlet UIButton *btnExit;
@property (nonatomic, retain) IBOutlet UILabel *korLabel;
@property (nonatomic, retain) IBOutlet UILabel *engLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger chapter;
@property (nonatomic) NSInteger gameStage;

- (IBAction)exitBtnPressed:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day gameStage:(NSInteger)_gameStage;

@end
