//
//  YJSActionSheetItem.m
//  自定义弹出界面
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 YJS. All rights reserved.
//

#import "YJSActionSheetItem.h"

@implementation YJSActionSheetItem

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect titleRect = CGRectMake(5, CGRectGetHeight(self.bounds) - 40, CGRectGetWidth(self.bounds) - 10, 40);
    return titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect imageRect = self.bounds;
    imageRect.size.height = CGRectGetWidth(self.bounds);
    return imageRect;
}

- (void)setTitle:(NSString *)title image:(UIImage *)image{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
}

@end
