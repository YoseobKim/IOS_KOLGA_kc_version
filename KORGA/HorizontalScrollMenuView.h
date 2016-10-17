//
//  HorizontalScrollMenuView.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HorizontalScrollMenuView : UIView <UIScrollViewDelegate> {
	UIScrollView *scrollMenuView;
	UIImageView *leftMenuImage;
	UIImageView *rightMenuImage;
	NSMutableArray *menuButtons;
    NSInteger curPage;
}

@property (nonatomic, retain) UIScrollView* menuScrollView;
@property (nonatomic, retain) UIImageView* leftMenuImage;
@property (nonatomic, retain) UIImageView* rightMenuImage;
@property (nonatomic, retain) NSMutableArray* menuButtons;
@property (nonatomic) NSInteger curPage;

- (id)initWithFrameColorAndButtons:(CGRect)frame backgroundColor:(UIColor*)bgColor buttons:(NSMutableArray*)buttonArray;

@end
