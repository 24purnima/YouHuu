//
//  ViewController.h
//  YouHuu
//
//  Created by Purnima Singh on 20/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController

@property (nonatomic, strong) NSUserDefaults *storeUserInfo;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

