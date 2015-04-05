//
//  ZPMoviesViewController.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/19/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ZPMoviesViewController.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "ZPDetailViewController.h"
#import "LibraryAPI.h"
#import "FilmModel.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"

@interface ZPMoviesViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}

@property (nonatomic,strong) UICollectionView *movieCollection;
@property (nonatomic,strong) NSMutableArray *moviesArray;

@end

@implementation ZPMoviesViewController
@synthesize movieCollection;
@synthesize linkArr;
@synthesize moviesArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:2];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
    [self prepareData];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [movieCollection reloadData];
//}

-(void)setupView
{
    [self setTitle:@"Movies"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
 //   [flowLayout setItemSize:CGSizeMake(90.0, 90.0)];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 10, 5)];
    
    movieCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayout];
    movieCollection.delegate = self;
    movieCollection.dataSource = self;
    [movieCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"movieCell"];
    
    [movieCollection setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    movieCollection.AutoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:movieCollection];
}

-(void)prepareData
{

    moviesArray = [[LibraryAPI sharedInstance]filmEditedArr];
    for (FilmModel *film in moviesArray) {
        if (!linkArr) {
            linkArr = [[NSMutableArray alloc]init];
        }
        [linkArr addObject:[NSString stringWithFormat:@"%@",film.mediaURL]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [moviesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"movieCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [cell setBackgroundColor:[UIColor whiteColor]];
    
    FilmModel *movie = moviesArray[indexPath.row];

    
    UIImageView *moviePoster = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 90, 117)];
    [moviePoster setContentMode:UIViewContentModeScaleAspectFit];
    [moviePoster setImageWithURL:[NSURL URLWithString:movie.mediaThumbnailImage] placeholderImage:[UIImage imageNamed:@"LogoFSO(2)"]];
    [moviePoster setClipsToBounds:YES];

    UILabel *movieTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, moviePoster.frame.size.height + 10, cell.frame.size.width, cell.frame.size.height - moviePoster.frame.size.height)];

    [movieTitleLbl setNumberOfLines:2];
    [movieTitleLbl setText:movie.mediaName];
    [movieTitleLbl setFont:[UIFont boldFlatFontOfSize:14]];
    [movieTitleLbl setTextColor:[UIColor turquoiseColor]];
    [movieTitleLbl setTextAlignment:NSTextAlignmentJustified];
    [movieTitleLbl sizeToFit];
    [movieTitleLbl setClipsToBounds:YES];
    [cell.contentView addSubview:movieTitleLbl];

    [cell.contentView addSubview: moviePoster];
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.5, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);

    
    //4. Define the final state (After the animation) and commit the animation
    [UICollectionViewCell beginAnimations:@"rotation" context:NULL];
    [UICollectionViewCell setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];

    
    return cell;
}


#pragma mark - UICollectionViewFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(95.0, 167.0);
}


#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilmModel *movie = [moviesArray objectAtIndex:indexPath.row];
    //ZPDetailViewController *viewController = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withURLString:movie.mediaURL];
    //ZPDetailViewController *viewController = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withLinkArrs:linkArr andLink:movie.mediaURL];
    ZPDetailViewController *viewController = [[ZPDetailViewController alloc]initWithNibName:@"ZPDetailViewController" bundle:nil withFilmArrs:self.moviesArray andFilm:movie];
    viewController.movieTitle = movie.mediaName;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end