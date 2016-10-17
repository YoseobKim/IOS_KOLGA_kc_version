//
//  TutorialViewController.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ChapterView,
    DayView,
    Stage1View,
    Stage2View,
    StudyView
} ViewType;

@interface TutorialViewController : UIViewController {
    UIButton *closeBtn;
    UIImageView *bgImageView;
    UIImage *bgImage;
    
    ViewType type;
}

@property (nonatomic, retain) IBOutlet UIButton *closeBtn;
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView; 
@property (nonatomic) ViewType type;

- (IBAction)closeBtnPressed:(id)sender;

@end
