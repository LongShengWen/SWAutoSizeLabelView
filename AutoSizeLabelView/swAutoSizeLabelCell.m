//
//  swAutoSizeLabelCell.m
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//

#import "swAutoSizeLabelCell.h"
#import <Masonry/Masonry.h>

@interface swAutoSizeLabelCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation swAutoSizeLabelCell

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
//    _titleLabel.layer.cornerRadius = _itemCornerRaius;
    _titleLabel.font = _textFont;
    if (_isSelect) {
        _titleLabel.backgroundColor = _itemSelectColor;
        _titleLabel.textColor = _textSelectColor;
    } else {
        _titleLabel.backgroundColor = _itemNormalColor;
        _titleLabel.textColor = _textNormalColor;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setBaseModel:(swAutoSizeLabelModel *)BaseModel {
    
    _BaseModel = BaseModel;
    _isSelect = BaseModel.select;
    self.titleLabel.text = BaseModel.itemTitle;
    _titleLabel.text = BaseModel.itemTitle;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

@end
