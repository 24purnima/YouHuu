//
//  VideoCollectionViewController.h
//  YouHuu
//
//  Created by Purnima Singh on 20/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCollectionViewController : UIViewController
{
    CGFloat uiWidth;
    CGFloat uiHeight;
    CGFloat scrollViewHeight;
    CGFloat topHeight;
}

@property (nonatomic, strong) NSString *youtubeIdentifier;
@property (assign) NSInteger numberOfThumbValue;
@property (nonatomic, strong) NSMutableArray *videoMutableArray;
@property (nonatomic, strong) NSUserDefaults *storeUserInfo;

@property (strong, nonatomic) IBOutlet UIImageView *backImage;

@property (strong, nonatomic) IBOutlet UIScrollView *imagesScrollView;

@property (strong, nonatomic) IBOutlet UIView *engineBackView;
@property (strong, nonatomic) IBOutlet UIImageView *image1;


@property (strong, nonatomic) IBOutlet UIView *boxView1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb1;
@property (strong, nonatomic) IBOutlet UIButton *playButton1;


@property (strong, nonatomic) IBOutlet UIView *boxView2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb2;
@property (strong, nonatomic) IBOutlet UIButton *playButton2;


@property (strong, nonatomic) IBOutlet UIView *boxView3;
@property (strong, nonatomic) IBOutlet UIImageView *image4;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb3;
@property (strong, nonatomic) IBOutlet UIButton *playButton3;

@property (strong, nonatomic) IBOutlet UIView *boxView4;
@property (strong, nonatomic) IBOutlet UIImageView *image5;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb4;
@property (strong, nonatomic) IBOutlet UIButton *playButton4;


@property (strong, nonatomic) IBOutlet UIView *boxView5;
@property (strong, nonatomic) IBOutlet UIImageView *image6;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb5;

@property (strong, nonatomic) IBOutlet UIButton *historyButton;

- (IBAction)playButton1Click:(id)sender;
- (IBAction)playButton2Click:(id)sender;
- (IBAction)playButton3Click:(id)sender;
- (IBAction)playButton4Click:(id)sender;
- (IBAction)historyButtonClick:(id)sender;


@end
