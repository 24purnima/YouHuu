//
//  PlayVideoViewController.m
//  YouHuu
//
//  Created by Purnima Singh on 22/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <AVFoundation/AVPlayerLayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "XCDYouTubeClient.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "XCDYouTubeKit.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "YTPlayerView.h"

@interface PlayVideoViewController ()

@property (nonatomic, strong) AVPlayerViewController *playerViewController;

@end

@implementation PlayVideoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
//    self.playerViewController = [[AVPlayerViewController alloc] init];
//    self.playerViewController.view.frame = self.view.bounds;
    
//    [self.view addSubview:self.playerViewController.view];
//    [self.view addSubview:self.thumbnailBackView];
    
    // Setup the Parent Child relationshipo
//    [self addChildViewController:self.playerViewController];
//    [self.playerViewController willMoveToParentViewController:self];
//    [self.playerViewController didMoveToParentViewController:self];
    
//    [self playYoutTubeVideoWithIdentifier:self.videoIdentifier];
    
}
/*
 kYTPlayerStateUnstarted,
 kYTPlayerStateEnded,
 kYTPlayerStatePlaying,
 kYTPlayerStatePaused,
 kYTPlayerStateBuffering,
 kYTPlayerStateQueued,
 kYTPlayerStateUnknown
 */
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        case kYTPlayerStateEnded:
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"End PLayback");
            break;
        case kYTPlayerStateUnstarted:
            NSLog(@"kYTPlayerStateUnstarted");
            break;
        case kYTPlayerStateBuffering:
            NSLog(@"kYTPlayerStateBuffering");
            break;
        case kYTPlayerStateQueued:
            NSLog(@"kYTPlayerStateQueued");
            break;
        case kYTPlayerStateUnknown:
            NSLog(@"kYTPlayerStateUnknown");
            break;
        default:
            NSLog(@"default");
            break;
    }
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    [self.ytPlayerView playVideo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storeUserInfo = [NSUserDefaults standardUserDefaults];
    self.view.backgroundColor = [UIColor blackColor];
    uiWidth = self.view.frame.size.width;
    uiHeight = self.view.frame.size.height;
    thumbViewHeight = 150.0;
    self.isThumbViewVisible = false;
    
    self.thumbnailBackView.frame = CGRectMake(0.0, uiHeight, uiWidth, thumbViewHeight);
    self.thumbnailBackView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
//    self.thumbnailBackView.userInteractionEnabled = false;
    
    CGFloat thumbWidth = (uiWidth - 50.0) / 4;
    
    self.thumbImage1.layer.masksToBounds = YES;
    self.thumbImage1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbImage1.layer.borderWidth = 5.0;
    self.thumbImage1.frame = CGRectMake(10.0, 20.0, thumbWidth, thumbViewHeight - 40.0);
    
    self.thumbImage2.layer.masksToBounds = YES;
    self.thumbImage2.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbImage2.layer.borderWidth = 5.0;
    self.thumbImage2.frame = CGRectMake(self.thumbImage1.frame.origin.x + self.thumbImage1.frame.size.width + 10.0, 20.0, thumbWidth, thumbViewHeight - 40.0);
    
    self.thumbImage3.layer.masksToBounds = YES;
    self.thumbImage3.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbImage3.layer.borderWidth = 5.0;
    self.thumbImage3.frame = CGRectMake(self.thumbImage2.frame.origin.x + self.thumbImage2.frame.size.width + 10.0, 20.0, thumbWidth, thumbViewHeight - 40.0);
    
    self.thumbImage4.layer.masksToBounds = YES;
    self.thumbImage4.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbImage4.layer.borderWidth = 5.0;
    self.thumbImage4.frame = CGRectMake(self.thumbImage3.frame.origin.x + self.thumbImage3.frame.size.width + 10.0, 20.0, thumbWidth, thumbViewHeight - 40.0);
    
//    NSLog(@"self.videoIdentifier: %@",self.videoIdentifier);
    
    self.thumbImage1.userInteractionEnabled = YES;
    UITapGestureRecognizer *thumbTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbOneTap)];
    thumbTap1.numberOfTapsRequired = 1;
    [self.thumbImage1 addGestureRecognizer:thumbTap1];
    
    self.thumbImage2.userInteractionEnabled = YES;
    UITapGestureRecognizer *thumbTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbTwoTap)];
    thumbTap2.numberOfTapsRequired = 1;
    [self.thumbImage2 addGestureRecognizer:thumbTap2];
    
    self.thumbImage3.userInteractionEnabled = YES;
    UITapGestureRecognizer *thumbTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbThreeTap)];
    thumbTap3.numberOfTapsRequired = 1;
    [self.thumbImage3 addGestureRecognizer:thumbTap3];
    
    self.thumbImage4.userInteractionEnabled = YES;
    UITapGestureRecognizer *thumbTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbFourTap)];
    thumbTap4.numberOfTapsRequired = 1;
    [self.thumbImage4 addGestureRecognizer:thumbTap4];
    
    
    self.ytPlayerView.frame = self.view.bounds;
    self.ytPlayerView.backgroundColor = [UIColor blackColor];

    
    NSDictionary *playerVars = @{@"playsinline" : @0,
                                 @"controls" : @2,
                                 @"autoplay" : @1,
                                 @"enablejsapi" : @1,
                                 };
    
    self.ytPlayerView.delegate = self;
    [self.ytPlayerView loadWithVideoId:self.videoIdentifier playerVars:playerVars];
    
    self.ytPlayerView.userInteractionEnabled = true;
    UITapGestureRecognizer *playerViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    playerViewTap.numberOfTapsRequired = 1;
    playerViewTap.delegate = self;
    [self.ytPlayerView addGestureRecognizer:playerViewTap];
    
}


#pragma play video with identifier method-
-(void)playYoutTubeVideoWithIdentifier:(NSString*)videoIdentifier
{
    __weak AVPlayerViewController *weakPlayerViewController = self.playerViewController;
    
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoIdentifier completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
        if(video)
        {
            NSDictionary *streamURLs = video.streamURLs;
            NSURL *streamURL = streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?: streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?: streamURLs[@(XCDYouTubeVideoQualitySmall240)];
            weakPlayerViewController.player = [AVPlayer playerWithURL:streamURL];
            [weakPlayerViewController.player play];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
    [self showNextVideosThumb];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    NSLog(@"get Touch event");
    if (!self.isThumbViewVisible) {
        self.playerViewController.showsPlaybackControls = NO;
        [self.playerViewController.player pause];
        
        self.isThumbViewVisible = true;
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             CGRect f = self.thumbnailBackView.frame;
                             f.origin.y = uiHeight - thumbViewHeight;
                             
                             self.thumbnailBackView.frame = f;
                         }
                         completion:^(BOOL finished){
                         }];
    }
    else{
        
        
        self.isThumbViewVisible = false;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             CGRect f = self.thumbnailBackView.frame;
                             f.origin.y = uiHeight;
                             
                             self.thumbnailBackView.frame = f;
                         }
                         completion:^(BOOL finished){
                             
                             self.playerViewController.showsPlaybackControls = YES;
                             [self.playerViewController.player play];
                             
                         }];
    }
}

-(void)thumbOneTap{
    [self getVideosDictFromIndexValue:0];
}

-(void)thumbTwoTap{
    [self getVideosDictFromIndexValue:1];
}

-(void)thumbThreeTap{
    [self getVideosDictFromIndexValue:2];
}

-(void)thumbFourTap{
    [self getVideosDictFromIndexValue:3];
}


#pragma get video identifier with index value
-(void)getVideosDictFromIndexValue:(int)indexValue
{
    
    NSData *watchedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"WatchedJSON"];
    
    
    NSMutableArray *watchedArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:watchedData]];
    
    NSDictionary *dict = [self.thumbMutableArray objectAtIndex:indexValue];
    
    [watchedArray addObject:[self.thumbMutableArray objectAtIndex:indexValue]];
    
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:watchedArray];
    [self.storeUserInfo setObject:data1 forKey:@"WatchedJSON"];
    [self.storeUserInfo synchronize];
    
    NSString *videoUrl = [dict objectForKey:@"url"];
    self.videoIdentifier = [Constant extractYoutubeIdFromLink:videoUrl];
    
    [self playYoutTubeVideoWithIdentifier:self.videoIdentifier];
}

-(void)showNextVideosThumb
{
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"myJSONParsed"];
    NSArray *myJSON = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
    
    
    videoIndex = [myJSON indexOfObjectPassingTest:
                  ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
                  {
                      NSString *videoUrl = [dict objectForKey:@"url"];
                      videoUrl = [Constant extractYoutubeIdFromLink:videoUrl];
                      
                      return [videoUrl isEqual:self.videoIdentifier];
                  }];
//    NSLog(@"Print index value: %lu", (unsigned long)videoIndex);
    
    self.thumbMutableArray = [NSMutableArray new];
    
    for (int i = (int)videoIndex + 1; i < [myJSON count]; i++) {
        
        NSDictionary *dict = [myJSON objectAtIndex:i];
        
        [self.thumbMutableArray addObject:dict];
        if (self.thumbMutableArray.count == 4) {
            break;
        }
        
    }
    
    for (int j = 0; j < self.thumbMutableArray.count; j++) {
        
        NSDictionary *dict = [self.thumbMutableArray objectAtIndex:j];
        NSString *videoUrl = [dict objectForKey:@"url"];
        
        NSString *imageStr = YouTubeImageUrl;
        imageStr = [imageStr stringByReplacingOccurrencesOfString:@"VIDEO_ID" withString:[Constant extractYoutubeIdFromLink:videoUrl]];
        NSURL *imgUrl = [NSURL URLWithString:imageStr];
        
        //        NSLog(@"video id: %@",imageStr);
        if (j == 0) {
            [self.thumbImage1 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 1){
            [self.thumbImage2 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 2){
            [self.thumbImage3 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 3){
            [self.thumbImage4 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"gestureRecognizer shouldReceiveTouch: tapCount = %d",(int)touch.tapCount);
    return true;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSLog(@"shouldRecognizeSimultaneouslyWithGestureRecognizer");
    return true;
}

-(void)YTPlayerViewGestureMethod:(UITapGestureRecognizer *)sender
{
    NSLog(@"YTPLAYER TAP");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
