//
//  ExplainPageViewController.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 22..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ExplainPageViewController.h"

@interface ExplainPageViewController ()

@end

@implementation ExplainPageViewController

@synthesize engLabel, korLabel, btnExit, descLabel, day, chapter, gameStage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chapter:(NSInteger)_chapter day:(NSInteger)_day gameStage:(NSInteger)_gameStage
{
    chapter = _chapter;
    day = _day;
    gameStage = _gameStage;
    
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath;
        if(gameStage == 1) {
            finalPath = [path stringByAppendingPathComponent:@"game1data.plist"];
        } else if (gameStage == 3) {
            finalPath = [path stringByAppendingPathComponent:@"game3data.plist"];
        }
        NSMutableDictionary *studyPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
        korString = (NSArray *)[studyPlist objectForKey:@"Kor"];
        engString = (NSArray *)[studyPlist objectForKey:@"Eng"];
        descString = (NSArray *)[studyPlist objectForKey:@"Desc"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    korLabel.text = [korString objectAtIndex:day + 12 * chapter];
    engLabel.text = [engString objectAtIndex:day + 12 * chapter];
    descLabel.text = [descString objectAtIndex:day + 12 * chapter];
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

- (IBAction)exitBtnPressed:(id)sender {
    [self.view removeFromSuperview];
}

@end
