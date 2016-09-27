//
//  YJSActionSheet.m
//  自定义弹出界面
//
//  Created by apple on 16/9/27.
//  Copyright © 2016年 YJS. All rights reserved.
//

#import "YJSActionSheet.h"
#import "YJSActionSheetItem.h"

@interface YJSActionSheet ()

/**点击按钮block*/
@property (strong, nonatomic) ClickBlock clickBlock;

/**取消按钮block*/
@property (strong, nonatomic) CancelBlock cancelBlock;

/**等于 self.view*/
@property (strong, nonatomic) UIView * backgroundMask;

/**包含取消按钮视图*/
@property (strong, nonatomic) UIView * contentView;

/**分享样式视图*/
@property (strong, nonatomic) UIScrollView * scrollView;

/**sheet样式视图*/
@property (strong, nonatomic) UIView * normalView;

@end

@implementation YJSActionSheet

static YJSActionSheet * sheet = nil;

- (instancetype)initWithTitles:(NSArray *)titles iconNames:(NSArray *)iconNames
{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //自动调整自己的宽度，保证与superView左边和右边的距离不变 | 自动调整自己的高度，保证与superView顶部和底部的距离不变
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundMask = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundMask.backgroundColor = [UIColor blackColor];
        self.backgroundMask.alpha = 0;
        [self addSubview:self.backgroundMask];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.backgroundMask addGestureRecognizer:tap];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self.contentView];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.contentView addGestureRecognizer:tap2];
        
        CGFloat margin = 8;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(margin, 10, CGRectGetWidth(self.contentView.bounds)-margin*2, 150)];
        _scrollView.layer.masksToBounds = YES;
        _scrollView.layer.cornerRadius = 5;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setScrollEnabled:YES];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        CGFloat itemX = 10;
        NSUInteger count = titles.count <= iconNames.count ? titles.count:iconNames.count;
        for (int i = 0; i < count ; i++) {
            YJSActionSheetItem *item = [[YJSActionSheetItem alloc] initWithFrame:CGRectMake(itemX, 30, 60, 110)];
            item.tag = i;
            [item setTitle:titles[i] image:[UIImage imageNamed:iconNames[i]]];
            [item addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:item];
            itemX += (60 + 10);
        }
        _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.bounds));
        
        CGFloat btnY = CGRectGetMaxY(_scrollView.frame) + 8;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(margin, btnY, CGRectGetWidth(self.contentView.frame) - margin * 2, 44);
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.22 green:0.45 blue:1 alpha:1] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        CGFloat height = CGRectGetMaxY(btn.frame) + 10;
        
        CGRect frame = self.contentView.frame;
        frame.size.height = height;
        self.contentView.frame = frame;
        
        [self.contentView addSubview:_scrollView];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        //自动调整自己的宽度，保证与superView左边和右边的距离不变 | 自动调整自己的高度，保证与superView顶部和底部的距离不变
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundMask = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundMask.backgroundColor = [UIColor blackColor];
        self.backgroundMask.alpha = 0;
        [self addSubview:self.backgroundMask];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.backgroundMask addGestureRecognizer:tap];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self.contentView];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.contentView addGestureRecognizer:tap2];
        
        CGFloat margin = 8;
        self.normalView = [[UIView alloc]initWithFrame:CGRectMake(margin, 10, CGRectGetWidth(self.contentView.bounds) - margin * 2, 40 * titles.count)];
        self.normalView.layer.masksToBounds = YES;
        self.normalView.layer.cornerRadius = 5;
        self.normalView.backgroundColor = [UIColor whiteColor];
        
        NSUInteger count = titles.count;
        for(int i = 0; i< count; i++){
            UIButton * cellBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*40, self.normalView.frame.size.width, 40)];
            [cellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cellBtn setTitle:titles[i] forState:UIControlStateNormal];
            cellBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            cellBtn.layer.borderColor = [UIColor grayColor].CGColor;
            cellBtn.layer.borderWidth = 0.5;
            cellBtn.tag = i;
            [cellBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.normalView addSubview:cellBtn];
        }
        
        CGFloat btnY = CGRectGetMaxY(_normalView.frame) + 8;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = CGRectMake(margin, btnY, CGRectGetWidth(self.contentView.frame) - margin * 2, 44);
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.22 green:0.45 blue:1 alpha:1] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        CGFloat height = CGRectGetMaxY(btn.frame) + 10;
        
        CGRect frame = self.contentView.frame;
        frame.size.height = height;
        self.contentView.frame = frame;
        
        [self.contentView addSubview:_normalView];
    }
    return self;
}


- (void)clickAction:(UIView *)item{
    if (_clickBlock) {
        _clickBlock((int)item.tag);
    }
    
    [self dismiss];
}

- (void)setContentViewFrameY:(CGFloat)y{
    CGRect frame = self.contentView.frame;
    frame.origin.y = y;
    self.contentView.frame = frame;
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundMask.alpha = 0;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds)];
    } completion:^(BOOL finished) {
        sheet.hidden = YES;
        sheet = nil;
    }];
}

- (void)showActionSheetWithClickBlock:(ClickBlock)clickBlock cancelBlock:(CancelBlock)cancelBlock{
    _clickBlock = clickBlock;
    _cancelBlock = cancelBlock;
    sheet = self;
    sheet.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundMask.alpha = 0.6;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(self.contentView.frame)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end

