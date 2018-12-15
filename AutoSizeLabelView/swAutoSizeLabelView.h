//
//  swAutoSizeLabelView.h
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "swAutoSizeLabelModel.h"

typedef void(^selectItemHandler)(NSUInteger index,swAutoSizeLabelModel *model);
typedef void(^finshLayoutBlock)(CGSize size);

@interface swAutoSizeLabelView : UIView

@property (nonatomic,strong) NSMutableArray<swAutoSizeLabelModel *>   *data;
// 点击回调
@property (nonatomic, copy) selectItemHandler  selectHandler;
// 布局完成后返回整个页面的最大宽高
@property (nonatomic, copy) finshLayoutBlock finshLayout;

@property(nonatomic,assign) BOOL bounces;
@property(nonatomic,assign) BOOL showsHorizontalScrollIndicator;
@property(nonatomic,assign) BOOL showsVerticalScrollIndicator;
@property(nonatomic,assign) BOOL allowsMultipleSelection;

@property (nonatomic) UIEdgeInsets  contentInsets;
// item 内嵌的距离
@property (nonatomic) CGFloat       textMargin;
// item 横距
@property (nonatomic) CGFloat       lineSpace;
// item  高度
@property (nonatomic) CGFloat       itemHeight;
// item 间隔
@property (nonatomic) CGFloat       itemSpace;
// item 圆角
@property (nonatomic) CGFloat       itemCornerRaius;
// item 边框宽度
@property (nonatomic) CGFloat       itemBorderWidth;
// item 边框颜色
@property (nonatomic) UIColor       *itemBorderColor;
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
// view 背景色
@property (nonatomic) UIColor       *backgroundColor;
// 是否换行
@property (nonatomic) BOOL          lineBreak;

- (instancetype)initWithFrame:(CGRect)frame
                         data:(NSMutableArray<swAutoSizeLabelModel *> *) data;

- (void)insertLabelWithModel:(swAutoSizeLabelModel *)model
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertLabelsWithDatas:(NSMutableArray<swAutoSizeLabelModel *>*)data
                    atIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;

- (void)deleteLabelAtIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;

- (void)reloadAllWithData:(NSMutableArray<swAutoSizeLabelModel *> *) data;

- (void)reload;
@end




