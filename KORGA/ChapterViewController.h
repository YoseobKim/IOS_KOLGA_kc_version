//
//  ChapterViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 6..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NUM_OF_CHAPTER_PAGES 3

@interface ChapterViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    UIImageView *bgView;
    UIImageView *leftArrowImageView;
    UIImageView *rightArrowImageView;
    UIButton *optionBtn;
    NSArray *ch1Progress;
    NSArray *ch2Progress;
    CGFloat ch1Percent;
    CGFloat ch2Percent;
}

@property(nonatomic, retain) IBOutlet UIImageView *bgView;
@property(nonatomic, retain) IBOutlet UIImageView *leftArrowImageView;
@property(nonatomic, retain) IBOutlet UIImageView *rightArrowImageView;
@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property(nonatomic, retain) IBOutlet UIButton *optionBtn;


-(UIImage *)addPie:(UIImage *)img radius:(CGFloat)radius xPosition:(CGFloat)xPos yPosiyion:(CGFloat)yPos progress_in_percent:(CGFloat)percent;
-(IBAction)optionBtnPressed:(id)sender;

@end
