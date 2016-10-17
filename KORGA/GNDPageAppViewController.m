//
//  GNDPageAppViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "GNDPageAppViewController.h"
#import "GNDPageViewController.h"
#import "SoundManager.h"

@interface GNDPageAppViewController ()

@end

@implementation GNDPageAppViewController

@synthesize pageViewController, curPage, maxPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.curPage = 0;
    self.maxPage = 12;
    
    // Page Option 설정.
    NSDictionary *options = [NSDictionary dictionaryWithObject: [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    // Page View Controller 생성.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = self.view.bounds;
    
    
    GNDPageViewController *initialViewController = [self viewControllerAtIndex:self.curPage];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    // Find the tap gesture recognizer so we can remove it!
    UIGestureRecognizer* tapRecognizer = nil;    
    for (UIGestureRecognizer* recognizer in self.pageViewController.gestureRecognizers) {
        if ( [recognizer isKindOfClass:[UITapGestureRecognizer class]] ) {
            tapRecognizer = recognizer;
            break;
        }
    }
    
    if ( tapRecognizer ) {
        [self.view removeGestureRecognizer:tapRecognizer];
        [self.pageViewController.view removeGestureRecognizer:tapRecognizer];
    }
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

- (GNDPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    GNDPageViewController* gndPageViewController = [[GNDPageViewController alloc] initWithNibName:@"GNDPageViewController" bundle:nil];
    
    gndPageViewController.pageString =[NSString stringWithFormat:@"%d / %d", index + 1, self.maxPage];
    UIImage *_bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"alphabet%d",index + 1]];
    gndPageViewController.index = index;
    gndPageViewController.maxPage = maxPage;
    
    gndPageViewController.bgImage = _bgImage;
    if(index != 0) {
        [[SoundManager sharedSoundManager] playSystemSound:@"page" fileType:@"wav"];
    }
    return gndPageViewController;
}

// UIPageViewController Delegate 함수들.
- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerBeforeViewController: (UIViewController *)viewController {
    if (self.curPage == 0) {
        return nil;
    }
    self.curPage--;
    return [self viewControllerAtIndex:self.curPage];
}

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerAfterViewController: (UIViewController *)viewController {
    if (self.curPage >= self.maxPage - 1) {
        return nil;
    }
    self.curPage++;
    return [self viewControllerAtIndex:self.curPage];
}

- (void)removeThisView {
    [self.view removeFromSuperview];
    [self release];
    self = nil;
}

@end
