//
//  ViewController.m
//  YouHuu
//
//  Created by Purnima Singh on 20/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import "ParentViewController.h"
#import "VideoCollectionViewController.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

-(void)viewDidAppear:(BOOL)animated{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = true;
    
    self.storeUserInfo = [NSUserDefaults standardUserDefaults];
    
    self.activityIndicator.center = self.view.center;
    
    [self fetchTrainData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)fetchTrainData{
    
    self.activityIndicator.hidden = NO;
    
    [self performSegueWithIdentifier:@"videoCollection" sender:self];
    
    
    [self.storeUserInfo setInteger:1 forKey:@"VideosNumber"];
    
//    NSString *urlString = @"http://54.179.149.254/api/v1/content/listing/41/?format=json";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               
//                               self.activityIndicator.hidden = YES;
//                               
//                               if (!error) {
//                                   NSError* parseError;
//                                   id parse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
//                                                                      NSLog(@"data: %@", parse);
//                                   
//                                   NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:parse];
//                                   [self.storeUserInfo setObject:data1 forKey:@"myJSONParsed"];
//                                   [self.storeUserInfo synchronize];
//                                   
//                                   [self performSegueWithIdentifier:@"videoCollection" sender:self];
//                                   
//                                   
//                                   [self.storeUserInfo setInteger:1 forKey:@"VideosNumber"];
//                                   
//                               }
//                               else{
//                                   
//                                   NSString *alertTitle = @"Error";
//                                   NSString *alertMessage = @"Something went wrong please try again";
//                                   
//                                   
//                                   UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
//                                   
//                                   [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//                                       
//                                       // Cancel button tappped.
//                                       [self dismissViewControllerAnimated:YES completion:^{
//                                           
//                                           [self fetchTrainData];
//                                           
//                                       }];
//                                   }]];
//                                   
//                                   // Present action sheet.
//                                   [self presentViewController:actionSheet animated:YES completion:nil];
//                                   
//                               }
//                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"videoCollection"])
    {
        
    }
}


-(BOOL)shouldAutorotate {
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
