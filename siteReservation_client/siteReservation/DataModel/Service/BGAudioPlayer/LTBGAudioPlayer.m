//
//  LTBGAudioPlayer.m
//  LetvIphoneClient
//
//  Created by chen on 13-6-7.
//
//

#import "LTBGAudioPlayer.h"
//#import "SettingManager.h"
#import "LTDownloadCommand.h"

static BOOL s_inAirPlaying = NO;

@implementation LTBGAudioPlayer
@synthesize audioPlayer = _audioPlayer;

+ (void)setIsInAirPlaying:(BOOL)isAirPlaying
{
    s_inAirPlaying = isAirPlaying;
}

+ (BOOL)isInAirPlaying
{
    return s_inAirPlaying;
}

- (id) init
{
    if (self = [super init]) {
//#if 0
        if ([SettingManager isPassAudit]) {
            AudioSessionInitialize (NULL,NULL,NULL,NULL);
            UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
            AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,sizeof (sessionCategory),&sessionCategory);
            AudioSessionSetActive(true);
            
            NSError *setCategoryError = nil;
            [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
            if (setCategoryError)
                NSLog(@"Error setting category! %@", setCategoryError);
            
            NSString * path = [[NSBundle mainBundle] pathForResource:@"letv" ofType:@"wav"];
            NSURL* fileURL = [NSURL fileURLWithPath:[NSString safeString:path]];
            
            if (fileURL != nil) {
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];
                _audioPlayer.numberOfLoops = -1;
                _audioPlayer.currentTime = 0;
                [_audioPlayer prepareToPlay];
            }
        }
//#endif
    }
    
    return self;
}

- (void)initConfigureAVAudio
{
    AudioSessionInitialize (NULL,NULL,NULL,NULL);
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,sizeof (sessionCategory),&sessionCategory);
    AudioSessionSetActive(true);
    
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
    if (setCategoryError)
        NSLog(@"Error setting category! %@", setCategoryError);
}

- (void)startPlay
{
//#if 0
    if (self.audioPlayer &&
        [LTDownloadCommand countForStatus:[NSString stringWithFormat:@"%d",DownloadStatusDownloading]])
    {
        [_audioPlayer play];
    }
//#endif
}

- (void)stopPlay
{
//#if 0
    if (self.audioPlayer) {
        [self.audioPlayer pause];
    }
//#endif
}

@end
