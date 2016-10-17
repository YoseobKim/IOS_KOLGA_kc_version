//
//  StudyPageAppViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyPageViewController.h"

@interface StudyPageAppViewController : UIViewController <UIPageViewControllerDataSource> {
    UIPageViewController *pageController;
    NSMutableArray *pageUpContent;
    NSMutableArray *pageMidContent;
    NSMutableArray *pageDownContent;
    NSInteger currentPage;
    NSInteger maxPage;
    NSInteger day;
    NSInteger chapter;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSMutableArray *pageUpContent;
@property (strong, nonatomic) NSMutableArray *pageMidContent;
@property (strong, nonatomic) NSMutableArray *pageDownContent;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger maxPage;
@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger chapter;

- (void)removeThisView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger) chapter day:(NSInteger)day;

@end
