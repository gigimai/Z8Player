//
//  MediaPlayer.m
//  Z8Player
//
//  Created by admin on 8/12/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "MediaPlayer.h"


@implementation MediaPlayer

-(id) initWithURL:(NSString *)urlLink{
    self = [super init];
    if (self)
    {
        int typeOfLink = [self checkLink:urlLink];
        switch (typeOfLink) {
            case kHTTP_LINK:
                self.managerUtility = [[HttpUtility alloc] init];
                break;
            case kRTMP_LINK:
                self.managerUtility = [[RtmpUtility alloc] init];
                break;
            default:
                NSLog(@"Link is invalid");
                break;
        }
    }
    return self;
}
-(int)checkLink:(NSString *)URLlink{
    if ( [URLlink rangeOfString:kHTTP_TYPE].location != NSNotFound)
    {
        return kHTTP_LINK;
    }
    else if ([URLlink rangeOfString:kRTMP_TYPE].location!= NSNotFound)
    {
        return kRTMP_LINK;
    }
    return kERROR_LINK;
}
@end
