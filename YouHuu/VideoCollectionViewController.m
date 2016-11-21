//
//  VideoCollectionViewController.m
//  YouHuu
//
//  Created by Purnima Singh on 20/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#define youtubeImageUrl "http://img.youtube.com/vi/VIDEO_ID/0.jpg"

#import "VideoCollectionViewController.h"
#import <AVFoundation/AVPlayerLayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIImageView+WebCache.h"
#import "XCDYouTubeClient.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "XCDYouTubeKit.h"


@interface VideoCollectionViewController ()

@end

@implementation VideoCollectionViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = true;
    
    uiWidth = self.view.frame.size.width;
    uiHeight = self.view.frame.size.height;
    topHeight = 60.0;
    scrollViewHeight = uiHeight - (topHeight * 2);
    
    
    self.backImage.frame = CGRectMake(0.0, 0.0, uiWidth, uiHeight);
    
    self.imagesScrollView.frame = CGRectMake(0.0, topHeight + 40.0, uiWidth, scrollViewHeight);
    
    
    self.engineBackView.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.boxView1.frame = CGRectMake(self.engineBackView.frame.origin.x + self.engineBackView.frame.size.width, 0.0, scrollViewHeight, scrollViewHeight);
    self.boxView2.frame = CGRectMake(self.boxView1.frame.origin.x + self.boxView1.frame.size.width, 0.0, scrollViewHeight, scrollViewHeight);
    self.boxView3.frame = CGRectMake(self.boxView2.frame.origin.x + self.boxView2.frame.size.width, 0.0, scrollViewHeight, scrollViewHeight);
    self.boxView4.frame = CGRectMake(self.boxView3.frame.origin.x + self.boxView3.frame.size.width, 0.0, scrollViewHeight, scrollViewHeight);
    self.boxView5.frame = CGRectMake(self.boxView4.frame.origin.x + self.boxView4.frame.size.width, 0.0, scrollViewHeight, scrollViewHeight);
    
    self.image1.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.image2.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.image3.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.image4.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.image5.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    self.image6.frame = CGRectMake(0.0, 0.0, scrollViewHeight, scrollViewHeight);
    
    self.videoThumb1.frame = CGRectMake(23.0, 20.0, scrollViewHeight - 67.0, scrollViewHeight - 40.0 - 70.0);
    self.videoThumb1.backgroundColor = [UIColor clearColor];
    
    self.videoThumb2.frame = CGRectMake(23.0, 20.0, scrollViewHeight - 67.0, scrollViewHeight - 40.0 - 70.0);
    self.videoThumb2.backgroundColor = [UIColor clearColor];
    
    self.videoThumb3.frame = CGRectMake(23.0, 20.0, scrollViewHeight - 67.0, scrollViewHeight - 40.0 - 70.0);
    self.videoThumb3.backgroundColor = [UIColor clearColor];
    
    self.videoThumb4.frame = CGRectMake(23.0, 20.0, scrollViewHeight - 67.0, scrollViewHeight - 40.0 - 70.0);
    self.videoThumb4.backgroundColor = [UIColor clearColor];
    
    self.historyButton.frame = CGRectMake(10.0, 10.0, 40.0, 40.0);
    
    self.playButton1.center = self.videoThumb1.center;
    self.playButton2.center = self.videoThumb2.center;
    self.playButton3.center = self.videoThumb3.center;
    self.playButton4.center = self.videoThumb4.center;
    
    
    self.image1.image = [UIImage imageNamed:@"engineImg"];
    self.image2.image = [UIImage imageNamed:@"FrontBoxImg"];
    self.image3.image = [UIImage imageNamed:@"FrontBoxImg"];
    self.image4.image = [UIImage imageNamed:@"FrontBoxImg"];
    self.image5.image = [UIImage imageNamed:@"LastBoxImage"];
    
    self.engineBackView.backgroundColor = [UIColor clearColor];
    self.boxView1.backgroundColor = [UIColor clearColor];
    self.boxView2.backgroundColor = [UIColor clearColor];
    self.boxView3.backgroundColor = [UIColor clearColor];
    self.boxView4.backgroundColor = [UIColor clearColor];
    self.boxView5.backgroundColor = [UIColor clearColor];
    
    
    self.imagesScrollView.contentSize = CGSizeMake(self.boxView4.frame.origin.x + self.boxView4.frame.size.width, scrollViewHeight);
    self.imagesScrollView.showsHorizontalScrollIndicator = false;
    
    [UIView animateWithDuration:0 animations:^{
        self.imagesScrollView.contentOffset = CGPointMake(self.engineBackView.frame.origin.x - self.imagesScrollView.frame.size.width, 0);
    }];
    
    [UIView animateWithDuration:4.0 animations:^{
        self.imagesScrollView.contentOffset = CGPointMake(self.imagesScrollView.frame.origin.x, 0);
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"myJSONParsed"];
    NSArray *myJSON = [[NSKeyedUnarchiver unarchiveObjectWithData:data2] mutableCopy];
    NSLog(@"myjson countL %lu",(unsigned long)myJSON.count);
    
    int showVideoNumber = (int)[self.storeUserInfo integerForKey:@"VideosNumber"] - 1;
    
    self.videoMutableArray = [NSMutableArray new];
    
    for (int i = showVideoNumber; i < [myJSON count]; i++) {
        
        NSDictionary *dict = [myJSON objectAtIndex:i];
    
        [self.videoMutableArray addObject:dict];
        if (self.videoMutableArray.count == 4) {
            break;
        }
        
    }
    
    for (int j = 0; j < self.videoMutableArray.count; j++) {
        
        NSDictionary *dict = [self.videoMutableArray objectAtIndex:j];
        NSString *videoUrl = [dict objectForKey:@"url"];
        
        NSString *imageStr = @youtubeImageUrl;
        imageStr = [imageStr stringByReplacingOccurrencesOfString:@"VIDEO_ID" withString:[self extractYoutubeIdFromLink:videoUrl]];
        NSURL *imgUrl = [NSURL URLWithString:imageStr];
        
//        NSLog(@"video id: %@",imageStr);
        if (j == 0) {
            [self.videoThumb1 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 1){
            [self.videoThumb2 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 2){
            [self.videoThumb3 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        else if (j == 3){
            [self.videoThumb4 sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }

    }
    
    [self.storeUserInfo setInteger:[self.storeUserInfo integerForKey:@"VideosNumber"] + self.numberOfThumbValue forKey:@"VideosNumber"];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storeUserInfo = [NSUserDefaults standardUserDefaults];
    self.numberOfThumbValue = 4;
}


- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playButton1Click:(id)sender {
    
    [self getVideosDictFromIndexValue:0];
    
}

- (IBAction)playButton2Click:(id)sender {
    
    [self getVideosDictFromIndexValue:1];

}

- (IBAction)playButton3Click:(id)sender {
    
    [self getVideosDictFromIndexValue:2];

}

- (IBAction)playButton4Click:(id)sender {
    
    [self getVideosDictFromIndexValue:3];

}

- (IBAction)historyButtonClick:(id)sender {
}

-(void)getVideosDictFromIndexValue:(int)indexValue
{
    
    NSData *watchedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"WatchedJSON"];
    
    
    NSMutableArray *watchedArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:watchedData]];
    
    NSDictionary *dict = [self.videoMutableArray objectAtIndex:indexValue];
    
    [watchedArray addObject:[self.videoMutableArray objectAtIndex:indexValue]];
    
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:watchedArray];
    [self.storeUserInfo setObject:data1 forKey:@"WatchedJSON"];
    [self.storeUserInfo synchronize];
    
    NSString *videoUrl = [dict objectForKey:@"url"];
    NSString *videoIdentifier = [self extractYoutubeIdFromLink:videoUrl];
    [self playYoutTubeVideoWithIdentifier:videoIdentifier];
}

-(void)playYoutTubeVideoWithIdentifier:(NSString*)videoIdentifier
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    [self presentViewController:playerViewController animated:true completion:nil];
    
    __weak AVPlayerViewController *weakPlayerViewController = playerViewController;
    
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
}

@end
