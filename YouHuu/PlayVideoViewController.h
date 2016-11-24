//
//  PlayVideoViewController.h
//  YouHuu
//
//  Created by Purnima Singh on 22/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface PlayVideoViewController : UIViewController <YTPlayerViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat uiWidth;
    CGFloat uiHeight;
    CGFloat thumbViewHeight;
    NSUInteger videoIndex;
}

@property (assign) BOOL isThumbViewVisible;
@property (nonatomic, strong) NSUserDefaults *storeUserInfo;
@property (nonatomic, strong) NSString *videoIdentifier;
@property (nonatomic, strong) NSMutableArray *thumbMutableArray;

@property (strong, nonatomic) IBOutlet UIView *thumbnailBackView;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage1;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage2;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage3;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage4;

@property (strong, nonatomic) IBOutlet YTPlayerView *ytPlayerView;
@end
