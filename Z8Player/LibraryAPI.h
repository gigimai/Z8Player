//
//  LibraryAPI.h
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/6/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryAPI : NSObject

@property(nonatomic, strong) NSMutableArray *filmEditedArr;
@property(nonatomic, strong) NSMutableArray *channelEditedArr;

@property (nonatomic, strong) NSMutableArray *favouriteFilmArr;
@property (nonatomic, strong) NSMutableArray *favouriteChannelArr;

- (void)initDemoData;

+ (LibraryAPI *)sharedInstance;
//+ (NSString *)getPathToArchive:(NSString *)keyObject;

- (NSArray*) getChannelList;
- (NSArray*) getFilmList;

- (NSMutableArray *)getFilmArray;
- (void)saveFilmsArray;
- (NSMutableArray *)getChannelArray;
- (void)saveChannelArray;

-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray;
-(NSMutableArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName;

@end