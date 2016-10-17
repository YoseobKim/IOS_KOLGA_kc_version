//
//  StudyPageAppViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "StudyPageAppViewController.h"
#import "SoundManager.h"

@interface StudyPageAppViewController ()

@end

@implementation StudyPageAppViewController
@synthesize pageController;
@synthesize currentPage, maxPage, day, chapter;
@synthesize pageUpContent, pageMidContent, pageDownContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day {
    self.chapter = _chapter;
    self.day = _day;
    self = [self initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"study%d_%d.plist", chapter + 1, day + 1]];
        NSMutableDictionary *studyPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
        pageUpContent = (NSMutableArray *)[studyPlist objectForKey:@"Kor"];
        pageMidContent = (NSMutableArray *)[studyPlist objectForKey:@"Eng"];
        pageDownContent = (NSMutableArray *)[studyPlist objectForKey:@"Desc"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentPage = 0;
    self.maxPage = [self.pageUpContent count];
    
    NSDictionary *options = [NSDictionary dictionaryWithObject: [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    self.pageController.dataSource = self;
    self.pageController.view.frame = self.view.bounds;
    
    StudyPageViewController *initialViewController = [self viewControllerAtIndex:self.currentPage];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [[self view] addSubview: pageController.view];
    //[pageController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = self.pageController.gestureRecognizers;
    
    // Find the tap gesture recognizer so we can remove it!
    UIGestureRecognizer* tapRecognizer = nil;    
    for (UIGestureRecognizer* recognizer in self.pageController.gestureRecognizers) {
        if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
            tapRecognizer = recognizer;
            break;
        }
    }
    
    if ( tapRecognizer ) {
        [self.view removeGestureRecognizer:tapRecognizer];
        [self.pageController.view removeGestureRecognizer:tapRecognizer];
    }
}

- (StudyPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    if(self.maxPage == 0 || (index > maxPage)) {
        return nil;
    }
    
    StudyPageViewController* contentViewController = [[StudyPageViewController alloc] initWithNibName:@"StudyPageViewController" bundle:nil];
    contentViewController._mPageString = [NSString stringWithFormat:@"%d/%d", index, maxPage - 1];
    contentViewController.page = index;
    contentViewController.maxPage = maxPage - 1;
    contentViewController.day = day;
    if(index < maxPage) {
        contentViewController._mDayString = [NSString stringWithFormat:@"Day %d", day + 1];
        contentViewController._mUpContentString = [self.pageUpContent objectAtIndex:index];
        contentViewController._mMidContentString = [self.pageMidContent objectAtIndex:index];
        NSString *downString = [[self.pageDownContent objectAtIndex:index] stringByReplacingOccurrencesOfString:@"@" withString:@"\n"];
        contentViewController._mDownContentString = downString;
    }
    contentViewController.chapter = chapter;
    contentViewController.parent = self;
    contentViewController.filePath = [NSString stringWithFormat:@"%d_%d_%d", chapter + 1, day + 1, index];
    
    [[SoundManager sharedSoundManager] playSystemSound:@"page" fileType:@"wav"];
    
    return contentViewController;
}

/* UIPageViewController Delegate 함수들. */
- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerBeforeViewController: (UIViewController *)viewController {
    if (self.currentPage == 0) {
        return nil;
    }
    self.currentPage--;
    return [self viewControllerAtIndex:self.currentPage];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.currentPage >= self.maxPage) {
        return nil;
    }
    self.currentPage++;
    return [self viewControllerAtIndex:self.currentPage];
}

- (void)removeThisView {
    [self.view removeFromSuperview];
    [self release];
    self = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
