//
//  SoundManager.h
//  Pigion
//
//  Created by Yoseob Kim & Jeong Nam Lee  on 12. 6. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SoundManager : NSObject {
    NSMutableDictionary *soundIDDic; //soundID를 저장할 dictionary생성
}
@property (nonatomic, retain) NSMutableDictionary *soundIDDic;

+(SoundManager *)sharedSoundManager; //Singleton Design Pattern으로 제작
-(void)playSystemSound:(NSString *)fileName fileType:(NSString *)type;

@end
