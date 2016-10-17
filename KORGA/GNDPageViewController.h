//
//  GNDPageViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNDPageViewController : UIViewController {
    UIImageView *bgImageView;
    UIImage *bgImage;
    UILabel *pageLabel;
    NSString *pageString;
    UIButton *closeBtn;
    UIImageView *leftArrawImageView;
    UIImageView *rightArrawImageView;
    NSInteger index;
    NSInteger maxPage;
}

@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
@property (nonatomic, retain) IBOutlet UIButton *closeBtn;
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) IBOutlet UILabel *pageLabel;
@property (nonatomic, retain) NSString *pageString;
@property (nonatomic, retain) IBOutlet UIImageView *leftArrawImageView;
@property (nonatomic, retain) IBOutlet UIImageView *rightArrawImageView;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger maxPage;

- (IBAction)closeBtnClicked:(id)sender;

@end
