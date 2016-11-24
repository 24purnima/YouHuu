//
//  WatchedVideosViewController.m
//  YouHuu
//
//  Created by Purnima Singh on 21/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//



#import "WatchedVideosViewController.h"
#import "WatchedVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"

@interface WatchedVideosViewController ()

@end

@implementation WatchedVideosViewController

static NSString * const tableViewCellIdentifier = @"watchedVideos";

-(void)viewDidAppear:(BOOL)animated{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Watched Videos";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = false;
    
    uiWidth = self.view.frame.size.width;
    uiHeight = self.view.frame.size.height;
    self.watchedTabelView.frame = CGRectMake(0.0, 0.0, uiWidth, uiHeight);
    self.watchedTabelView.dataSource = self;
    self.watchedTabelView.delegate = self;
    
    self.storeUserInfo = [NSUserDefaults standardUserDefaults];
    
    NSData *watchedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"WatchedJSON"];
    
    
    self.watchedVideoArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:watchedData]];
    
    if(self.watchedVideoArray.count == 0){
        self.watchedTabelView.hidden = YES;
    }
    else{
        self.watchedTabelView.hidden = NO;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.watchedVideoArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WatchedVideoTableViewCell *cell = (WatchedVideoTableViewCell *)[self.watchedTabelView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[WatchedVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellIdentifier];
        
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict = [self.watchedVideoArray objectAtIndex:indexPath.row];
    NSString *videoUrl = [dict objectForKey:@"url"];
    NSString *videoIdentifier = [Constant extractYoutubeIdFromLink:videoUrl];
    NSString *imageStr = YouTubeImageUrl;
    imageStr = [imageStr stringByReplacingOccurrencesOfString:@"VIDEO_ID" withString:videoIdentifier];
    NSURL *imgUrl = [NSURL URLWithString:imageStr];
    
    [cell.thumbImage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];

    cell.thumbImage.frame = CGRectMake(15.0, 10.0, 60.0, 60.0);
    cell.titleLabel.frame = CGRectMake(cell.thumbImage.frame.origin.x + cell.thumbImage.frame.size.width + 10.0, 10.0, uiWidth - (cell.thumbImage.frame.origin.x + cell.thumbImage.frame.size.width + 10.0) - 15.0, 60.0);
    cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    cell.titleLabel.text = [dict objectForKey:@"title"];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
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
