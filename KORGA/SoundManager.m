//
//  SoundManager.m
//  Pigion
//
//  Created by Yoseob Kim & Jeong Nam Lee  on 12. 6. 14..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager

@synthesize soundIDDic;

//Singleton 객체
static SoundManager *_sharedSoundManager = nil;

+(SoundManager *)sharedSoundManager {
    @synchronized([SoundManager class]) {
        if(!_sharedSoundManager) [[self alloc] init];
        
        return _sharedSoundManager;
    }
    
    return nil;
}

+(id)alloc {
    @synchronized([SoundManager class]) {
        _sharedSoundManager = [super alloc];
        return _sharedSoundManager;
    }
    
    return nil;
}

-(id)init {
    if((self = [super init])) {
        //시스템 사운드를 보관할 Dictionary만들기
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithCapacity:20];
        self.soundIDDic = tmpDic;
        [tmpDic release];
    }
    
    return self;
}

-(void)playSystemSound:(NSString *)fileName fileType:(NSString *)type {
    @try {
        NSNumber *num = (NSNumber *)[self.soundIDDic objectForKey:fileName];
        SystemSoundID soundID;
        
        //받아온 소리를 저장하고 있지 않을 경우 생성해서 넣는다.
        if(num == nil) {
            NSBundle *mainBundle = [NSBundle mainBundle];
            NSString *path = [mainBundle pathForResource:fileName ofType:type];
            AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
            
            num = [[NSNumber alloc] initWithUnsignedLong:soundID];
            [self.soundIDDic setObject:num forKey:fileName];
        } else {
            soundID = [num unsignedLongValue];
        }
        
        AudioServicesPlaySystemSound(soundID);
    }@catch (NSException* e) {
        NSLog(@"Exception at SoundManager:playSystemSound: %@ for '%@'", e, type);
    }
}

-(void)dealloc {
    //파일이 있으면
    if(self.soundIDDic != nil && [self.soundIDDic count] > 0) {
        NSArray *IDs = [self.soundIDDic allValues];
        if(IDs != nil) {
            for(int i = 0; i < [IDs count]; i++) {
                NSNumber *num = (NSNumber *)[IDs objectAtIndex:i];
                if(num == nil) continue;
                
                SystemSoundID soundID = [num unsignedLongValue];
                AudioServicesDisposeSystemSoundID(soundID); //등록된 소리들을 지워준다.
            }
        }
    }
    
    [soundIDDic release];
    [super dealloc];
}

@end
