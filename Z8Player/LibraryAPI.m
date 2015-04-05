//
//  LibraryAPI.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/6/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "LibraryAPI.h"
#import "ChannelModel.h"
#import "FilmModel.h"
#define fullURL (@"http://10.88.106.248/")

@implementation LibraryAPI
NSMutableArray *homeChannels;
NSMutableArray *homeFilms;

@synthesize filmEditedArr;
@synthesize channelEditedArr;
@synthesize favouriteChannelArr;
@synthesize favouriteFilmArr;
+ (LibraryAPI *)sharedInstance
{
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t onePredicate;
    dispatch_once(&onePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc]init];
    });
    return _sharedInstance;
}

//Get Channel Data
- (NSArray*) getChannelList
{
    return homeChannels;
}

//Get Film Data
- (NSArray*) getFilmList
{
    return homeFilms;
}

///////////////////////////////////////////////////////////////////////////////////

- (id)init
{
    self = [super init];
    if (self) {
        [self initDemoData];
    }
    //[self saveFilmsArray];
    //[self saveChannelArray];
    return self;
}

- (NSArray*) getDataFromURL:(NSString *)url withKey:(NSString *)key
{
    NSError *error;
    NSDictionary *returnData;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", fullURL, url]] options:NSDataReadingUncached error:&error];
    if(error == nil)
    {
        returnData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return [returnData objectForKey:key];
    }
    NSLog(@"ERROR 101: Cannot get data");
    return nil;
}
- (void) initDemoData
{
    filmEditedArr = [[NSMutableArray alloc]init];
    channelEditedArr = [[NSMutableArray alloc]init];
    homeChannels = [[NSMutableArray alloc] init];

    NSArray *ChannelData = [self getDataFromURL:@"getChannels" withKey:@"ChannelData"];
    if(ChannelData != nil)
    {
        for (int i = 0; i<[ChannelData count]; i++) {
            ChannelModel *_channel =[[ChannelModel alloc] init];
            _channel.channelID = i + 1;
            _channel.mediaName = [ChannelData[i] objectForKey:@"mediaName"];
            _channel.mediaURL = [NSURL URLWithString:[ChannelData[i] objectForKey:@"mediaURL"]];
            _channel.mediaThumbnailImage = [ChannelData[i] objectForKey:@"mediaThumbnailImage"];
            _channel.channelCountry = [ChannelData[i] objectForKey:@"channelCountry"];
            [ChannelModel saveChannel:_channel];
            [homeChannels addObject:_channel];
            [channelEditedArr addObject:_channel];
        }
    }

    homeFilms = [[NSMutableArray alloc] init];
    NSArray *filmData  =[self getDataFromURL:@"getFilms" withKey:@"FilmData"];
    if(filmData != nil)
    {
        for (int i = 0; i<[filmData count]; i++) {
            FilmModel *_film =[[FilmModel alloc] init];
            _film.filmID = i + 1;
            _film.mediaName = [filmData[i] objectForKey:@"mediaName"];
            _film.mediaThumbnailImage = [filmData[i] objectForKey:@"mediaThumbnailImage"];
            _film.filmDescription = [filmData[i] objectForKey:@"filmDescription"];
            _film.mediaURL = [NSURL URLWithString:[filmData[i] objectForKey:@"mediaURL"]];
            [FilmModel saveChannel:_film];
            [homeFilms addObject:_film];
            [filmEditedArr addObject:_film];
        }
    }
}


// filmArr channelArr
- (NSString *)getPathToArchive:(NSString *)keyObject
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                         NSUserDomainMask, YES);
    NSString *docSir = paths[0];
    return [docSir stringByAppendingPathComponent:keyObject];
}

- (NSArray *)getFilmListEdited
{
    //[NSKeyedArchiver archiveRootObject:self.filmEditedArr toFile:[self getPathToArchive:kFilmEditedArr]];
     return self.filmEditedArr;
    
}



- (NSMutableArray *)getFilmArray
{
    NSMutableArray *films;
    if (!films) {
        //films = [[NSMutableArray alloc]init];
        NSLog(@"films list are nil");
    }
    NSString *archiveFilePath = [self getPathToArchive:kFilmEditedArr];
    
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:archiveFilePath];
    if (codedData == nil)
        return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    films = [unarchiver decodeObjectForKey:kFilmEditedArr];
    [unarchiver finishDecoding];
    return films;
}


- (void)saveFilmsArray
{
    if (!self.filmEditedArr) {
        return;
    }
    NSString *archiveFilePath = [self getPathToArchive:kFilmEditedArr];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:archiveFilePath]){
    }
    NSMutableData *data = [[NSMutableData alloc]init];
    //NSMutableArray *array = [NSMutableArray arrayWithObject:@"ABC"];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.filmEditedArr forKey:kFilmEditedArr];
    [archiver finishEncoding];
    [data writeToFile:archiveFilePath atomically:YES];
    //NSMutableArray *array = [NSMutableArray arrayWithObject:@"ABC"];
    //[self.filmEditedArr writeToFile:[NSString stringWithFormat:@"%@",archiveFilePath] atomically:YES];
}


- (NSMutableArray *)getChannelArray
{
    NSMutableArray *channels;
    if (!channels) {
        //channels = [[NSMutableArray alloc]init];
        NSLog(@"Channels value is nil");
    }
    NSString *archiveFilePath = [self getPathToArchive:kChannelEditedArr];
    
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:archiveFilePath];
    if (codedData == nil)
        return nil;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    channels = [unarchiver decodeObjectForKey:kFilmEditedArr];
    [unarchiver finishDecoding];
    return channels;
}

- (void)saveChannelArray
{
    if (!self.channelEditedArr) {
        return;
    }
    NSString *archiveFilePath = [self getPathToArchive:kChannelEditedArr];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:archiveFilePath]){
    }
    NSMutableData *data = [[NSMutableData alloc]init];
    //NSMutableArray *array = [NSMutableArray arrayWithObject:@"ABC"];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.filmEditedArr forKey:kFilmEditedArr];
    [archiver finishEncoding];
    [data writeToFile:archiveFilePath atomically:YES];
    //NSMutableArray *array = [NSMutableArray arrayWithObject:@"ABC"];
    //[self.filmEditedArr writeToFile:[NSString stringWithFormat:@"%@",archiveFilePath] atomically:YES];
}

-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

-(NSMutableArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyName];
    NSMutableArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}
//
//- (NSMutableArray *)favouriteChannelArr
//{
//    return [self readArrayWithCustomObjFromUserDefaults:kFavouriteChannel];
//}

//- (void)setFavouriteChannelArr:(NSMutableArray *)favouriteChannelArr
//{
//    [self writeArrayWithCustomObjToUserDefaults:kFavouriteChannel withArray:favouriteFilmArr];
//}

//- (NSMutableArray *)favouriteFilmArr
//{
//    return [self readArrayWithCustomObjFromUserDefaults:kFavouriteFilm];
//}

//- (void)setFavouriteFilmArr:(NSMutableArray *)favouriteFilmArr
//{
//    
//}

@end
