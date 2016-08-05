//
//  ViewController.m
//  NXBTextImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/5.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "ViewController.h"
#import "NXBTextImageEditerViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 50);
    [btn setTitle:@"点击我进入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)btnClick {
    NXBTextImageEditerViewController *eVC = [[NXBTextImageEditerViewController alloc]init];
    [self.navigationController pushViewController:eVC animated:YES  ];
}
@end
