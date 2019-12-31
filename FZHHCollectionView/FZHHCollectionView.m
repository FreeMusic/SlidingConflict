//
//  FZHHCollectionView.m
//  SlidingConflict
//
//  Created by sxy on 2019/12/30.
//  Copyright © 2019 EDZ. All rights reserved.
//

#import "FZHHCollectionView.h"

@interface FZHHCollectionView ()<UIGestureRecognizerDelegate>

@end

@implementation FZHHCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
