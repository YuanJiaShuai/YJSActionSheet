//
//  YJSActionSheet.h
//  自定义弹出界面
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 YJS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(int btnIndex);
typedef void (^CancelBlock)(void);

@interface YJSActionSheet : UIWindow

/**
 *  分享样式
 *
 *  @param titles    标题
 *  @param iconNames 图片
 *
 *  @return 当前对象
 */
- (instancetype)initWithTitles:(NSArray *)titles iconNames:(NSArray *)iconNames;

/**
 *  sheet样式
 *
 *  @param titles 标题
 *
 *  @return 当前对象
 */
- (instancetype)initWithTitles:(NSArray *)titles;


- (void)showActionSheetWithClickBlock:(ClickBlock)clickBlock cancelBlock:(CancelBlock)cancelBlock;



@end
