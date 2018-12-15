//
//  swAutoSizeLabelCell.h
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "swAutoSizeLabelModel.h"

@interface swAutoSizeLabelCell : UICollectionViewCell

@property (nonatomic,strong) swAutoSizeLabelModel *BaseModel;
@property (nonatomic,strong) NSString *title;

// 是否选中
@property (nonatomic,assign) BOOL isSelect;

// item 选中颜色
@property (nonatomic) UIColor       *itemSelectColor;
// item 文本选中颜色
@property (nonatomic) UIColor       *textSelectColor;
// item 颜色
@property (nonatomic) UIColor       *itemNormalColor;
// item 文本颜色
@property (nonatomic) UIColor       *textNormalColor;
// item 字体
@property (nonatomic) UIFont        *textFont;


@property (nonatomic) CGFloat       itemCornerRaius;

@end



