//
//  Constant.m
//  YouHuu
//
//  Created by Purnima Singh on 22/11/16.
//  Copyright © 2016 WhizKidz. All rights reserved.
//

#import "Constant.h"

@implementation Constant

NSString *YouTubeImageUrl = @"http://img.youtube.com/vi/VIDEO_ID/0.jpg";

#pragma extract youtuve video id
+(NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
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

@end
