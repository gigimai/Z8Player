//
//  ORGContainerCell.m
//  Z8Player
//
//  Created by Khanhhoa Mai on 8/7/14.
//  Copyright (c) 2014 FSOFT. All rights reserved.
//

#import "ORGContainerCell.h"
#import "ORGContainerCellView.h"

@interface ORGContainerCell ()
@property (strong, nonatomic) ORGContainerCellView *collectionView;
@end

@implementation ORGContainerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"ORGContainerCellView" owner:self options:nil][0];
        _collectionView.frame = self.bounds;
        [self.contentView addSubview:_collectionView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCollectionData:(NSArray *)collectionData {
    [_collectionView setCollectionData:collectionData];
}



@end
