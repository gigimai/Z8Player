//
//  ORGContainerCellView.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ORGContainerCellView.h"
#import "ORGArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
//#import "AsyncImageView.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+FlatUI.h"

@interface ORGContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end

@implementation ORGContainerCellView

- (void)awakeFromNib {

   // self.collectionView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(130.0, 170.0);
    [self.collectionView setCollectionViewLayout:flowLayout];

    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORGArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ORGArticleCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    cell.articleTitle.text = [cellData objectForKey:@"title"];
    [cell.articleTitle setTextColor:[UIColor greenSeaColor]];
    //cell.articleImage.imageURL = [NSURL URLWithString:[cellData objectForKey:@"imageURL"]];
    [cell.articleImage setImageWithURL:[NSURL URLWithString:[cellData objectForKey:@"imageURL"]] placeholderImage:[UIImage imageNamed:@"LogoFSO(2).png"]];
    //cell.articleLink.text = [cellData objectForKey:@""]
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}


@end