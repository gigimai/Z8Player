//
//  MediaModel.h
//  Z8Player
//
//  Created by Do Nhat Khanh on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaModel : NSObject<NSCoding>
@property (strong, nonatomic) NSString *mediaThumbnailImage;
@property (strong, nonatomic) NSString *mediaName;
@property (strong, nonatomic) NSString *mediaURL;
@property (strong, nonatomic) NSString *mediaCategory;
@end
