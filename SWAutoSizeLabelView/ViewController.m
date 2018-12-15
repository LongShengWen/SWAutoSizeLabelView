//
//  ViewController.m
//  SWAutoSizeLabelView
//
//  Created by 粟黄 on 2018/12/15.
//  Copyright © 2018年 lsw. All rights reserved.
//

#import "ViewController.h"
#import "swAutoSizeLabelModel.h"
#import "swAutoSizeLabelView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property(nonatomic,strong) swAutoSizeLabelView *autoresizeLabelFlow;
@property (nonatomic,strong) NSMutableArray<swAutoSizeLabelModel *>   *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    [self addLayout];
}
- (void)buildUI {
    
    _autoresizeLabelFlow = [swAutoSizeLabelView new];
    [self.view addSubview:_autoresizeLabelFlow];
    
    _autoresizeLabelFlow.textNormalColor = [UIColor redColor];
    _autoresizeLabelFlow.lineBreak = YES;
    //    _autoresizeLabelFlow.itemCornerRaius = 5;
    //    _autoresizeLabelFlow.itemBorderWidth = 1;
    //    _autoresizeLabelFlow.itemBorderColor = [UIColor greenColor];
    //    _autoresizeLabelFlow.itemSelectColor = [UIColor blueColor];
    _autoresizeLabelFlow.data = self.data;
    _autoresizeLabelFlow.selectHandler = ^(NSUInteger index, swAutoSizeLabelModel *model) {
        NSLog(@"index - %ld title = %@",index,model.itemTitle);
    };
    __weak typeof(self) __weakSelf = self;
    _autoresizeLabelFlow.finshLayout = ^(CGSize size) {
        NSLog(@"with - %f \n height - %f",size.width,size.height);
        [__weakSelf.autoresizeLabelFlow mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
            make.width.mas_equalTo(size.width);
        }];
    };
    [_autoresizeLabelFlow reload];
}
- (void)addLayout {
    [_autoresizeLabelFlow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
}
- (NSMutableArray<swAutoSizeLabelModel *> *)data {
    if (_data == nil) {
        _data = [NSMutableArray new];
        for (int i = 0; i < 10; i ++ ) {
            swAutoSizeLabelModel *model = [swAutoSizeLabelModel new];
            if (i % 2 == 0) {
                model.itemTitle = @"啊哈哈哈哈哈";
                model.select = YES;
            } else {
                model.itemTitle = @"是废柴";
                model.select = NO;
            }
            [_data addObject:model];
        }
    }
    return _data;
}
@end
