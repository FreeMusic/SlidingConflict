//
//  FZHHContentCell.m
//  SlidingConflict
//
//  Created by sxy on 2019/12/30.
//  Copyright © 2019 EDZ. All rights reserved.
//

#import "FZHHContentCell.h"
#import "FZHHFirstContentView.h"

@interface FZHHContentCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *headerView;///
@property (nonatomic, strong) UICollectionView *collectionView;///
@property (nonatomic, strong) NSMutableArray *views;///
@property (nonatomic, strong) NSMutableArray *cells;///

@end

@implementation FZHHContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.headerView];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, self.frame.size.height-100) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    
    return _collectionView;
}

- (NSMutableArray *)views {
    if (_views == nil){
        _views = [NSMutableArray array];
    }
    
    return _views;
}

- (NSMutableArray *)cells {
    if (_cells == nil){
        _cells = [NSMutableArray array];
    }
    
    return _cells;
}

- (UIView *)headerView {
    if (_headerView == nil){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _headerView.backgroundColor = [UIColor blueColor];
        NSArray *titles = @[@"第一个", @"第二个", @"第三个", @"第四个"];
        CGFloat width = self.frame.size.width/titles.count;
        for (int i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [_headerView addSubview:button];
            button.frame = CGRectMake(width*i, 0, width, 100);
            UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            FZHHFirstContentView *contentView = [[FZHHFirstContentView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-100)];
            [self.views addObject:contentView];
            [cell addSubview:contentView];
            [self.cells addObject:cell];
        }
    }
    
    return _headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cells objectAtIndex:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width, self.frame.size.height-100);
}

- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    for (FZHHFirstContentView *contentView in self.views) {
        contentView.canScroll = canScroll;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (FZHHFirstContentView *contentView in self.views) {
        contentView.canScroll = self.canScroll;
    }
}

@end
