//
//  HighScores.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "HighScores.h"

@implementation HighScores

@synthesize scoreArr;

static HighScores *_sharedHighScores = nil;

+ (HighScores *) sharedHighScores {
    @synchronized([HighScores class]) {
        if(!_sharedHighScores)
            [[self alloc] init];
        return _sharedHighScores;
    }
    return nil;
}

+ (id) alloc {
	@synchronized([HighScores class]) {
		_sharedHighScores = [super alloc];
		return _sharedHighScores;
	}
    
	return nil;
}

- (id) init {
    if( (self = [super init]) ) {
        //[self loadHighScores];
    }
    return self;
}

-(void)loadHighScores:(NSInteger)_chapter {
    NSMutableArray *tmpArr = nil;
    chapter = _chapter;
    NSString *filePath;
    //파일 읽어오기
    if(chapter == 0) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME1);
    } else if(chapter == 1) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME2);
    } else if(chapter == 2) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME3);
    }
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ) {
        tmpArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        self.scoreArr = tmpArr;
        [tmpArr release]; 
    }else {
        //어레이 새로 만들고 파일에 쓴다.
        tmpArr = [[NSMutableArray alloc] initWithCapacity:NUM_HIGH_SCORES];
        
        NSArray *arr;
        if(chapter == 0) {
            arr = [[NSMutableArray alloc] initWithObjects:@"1_1:0", @"1_2:0", @"1_3:0", @"1_4:0", @"1_5:0", @"1_6:0", @"1_7:0", @"1_8:0", @"1_9:0", @"1_10:0", @"1_11:0", @"1_12:0",nil];
        } else if(chapter == 1) {
            arr = [[NSMutableArray alloc] initWithObjects:@"2_1:0", @"2_2:0", @"2_3:0", @"2_4:0", @"2_5:0", @"2_6:0", @"2_7:0", @"2_8:0", @"2_9:0", @"2_10:0", @"2_11:0", @"2_12:0",nil];
        } else if(chapter == 2) {
            arr = [[NSMutableArray alloc] initWithObjects:@"3_1:0", @"3_2:0", @"3_3:0", @"3_4:0", @"3_5:0", @"3_6:0", @"3_7:0", @"3_8:0", @"3_9:0", @"3_10:0", @"3_11:0", @"3_12:0",nil];
        }
        
        [tmpArr addObjectsFromArray:arr];
        [arr release];
        
        self.scoreArr = tmpArr;
        [tmpArr release];
        
        [self saveHighScores:chapter];
    }

}

-(void)saveHighScores:(NSInteger)_chapter {
    if(self.scoreArr == nil)
        return;
    
    NSString *filePath;
    
    if(_chapter == 0) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME1);
    } else if(_chapter == 1) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME2);
    } else if(_chapter == 2) {
        filePath = GameDataFilePath(@SCORE_DATA_FILE_NAME3); 
    }
    
    [self.scoreArr writeToFile:filePath atomically:YES];
    NSLog(@"High score data was written to %@", filePath);
}

-(BOOL)isHighScores:(NSInteger)_newScore chapter:(NSInteger)_chapter day:(NSInteger)_day {
    NSInteger score = 0;
    if(self.scoreArr == nil || [self.scoreArr count] < 1)
        [self loadHighScores:chapter];
    
    // HighScore에서 day에 해당하는 점수 가져오기
    NSString *scoreRecord = (NSString *) [self.scoreArr objectAtIndex:_day];
    NSString *scoreStr = [self getScoreFromRecord:scoreRecord];
    
    if(scoreStr != nil)
        score = [scoreStr integerValue];
    
    // 받은 점수가 기존의 점수보다 높으면 HighScore임.
    if(_newScore > score)
        return YES;
    
    return NO;
}

// HighScore 파일에 이름 저장
- (void) saveNewRecord:(NSInteger)_newScore chapter:(NSInteger)_chapter day:(NSInteger)_day {
    if([self isHighScores:_newScore chapter:_chapter day:_day] == NO) //받은 점수가 HighScore아니면 함수 실행 안함
        return;
    else {
        NSString *newRecord = [[NSString alloc] initWithFormat:@"%d_%d:%d", _chapter, _day, _newScore];
        [self.scoreArr replaceObjectAtIndex:_day withObject:newRecord]; //i위치에 쓰기
    }
    
    [self saveHighScores:_chapter];
}

//HighScore파일은 이름:점수 구조로 이루어져 있는데 이 중 점수만 파싱한다.
- (NSString *) getScoreFromRecord:(NSString*)record {
    if(record == nil)
        return 0;
    
    NSRange nameRange = [record rangeOfString:@":"];
    if(nameRange.location != NSNotFound)
        return [record substringFromIndex:nameRange.location + 1]; //이름:점수 이므로
    else
        return nil;
}

NSString* GameDataFilePath(NSString* fileName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}
        
@end
