//
//  HorizontalScrollMenuView.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "HorizontalScrollMenuView.h"
#import "SoundManager.h"


@implementation HorizontalScrollMenuView

@synthesize menuScrollView, rightMenuImage, leftMenuImage, menuButtons, curPage;


- (void)dealloc {
	[menuButtons release];
	[leftMenuImage release];
	[rightMenuImage release];
	[menuScrollView release];
    [super dealloc];
}


- (id)initWithFrameColorAndButtons:(CGRect)frame backgroundColor:(UIColor*)bgColor buttons:(NSMutableArray*)buttonArray {
	
	if (self = [super initWithFrame:frame]) {
		
		// 현재 크기와 동일한 스크롤 뷰 초기화.
		menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
		
		// 스크롤뷰 설정.
		menuScrollView.backgroundColor = bgColor;
		menuScrollView.showsHorizontalScrollIndicator = FALSE;
		menuScrollView.showsVerticalScrollIndicator = FALSE;
		menuScrollView.scrollEnabled = YES;
		menuScrollView.bounces = NO;
        menuScrollView.pagingEnabled = YES;
		
		// 델리케이트 설정.
		menuScrollView.delegate = self;
		
		// 스클롤뷰에 추가할 버튼들.
		menuButtons = buttonArray;
		
		float totalButtonWidth = 0.0f;
		
		for (int i = 0; i < [menuButtons count]; i++) {
			
			UIButton *btn = [menuButtons objectAtIndex:i];
			
			// 버튼 위치 이동(가로로 x).
			CGRect btnRect = btn.frame;
			btnRect.origin.x = totalButtonWidth;
			[btn setFrame:btnRect];

			// 스크롤뷰에 버튼 추가.
			[menuScrollView addSubview:btn];
			
			// 버튼들 전체의 넓이.
			totalButtonWidth += btn.frame.size.width;
		}
		
		// 스크롤뷰의 content rect 업데이트.
		[menuScrollView setContentSize:CGSizeMake(totalButtonWidth, self.frame.size.height)];
		
		[self addSubview:menuScrollView];
		
	}
	return self;
}


#pragma mark -
#pragma mark 스크롤뷰 델리게이트 메소드.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[SoundManager sharedSoundManager] playSystemSound:@"dial" fileType:@"wav"];
    CGFloat pageWidth = scrollView.frame.size.width;  
    curPage = floor((scrollView.contentOffset.x - pageWidth / [menuButtons count]) / pageWidth) + 1; 
    //NSLog(@"curPage: %d", curPage);
    // (padding)옵셋이 3보다 적을 때... 
	// 실전에서 좌우에 스크롤이 가능하다는 화살표(leftMenuImage/rightOffset)를 보여주는 용도로 사용함.
	if(scrollView.contentOffset.x <= 3) {
		NSLog(@"Scroll is as far left as possible");
	}
	else if(scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width) - 3) {
		NSLog(@"Scroll is as far right as possible");
	}
	else {
		// 스크롤이 왼쪼과 오른쪽 사이에 있을 경우. 좌우 모두 스크롤 가능함.
	}
}


@end
