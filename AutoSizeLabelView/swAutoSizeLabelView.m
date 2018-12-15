//
//  swAutoSizeLabelView.m
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//


#import "swAutoSizeLabelView.h"
#import "swAutoSizeLabelCell.h"
#import "swAutoSizeLabelCollectionLayout.h"
#import <Masonry/Masonry.h>



@interface swAutoSizeLabelView () <UICollectionViewDataSource,UICollectionViewDelegate,swAutoSizeLabelCollectionLayoutDataSource>

@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) swAutoSizeLabelCollectionLayout *layout;

@end

@implementation swAutoSizeLabelView

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray<swAutoSizeLabelModel *> *) data {
 
    self = [super initWithFrame:frame];
    if (self) {

        self.data = [data mutableCopy];
        
        [self initConfig];
        [self setup];
        [self addLayout];
    }
    return self;
}
- (void)initConfig {
    
    self.contentInsets = UIEdgeInsetsMake(10, 15, 10, 15);
    self.lineSpace = 10;
    self.itemHeight = 25;
    self.itemSpace = 10;
    self.itemCornerRaius = 3;
    
    self.itemBorderWidth = 0;
    self.itemBorderColor = [UIColor whiteColor];
    self.itemCornerRaius = 0;
    self.textMargin = 20;
    self.itemSelectColor = [UIColor whiteColor];
    self.textSelectColor = [UIColor darkTextColor];
    self.itemNormalColor = [UIColor whiteColor];
    self.textNormalColor = [UIColor darkTextColor];
    self.textFont = [UIFont systemFontOfSize:15];
    self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initConfig];
        [self setup];
        [self addLayout];
    }
    return self;
}
- (void)addLayout {
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)setData:(NSMutableArray<swAutoSizeLabelModel *> *) data {
    _data = data;
}

- (void)setup {
    [self addSubview:self.collection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    swAutoSizeLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"swAutoSizeLabelCell"
                                                                          forIndexPath:indexPath];
    cell.itemSelectColor = _itemSelectColor;
    cell.itemNormalColor = _itemNormalColor;
    cell.textFont = _textFont;
    cell.textNormalColor = _textNormalColor;
    cell.textSelectColor = _textSelectColor;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = _itemBorderWidth;
    cell.layer.borderColor = _itemBorderColor.CGColor;
    cell.layer.cornerRadius = _itemCornerRaius;
    [cell setBaseModel:self.data[indexPath.item]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectHandler) {
        NSUInteger index = indexPath.item;
        swAutoSizeLabelModel *model = self.data[index];
        self.selectHandler(index, model);
    }
}
- (UICollectionView *)collection {
    
    if (_layout == nil) {
        _layout = [[swAutoSizeLabelCollectionLayout alloc]init];
        _layout.dataSource = self;
        __weak typeof(self) __weakSelf = self;
        _layout.finshLayout = ^(CGSize size) {
            if (__weakSelf.finshLayout) {
                __weakSelf.finshLayout(size);
            }
        };
    }
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.contentInsets = _contentInsets;
    _layout.titleFont = _textFont;
    _layout.lineSpace = _lineSpace;
    _layout.itemHeight = _itemHeight;
    _layout.itemSpace = _itemSpace;
    _layout.itemMargin = _textMargin;
    _layout.lineBreak = _lineBreak;
    
    if (_collection == nil) {
        
        _collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[swAutoSizeLabelCell class] forCellWithReuseIdentifier:@"swAutoSizeLabelCell"];
    }
    
    _collection.allowsMultipleSelection = self.allowsMultipleSelection;
    _collection.bounces = self.bounces;
    _collection.backgroundColor = self.backgroundColor;
    _collection.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator;
    _collection.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
    _collection.collectionViewLayout = _layout;
    
    return _collection;
}
- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    swAutoSizeLabelModel *model = self.data[indexPath.item];
    return model.itemTitle;
}

- (void)layoutFinishWithNumberOfline:(NSInteger)number {
    static NSInteger numberCount;
    if (numberCount == number) {
        return;
    }
    numberCount = number;
    CGFloat h = _contentInsets.top + _contentInsets.bottom + _itemHeight * number + _lineSpace*(number-1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    [UIView animateWithDuration:0.2 animations:^{
        self.collection.frame = self.bounds;
    }];
}

- (void)insertLabelWithModel:(swAutoSizeLabelModel *)model
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.data insertObject:model atIndex:index];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animated:animated];
}

- (void)insertLabelsWithDatas:(NSMutableArray<swAutoSizeLabelModel *>*)data
                    atIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data insertObjects:data atIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:indexPaths animated:animated];
}

- (void)deleteLabelAtIndex:(NSUInteger)index animated:(BOOL)animated {
    [self deleteLabelsAtIndexes:[NSIndexSet indexSetWithIndex:index] animated:animated];
}

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data removeObjectsAtIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animated:animated];
}

- (void)reloadAllWithData:(NSMutableArray<swAutoSizeLabelModel *> *) data {
    self.data = [data mutableCopy];
    [self.collection reloadData];
}
- (void)reload {
    [self.collection reloadData];
}

- (void)performBatchUpdatesWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [self.collection performBatchUpdates:^{
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.collection insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.collection deleteItemsAtIndexPaths:indexPaths];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (!animated) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
}

- (NSArray *)indexPathsWithIndexes:(NSIndexSet *)set {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    return [indexPaths copy];
}

@end

