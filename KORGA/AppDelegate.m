//
//  AppDelegate.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 6..
//  Copyright __MyCompanyName__ 2012년. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "ChapterViewController.h"
#import "RootViewController.h"
#import "HelloWorldLayer.h"
#import "DayViewController.h"
#import "StudyPageAppViewController.h"
#import "Stage1ViewController.h"
#import "Stage1StartViewController.h"
#import "Stage1ClearViewController.h"
#import "Stage3StartViewController.h"
#import "Stage3ViewController.h"
#import "ChapterViewController.h"
#import "DayClearViewController.h"
#import "OptionViewController.h"
#import "MenuViewController.h"
#import "GNDPageAppViewController.h"
#import "CreditViewController.h"
#import "ExplainPageViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize dayViewController, studyViewController, stage1ViewController, stage1StartViewController, stage1ClearViewController, stage3StartViewController, stage3ViewController, chapterViewController, dayClearViewController, optionViewController, studyPageViewController, menuViewController, ch1Skip, gndPageAppViewController, gndPageViewController, creditViewController, explainPageViewController, tutorialSkip;

- (void) removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
    
    //	CC_ENABLE_DEFAULT_GL_STATES();
    //	CCDirector *director = [CCDirector sharedDirector];
    //	CGSize size = [director winSize];
    //	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
    //	sprite.position = ccp(size.width/2, size.height/2);
    //	sprite.rotation = -90;
    //	[sprite visit];
    //	[[director openGLView] swapBuffers];
    //	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}
- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	//
	// Create the EAGLView manually
	//  1. Create a RGB565 format. Alternative: RGBA8
	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
	//
	//
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
    //	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    //	if( ! [director enableRetinaDisplay:YES] )
    //		CCLOG(@"Retina Display Not supported");
	
	//
	// VERY IMPORTANT:
	// If the rotation is going to be controlled by a UIViewController
	// then the device orientation should be "Portrait".
	//
	// IMPORTANT:
	// By default, this template only supports Landscape orientations.
	// Edit the RootViewController.m file to edit the supported orientations.
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
#else
	[director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
#endif
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
	
	// Removes the startup flicker
	[self removeStartupFlicker];
	
    chapterViewController = [[ChapterViewController alloc] initWithNibName:@"ChapterViewController" bundle:nil];
    chapterViewController.view.frame = CGRectMake(0, 0, 320, 480);
    chapterViewController.view.hidden = NO;
    chapterViewController.view.center = window.center;
    
	// Run the intro Scene
	//[[CCDirector sharedDirector] runWithScene: [HelloWorldLayer scene]];
    [window addSubview:chapterViewController.view];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
	[super dealloc];
}

-(void)createOptionViewController {
    optionViewController = [[OptionViewController alloc] initWithNibName:@"OptionViewController" bundle:nil];
    optionViewController.view.frame = CGRectMake(0, 0, 320, 480);
    optionViewController.view.hidden = NO;
    optionViewController.view.center = window.center;
    
    [window addSubview:optionViewController.view];
}

-(void) createMenuViewControllerWithStage:(NSInteger)stage Chapter:(NSInteger)chapter Day:(NSInteger)day {
    menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    menuViewController.view.frame = CGRectMake(0, 0, 320, 480);
    menuViewController.view.hidden = NO;
    menuViewController.view.center = window.center;
    
    [window addSubview:menuViewController.view];
    [menuViewController showMenuViewWithStage:stage chapter:chapter day:day];
}

-(void)createChapterViewController {
    chapterViewController = [[ChapterViewController alloc] initWithNibName:@"ChapterViewController" bundle:nil];
    chapterViewController.view.frame = CGRectMake(0, 0, 480, 320);
    chapterViewController.view.hidden = NO;
    chapterViewController.view.center = window.center;
    chapterViewController.view.transform = CGAffineTransformIdentity;
    [window addSubview:chapterViewController.view];
}

-(void)createDayViewController:(NSInteger)chapter {
    dayViewController = [[DayViewController alloc] initWithNibName:@"DayViewController" bundle:nil];
    dayViewController.view.frame = CGRectMake(0, 0, 480, 320);
    dayViewController.view.hidden = NO;
    dayViewController.view.center = window.center;
    dayViewController.view.transform = CGAffineTransformIdentity;
    [dayViewController setChapter:chapter];
    [window addSubview:dayViewController.view];
}


-(void)createStudyViewControllerWithChapter:(NSInteger)chapter AndDay:(NSInteger)day {
    studyViewController = [[StudyPageAppViewController alloc] initWithNibName:@"StudyPageAppViewController" bundle:nil  chapter:chapter day:day];
    
    studyViewController.view.frame = CGRectMake(0, 0, 480, 320);
    studyViewController.view.hidden = NO;
    studyViewController.view.center = window.center;
    studyViewController.view.transform = CGAffineTransformIdentity;
    
    
    [window addSubview:studyViewController.view];
    
    studyViewController.view.transform=CGAffineTransformMakeScale(0.1, 0.1);
    studyViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        studyViewController.view.transform=CGAffineTransformMakeScale(1, 1); 
        studyViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        studyViewController.view.transform=CGAffineTransformIdentity;
    }];    
}

-(void)createStage1StartViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day{
    stage1StartViewController = [[Stage1StartViewController alloc] initWithNibName:@"Stage1StartViewController" bundle:nil chapter:_chapter day:_day];
    stage1StartViewController.view.frame = CGRectMake(0, 0, 480, 320);
    stage1StartViewController.view.hidden = NO;
    stage1StartViewController.view.center = window.center;
    stage1StartViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:stage1StartViewController.view];
}

-(void)createStage1ViewController:(UIViewController *)nowView Chapter:(NSInteger)_chapter AndDay:(NSInteger)_day {
    stage1ViewController = [[Stage1ViewController alloc] initWithNibName:@"Stage1ViewController" bundle:nil chapter:_chapter day:_day];
    stage1ViewController.view.frame = CGRectMake(0, 0, 480, 320);
    stage1ViewController.view.hidden = NO;
    stage1ViewController.view.center = window.center;
    stage1ViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:stage1ViewController.view];
    [stage1ViewController didMoveToParentViewController:stage1ViewController];
    
    [UIView beginAnimations:@"flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:nowView.view cache:YES];
	[nowView.view addSubview:stage1ViewController.view];
	[UIView commitAnimations];
    
    //[nowView.view removeFromSuperview];
}

-(void) createStage1ClearViewControllerWithChapter:(NSInteger)_chapter Day:(NSInteger)_day ElapsedTime:(NSString *)_elapsedTime AndWrongTrial:(NSInteger)_wrong {
    stage1ClearViewController = [[Stage1ClearViewController alloc] initWithNibName:@"Stage1ClearViewController" bundle:nil chapter:_chapter day:_day wrongTrial:_wrong elapsedTime:_elapsedTime];
    stage1ClearViewController.view.frame = CGRectMake(0, 0, 480, 320);
    stage1ClearViewController.view.hidden = NO;
    stage1ClearViewController.view.center = window.center;
    stage1ClearViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:stage1ClearViewController.view];
    
    stage1ClearViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        stage1ClearViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        stage1ClearViewController.view.transform=CGAffineTransformIdentity;
    }];   
}

-(void)createStage3StartViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day{
    stage3StartViewController = [[Stage3StartViewController alloc] initWithNibName:@"Stage3StartViewController" bundle:nil chapter:_chapter day:_day];
    stage3StartViewController.view.frame = CGRectMake(0, 0, 480, 320);
    stage3StartViewController.view.hidden = NO;
    stage3StartViewController.view.center = window.center;
    stage3StartViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:stage3StartViewController.view];
}

-(void)createStage3ViewController:(UIViewController *)nowView Chapter:(NSInteger)_chapter AndDay:(NSInteger)_day {
    stage3ViewController = [[Stage3ViewController alloc] initWithNibName:@"Stage3ViewController" bundle:nil chapter:_chapter day:_day];
    stage3ViewController.view.frame = CGRectMake(0, 0, 480, 320);
    stage3ViewController.view.hidden = NO;
    stage3ViewController.view.center = window.center;
    stage3ViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:stage3ViewController.view];
    [stage3ViewController didMoveToParentViewController:stage3ViewController];
    
    [UIView beginAnimations:@"flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:nowView.view cache:YES];
	[nowView.view addSubview:stage3ViewController.view];
	[UIView commitAnimations];
    
    //[nowView.view removeFromSuperview];
}

-(void)createDayClearViewControllerWithChapter:(NSInteger)_chapter Day:(NSInteger)_day WrongCount:(NSInteger)_wrong {
    dayClearViewController = [[DayClearViewController alloc] initWithNibName:@"DayClearViewController" bundle:nil chapter:_chapter day:_day wrongCount:_wrong];
    dayClearViewController.view.frame = CGRectMake(0, 0, 480, 320);
    dayClearViewController.view.hidden = NO;
    dayClearViewController.view.center = window.center;
    dayClearViewController.view.transform = CGAffineTransformIdentity;
    
    [window addSubview:dayClearViewController.view];
    
    dayClearViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        dayClearViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        dayClearViewController.view.transform=CGAffineTransformIdentity;
    }];   
}

-(void)createGNDPageAppViewController {
    gndPageAppViewController = [[GNDPageAppViewController alloc] initWithNibName:@"GNDPageAppViewController" bundle:nil];
    gndPageAppViewController.view.frame = CGRectMake(0, 0, 480, 320);
    gndPageAppViewController.view.hidden = NO;
    gndPageAppViewController.view.center = window.center;
    gndPageAppViewController.view.transform = CGAffineTransformIdentity;
    [window addSubview:gndPageAppViewController.view];
    
    gndPageAppViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        gndPageAppViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        gndPageAppViewController.view.transform=CGAffineTransformIdentity;
    }]; 
}

-(void)createCreditViewController {
    creditViewController = [[CreditViewController alloc] initWithNibName:@"CreditViewController" bundle:nil];
    creditViewController.view.frame = CGRectMake(0, 0, 480, 320);
    creditViewController.view.hidden = NO;
    creditViewController.view.center = window.center;
    creditViewController.view.transform = CGAffineTransformIdentity;
    [window addSubview:creditViewController.view];
    
    creditViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        creditViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        creditViewController.view.transform=CGAffineTransformIdentity;
    }]; 
}

-(void) createExplainPageViewControllerWithChapter:(NSInteger)_chapter AndDay:(NSInteger)_day AndGameStage:(NSInteger)_gameStage {
    explainPageViewController = [[ExplainPageViewController alloc] initWithNibName:@"ExplainPageViewController" bundle:nil chapter:_chapter day:_day gameStage:_gameStage];
    explainPageViewController.view.frame = CGRectMake(0, 0, 480, 320);
    explainPageViewController.view.hidden = NO;
    explainPageViewController.view.center = window.center;
    explainPageViewController.view.transform = CGAffineTransformIdentity;
    [window addSubview:explainPageViewController.view];
    
    explainPageViewController.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:(void (^)(void)) ^{ 
        explainPageViewController.view.alpha = 1;
    } completion:^(BOOL finished){
        explainPageViewController.view.transform=CGAffineTransformIdentity;
    }]; 
}

-(TutorialViewController *)createTutorialViewControllerWithViewType:(ViewType)_type {
    TutorialViewController *tutorialViewController = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController" bundle:nil];
    tutorialViewController.type = _type;
    tutorialViewController.view.frame = CGRectMake(0, 0, 480, 320);
    tutorialViewController.view.hidden = NO;
    tutorialViewController.view.center = window.center;
    tutorialViewController.view.transform = CGAffineTransformIdentity;
    
    return tutorialViewController;
}

@end
