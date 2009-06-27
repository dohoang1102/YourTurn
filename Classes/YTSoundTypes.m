//
//  YTSoundTypes.m
//  YourTurn
//
//  Created by Masashi Ono on 09/06/28.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "YTSoundTypes.h"
#import "YTSound.h"


static YTSoundTypes *_instance;

@implementation YTSoundTypes

#pragma mark properties

- (NSArray *)soundIds
{
    return [sounds keysSortedByValueUsingSelector:@selector(compare:)];
}
- (NSUInteger)count
{
    return [sounds count];
}

#pragma mark Instanciation, deallocation

+ (YTSoundTypes *)instance
{
    if (!_instance)
    {
        return [YTSoundTypes newInstance];
    }
    return _instance;
}

+ (YTSoundTypes *)newInstance
{
    if (_instance)
    {
        [_instance release];
        _instance = nil;
    }
    
    _instance = [[YTSoundTypes alloc] init];
    _instance->sounds = [[NSMutableDictionary dictionary] retain];
    return _instance;
}

- (void)dealloc
{
    [sounds release];
    [super dealloc];
}

#pragma mark add, remove, get sounds

- (YTSound *)soundForIndex:(NSUInteger)index
{
    NSString *soundId = [self.soundIds objectAtIndex:index];
    return (YTSound *)[self soundForId:soundId];
}

- (YTSound *)soundForId:(NSString *)fileId
{
    return (YTSound *)[sounds objectForKey:fileId];
}

- (void)load
{
    YTSound *sound = nil;
    //bell.aif
    sound = [[[YTSound alloc] initWithId:@"Bell"
                                fileName:@"bell"
                           fileExtension:@"aif"] autorelease];
    [sounds setObject:sound forKey:sound.fileId];
//    //gong.aif
//    sound = [[[YTSound alloc] initWithId:@"Gong"
//                                fileName:@"gong"
//                           fileExtension:@"aif"] autorelease];
//    [sounds setObject:sound forKey:sound.fileId];
//    //MyTurn.wav
//    sound = [[[YTSound alloc] initWithId:@"\"My Turn!\""
//                                fileName:@"MyTurn"
//                           fileExtension:@"wav"] autorelease];
//    [sounds setObject:sound forKey:sound.fileId];
}

@end
