//
//  ViewController.m
//  DrawRectDemo
//
//  Created by 叮咚钱包富银 on 2018/7/6.
//  Copyright © 2018年 leo. All rights reserved.
//

#import "ViewController.h"
#import "drawRectView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addDrawRectView];
}

- (void)addDrawRectView {
    drawRectView *drawView = [[drawRectView alloc] init];
    [self.view addSubview:drawView];
    drawView.frame = self.view.bounds;
    drawView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
