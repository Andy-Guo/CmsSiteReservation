//
//  LTBGAudioPlayer.h
//  LetvIphoneClient
//
//  Created by chen on 13-6-7.
//
//

#import <Foundation/Foundation.h>
#import  <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LTBGAudioPlayer : NSObject

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (void)startPlay;
- (void)stopPlay;
- (void)initConfigureAVAudio;

+ (void)setIsInAirPlaying:(BOOL)isAirPlaying;
+ (BOOL)isInAirPlaying;
@end
