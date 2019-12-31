//
//  ViewController.m
//  SlidingConflict
//
//  Created by sxy on 2019/12/30.
//  Copyright © 2019 EDZ. All rights reserved.
//

#import "ViewController.h"
#import "FZHHView.h"

@interface ViewController ()

@property (nonatomic, strong) FZHHView *eneneView;///

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eneneView = [[FZHHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.eneneView];
}


@end
