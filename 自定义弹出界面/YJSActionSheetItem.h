//
//  YJSActionSheetItem.h
//  自定义弹出界面
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 YJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJSActionSheetItem : UIButton

@property (assign, nonatomic) int btnIndex;

- (void)setTitle:(NSString *)title image:(UIImage *)image;

@end
