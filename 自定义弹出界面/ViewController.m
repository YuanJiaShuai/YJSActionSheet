//
//  ViewController.m
//  自定义弹出界面
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 YJS. All rights reserved.
//

#import "ViewController.h"
#import "YJSActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 40, 100)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.tag = 10;
    [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 40, 100)];
    btn2.backgroundColor = [UIColor orangeColor];
    btn2.tag = 20;
    [btn2 addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)btnEvent:(UIButton *)sender{
    NSArray *titles = @[@"分享到朋友圈",@"分享到微博",@"分享到QQ空间",@"分享到QQ好友",@"分享到微信好友"];
    NSArray *imageNames = @[@"sns_icon_23",@"sns_icon_1",@"sns_icon_6",@"sns_icon_copy",@"sns_icon_f"];
    if(sender.tag == 10){
        YJSActionSheet * sheet = [[YJSActionSheet alloc]initWithTitles:titles];
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            NSLog(@"默认分享点击了 btnIndex:%d",btnIndex);
        } cancelBlock:^{
            NSLog(@"取消");
        }];
    }
    if(sender.tag == 20){
        YJSActionSheet *sheet = [[YJSActionSheet alloc] initWithTitles:titles iconNames:imageNames];
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            NSLog(@"图片分享点击了 btnIndex:%d",btnIndex);
        } cancelBlock:^{
            NSLog(@"取消");
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
