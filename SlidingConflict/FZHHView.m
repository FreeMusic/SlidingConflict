//
//  LaXiView.m
//  SlidingConflict
//
//  Created by sxy on 2019/12/30.
//  Copyright © 2019 EDZ. All rights reserved.
//

#import "FZHHView.h"
#import "FZHHCollectionView.h"
#import "FZHHFirstCell.h"
#import "FZHHContentCell.h"

@interface FZHHView ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) FZHHCollectionView *collectionView;///
@property (nonatomic, assign) FZHHContentCell *contentCell;///
@property (nonatomic, assign) BOOL canScroll;///

@end

@implementation FZHHView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus) name:@"shop_home_leaveTop" object:nil];
        self.canScroll = YES;
    }
    return self;
}

-(void)changeStatus{
    self.canScroll = YES;
    self.contentCell.canScroll = NO;
}

- (FZHHCollectionView *)collectionView {
    if (_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[FZHHCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
//        if (@available(iOS 11.0, *)) {
//            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FZHHFirstCell class] forCellWithReuseIdentifier:@"FZHHFirstCell"];
        [_collectionView registerClass:[FZHHContentCell class] forCellWithReuseIdentifier:@"FZHHContentCell"];
    }
    
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FZHHFirstCell *firstCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZHHFirstCell" forIndexPath:indexPath];
        
        return firstCell;
    }else{
        self.contentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FZHHContentCell" forIndexPath:indexPath];
        
        return self.contentCell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CGSizeMake(self.frame.size.width, 400);
    }
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = 444;
    if (scrollView.contentOffset.y >= offset) {
        [self.collectionView setContentOffset:CGPointMake(0, offset)];
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.canScroll = YES;
        }
    }else{
        if (!self.canScroll) {
            [self.collectionView setContentOffset:CGPointMake(0, offset)];
        }
    }
}


@end
