//
//  Settings.m
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize numOfRepeatation, vibrationOn, settingArr, tutorialOff;

static Settings *_sharedSettings = nil;

+ (Settings *) sharedSetting {
    @synchronized([Settings class]) {
        if(!_sharedSettings)
            [[self alloc] init];
        return _sharedSettings;
    }
    return nil;
}

+ (id) alloc {
	@synchronized([Settings class]) {
		_sharedSettings = [super alloc];
		return _sharedSettings;
	}
    
	return nil;
}

- (id) init {
    if( (self = [super init]) ) {
        [self loadSettings];
    }
    return self;
}


- (void)loadSettings {
    NSMutableArray *tmpArr = nil;
    NSString *filePath = _GameDataFilePath(@GAME_SETTING_FILE_NAME);
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ) {
        tmpArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        self.settingArr = tmpArr;
        [tmpArr release]; 
    }else {
        //어레이 새로 만들고 파일에 쓴다.
        tmpArr = [[NSMutableArray alloc] initWithCapacity:3];
        
        NSArray *arr = [[NSArray alloc] initWithObjects:@"1", @"YES", @"NO", nil];
        //tutorialOff = @"NO";
        
        [tmpArr addObjectsFromArray:arr];
        [arr release];
        
        self.settingArr = tmpArr;
        [tmpArr release];
        
        [self saveSettingFile];
    }
    
}

- (void)saveSettingFile {
    if(self.settingArr == nil)
        return;
    
    NSString *filePath = _GameDataFilePath(@GAME_SETTING_FILE_NAME);
    
    [self.settingArr writeToFile:filePath atomically:YES];
    
    NSLog(@"Setting data was written to %@", filePath);
}

- (void)saveSettings:(NSInteger)_numOfRepeatation vibrate:(BOOL)_vibrationOn tutorialOff:(BOOL)_tutorialOff {
    numOfRepeatation = [NSString stringWithFormat:@"%d", _numOfRepeatation];
    vibrationOn = [NSString stringWithFormat:@"%d", _vibrationOn];
    tutorialOff = [NSString stringWithFormat:@"%d", _tutorialOff];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:numOfRepeatation, vibrationOn, tutorialOff, nil];
    
    self.settingArr = [NSArray arrayWithArray:arr];
    
    NSString *filePath = _GameDataFilePath(@GAME_SETTING_FILE_NAME);
    
    [arr writeToFile:filePath atomically:YES];
    
    NSLog(@"Setting data was written to %@ NumOfRepeatation: %@, vibrationOn: %@, tutorialOff: %@", filePath, numOfRepeatation, vibrationOn, tutorialOff);
}

- (NSInteger)getNumOfRepeationValue {
    return [[settingArr objectAtIndex:0] integerValue];
}

- (BOOL)getVibrationOnValue {
    return [[settingArr objectAtIndex:1] boolValue];
}

- (BOOL)getTutorialOffValue {
    return [[settingArr objectAtIndex:2] boolValue];
}

NSString* _GameDataFilePath(NSString* fileName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

@end
