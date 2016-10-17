//
//  AppDelegate.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 6..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"

@class RootViewController;
@class DayViewController;
@class StudyPageAppViewController;
@class StudyPageViewController;
@class Stage1ViewController;
@class Stage1StartViewController;
@class Stage1ClearViewController;
@class Stage3StartViewController;
@class Stage3ViewController;
@class ChapterViewController;
@class DayClearViewController;
@class OptionViewController;
@class MenuViewController;
@class GNDPageAppViewController;
@class GNDPageViewController;
@class CreditViewController;
@class ExplainPageViewController;
//@class TutorialViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    DayViewController *dayViewController;
    StudyPageAppViewController *studyViewController;
    StudyPageViewController *studyPageViewController;
    Stage1ViewController *stage1ViewController;
    Stage1StartViewController *stage1StartViewController;
    Stage1ClearViewController *stage1ClearViewController;
    Stage3StartViewController *stage3StartViewController;
    Stage3ViewController *stage3ViewController;
    ChapterViewController *chapterViewController;
    DayClearViewController *dayClearViewController;
    OptionViewController *optionViewController;
    MenuViewController *menuViewController;
    GNDPageAppViewController *gndPageAppViewController;
    GNDPageViewController *gndPageViewController;
    CreditViewController *creditViewController;
    ExplainPageViewController *explainPageViewController;
    
    BOOL ch1Skip;
    BOOL tutorialSkip;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) DayViewController *dayViewController;
@property (nonatomic, retain) StudyPageAppViewController *studyViewController;
@property (nonatomic, retain) StudyPageViewController *studyPageViewController;
@property (nonatomic, retain) Stage1ViewController *stage1ViewController;
@property (nonatomic, retain) Stage1StartViewController *stage1StartViewController;
@property (nonatomic, retain) Stage1ClearViewController *stage1ClearViewController;
@property (nonatomic, retain) Stage3StartViewController *stage3StartViewController;
@property (nonatomic, retain) Stage3ViewController *stage3ViewController;
@property (nonatomic, retain) ChapterViewController *chapterViewController;
@property (nonatomic, retain) DayClearViewController *dayClearViewController;
@property (nonatomic, retain) OptionViewController *optionViewController;
@property (nonatomic, retain) MenuViewController *menuViewController;
@property (nonatomic, retain) GNDPageAppViewController *gndPageAppViewController;
@property (nonatomic, retain) GNDPageViewController *gndPageViewController;
@property (nonatomic, retain) CreditViewController *creditViewController;
@property (nonatomic, retain) ExplainPageViewController *explainPageViewController;

@property (nonatomic) BOOL ch1Skip;
@property (nonatomic) BOOL tutorialSkip;

-(void) createChapterViewController;
-(void) createOptionViewController;
-(void) createMenuViewControllerWithStage:(NSInteger)stage Chapter:(NSInteger)chapter Day:(NSInteger)day;
-(void) createDayViewController:(NSInteger)chapter;
-(void) createStudyViewControllerWithChapter:(NSInteger)chapter AndDay:(NSInteger)day;
-(void) createStage1StartViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day;
-(void) createStage1ViewController:(UIViewController *)nowView Chapter:(NSInteger)_chapter AndDay:(NSInteger)_day;
-(void) createStage1ClearViewControllerWithChapter:(NSInteger)_chapter Day:(NSInteger)_day ElapsedTime:(NSString *)_elapsedTime AndWrongTrial:(NSInteger)_wrong;
-(void) createStage3StartViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day;
-(void) createStage3ViewController:(UIViewController *)nowView Chapter:(NSInteger)_chapter AndDay:(NSInteger)_day;
-(void) createDayClearViewControllerWithChapter:(NSInteger)_chapter Day:(NSInteger)_day WrongCount:(NSInteger)_wrong;
-(void) createGNDPageAppViewController;
-(void) createCreditViewController;
-(void) createExplainPageViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day AndGameStage:(NSInteger)_gameStage;
-(TutorialViewController *) createTutorialViewControllerWithViewType:(ViewType)_type;

@end
