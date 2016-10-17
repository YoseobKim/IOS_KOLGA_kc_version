//
//  HighScores.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCORE_DATA_FILE_NAME1    "HighScores1"
#define SCORE_DATA_FILE_NAME2    "HighScores2"
#define SCORE_DATA_FILE_NAME3    "HighScores3"
#define NUM_HIGH_SCORES 12

@interface HighScores : NSObject {
    NSMutableArray *scoreArr;
    NSInteger chapter;
    NSInteger day;
}

@property (nonatomic, retain) NSMutableArray *scoreArr;

+ (HighScores *)sharedHighScores;

- (void)loadHighScores:(NSInteger)_chapter;
- (void)saveHighScores:(NSInteger)_chapter;
- (BOOL)isHighScores:(NSInteger)_newScore chapter:(NSInteger)_chapter day:(NSInteger)_day;
- (NSString *)getScoreFromRecord:(NSString*)record;
- (void) saveNewRecord:(NSInteger)_newScore chapter:(NSInteger)_chapter day:(NSInteger)_day;

@end
