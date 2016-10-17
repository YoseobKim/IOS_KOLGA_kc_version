//
//  Settings.h
//  KORGA
//
//  Created by 요섭 김 on 12. 8. 20..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GAME_SETTING_FILE_NAME    "GameSetting"

@interface Settings : NSObject {
    NSString *numOfRepeatation;
    NSString *vibrationOn;
    NSString *tutorialOff;
    NSArray *settingArr;
}

@property (nonatomic, retain) NSString *numOfRepeatation;
@property (nonatomic, retain) NSString *vibrationOn;
@property (nonatomic, retain) NSArray *settingArr;
@property (nonatomic, retain) NSString *tutorialOff;

+ (Settings *)sharedSetting;

- (void)loadSettings;
- (void)saveSettingFile;
- (void)saveSettings:(NSInteger)_numOfRepeatation vibrate:(BOOL)_vibrationOn tutorialOff:(BOOL)_tutorialOff;
- (NSInteger)getNumOfRepeationValue;
- (BOOL)getVibrationOnValue;
- (BOOL)getTutorialOffValue;

@end
