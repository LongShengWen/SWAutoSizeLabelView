//
//  swAutoSizeLabelCollectionLayout.h
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finshLayoutBlock)(CGSize size);

@protocol swAutoSizeLabelCollectionLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface swAutoSizeLabelCollectionLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id <swAutoSizeLabelCollectionLayoutDataSource> dataSource;
@property (nonatomic,copy) finshLayoutBlock finshLayout;

@property (nonatomic) UIEdgeInsets    contentInsets;
@property (nonatomic) CGFloat         itemHeight;
@property (nonatomic) CGFloat         itemSpace;
@property (nonatomic) CGFloat         lineSpace;
@property (nonatomic) CGFloat         itemMargin;
@property (nonatomic) UIFont          *titleFont;
@property (nonatomic,readonly) NSInteger  itemCount;
@property (nonatomic) CGSize          contentSize;
@property (nonatomic) BOOL            lineBreak;

@end
