//
//  WatchedVideosViewController.h
//  YouHuu
//
//  Created by Purnima Singh on 21/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchedVideosViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat uiWidth;
    CGFloat uiHeight;
}

@property (nonatomic, strong) NSUserDefaults *storeUserInfo;
@property (nonatomic, strong) NSMutableArray *watchedVideoArray;
@property (strong, nonatomic) IBOutlet UITableView *watchedTabelView;
@end
