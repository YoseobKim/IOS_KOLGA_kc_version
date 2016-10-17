//
//  GNDPageAppViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNDPageAppViewController : UIViewController <UIPageViewControllerDataSource> {
    UIPageViewController *pageViewController;
    NSInteger curPage;
    NSInteger maxPage;
}

@property (nonatomic, retain) UIPageViewController *pageViewController;
@property (nonatomic) NSInteger curPage;
@property (nonatomic) NSInteger maxPage;

- (void)removeThisView;

@end
