//
//  Constant.h
//  YouHuu
//
//  Created by Purnima Singh on 22/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

extern NSString *YouTubeImageUrl;

+(NSString *)extractYoutubeIdFromLink:(NSString *)link;

@end
