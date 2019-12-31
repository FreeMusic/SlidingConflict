//
//  FZHHFirstContentView.m
//  SlidingConflict
//
//  Created by sxy on 2019/12/30.
//  Copyright © 2019 EDZ. All rights reserved.
//

#import "FZHHFirstContentView.h"

@interface FZHHFirstContentView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;///
@property (nonatomic,assign) CGFloat lastOffset;

@end

@implementation FZHHFirstContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = (indexPath.row%2)?[UIColor whiteColor] : [UIColor grayColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.frame.size.width-40, 200);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.canScroll == NO) {
        [self.collectionView setContentOffset:CGPointMake(0, 0)];
    }
    if (scrollView.contentOffset.y < 0) {
        self.canScroll = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shop_home_leaveTop" object:nil];//到顶通知父视图改变状态
        [self.collectionView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    if (canScroll == NO) {
        [self.collectionView setContentOffset:CGPointMake(0, 0)];
    }
    
    self.lastOffset = self.collectionView.contentOffset.y;
}

@end
