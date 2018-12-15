//
//  swAutoSizeLabelCollectionLayout.h
//  DemoCollection
//
//  Created by  on 2018/12/13.
//  Copyright © 2018年 lsw. All rights reserved.
//


#import "swAutoSizeLabelCollectionLayout.h"

typedef struct currentOrigin {
    CGFloat     lineX;
    CGFloat     lineY;
    NSInteger   lineNumber;
}currentOrigin;


@implementation swAutoSizeLabelCollectionLayout {
    
    currentOrigin   orgin;
    CGFloat         cacheX;
    CGFloat         cacheY;
    CGFloat         maxWith;
    CGSize          contentSize;
    NSMutableArray<NSValue *>* itemFrames;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)prepareLayout {
    [super prepareLayout];
    
    if (itemFrames == nil) {
        itemFrames = [NSMutableArray new];
    } else {
        [itemFrames removeAllObjects];
    }
    _itemCount = [self.collectionView numberOfItemsInSection:0];

    orgin.lineNumber = 0;
    orgin.lineX = _contentInsets.left;
    orgin.lineY = _contentInsets.top;
    maxWith = 0;
    
    for (int i = 0 ; i < _itemCount; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSString *title = [self.dataSource titleForLabelAtIndexPath:indexPath];
        CGSize size = [self sizeWithTitle:title font:_titleFont];
        
        orgin.lineY = orgin.lineNumber * (_itemHeight + _lineSpace) + _contentInsets.top;
        CGFloat itemWidth = size.width + _itemMargin;
        maxWith = itemWidth > maxWith ? itemWidth : maxWith;
        if (_lineBreak) {
            if (itemWidth > CGRectGetWidth(self.collectionView.frame)-(_contentInsets.left+_contentInsets.right)) {
                itemWidth = CGRectGetWidth(self.collectionView.frame)-(_contentInsets.left+_contentInsets.right);
            }
        }
        
        CGRect currentItemFrame = CGRectMake(orgin.lineX,orgin.lineY, itemWidth, _itemHeight);
        orgin.lineX += itemWidth + _itemSpace;
        
        if (_lineBreak) {

            if (i < _itemCount - 1) {

                NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:i+1 inSection:0];
                NSString *nextTitle = [self.dataSource titleForLabelAtIndexPath:nextIndexPath];
                CGSize nextSize = [self sizeWithTitle:nextTitle font:_titleFont];
                if (nextSize.width + _itemMargin > CGRectGetWidth(self.collectionView.frame) - _contentInsets.right - orgin.lineX) {
                    orgin.lineNumber ++;
                    orgin.lineX = _contentInsets.left;
                }
            }
        }
  
        NSValue *value = [NSValue valueWithCGRect:currentItemFrame] ;
        [itemFrames addObject:value];
    }
    
    CGFloat contentSizeX = 0;
    CGFloat contentSizeY = 0;
    if (_lineBreak) {
        contentSizeX = self.collectionView.frame.size.width;
        contentSizeY = (orgin.lineNumber + 1) * _itemHeight + orgin.lineNumber * _lineSpace + _contentInsets.top + _contentInsets.bottom;
        maxWith = maxWith + _contentInsets.left + _contentInsets.right;
    } else {
        if (itemFrames.count > 0 ) {
            CGRect currentItemFrame = [[itemFrames objectAtIndex:(itemFrames.count - 1)] CGRectValue];
            contentSizeX = currentItemFrame.origin.x + currentItemFrame.size.width + _contentInsets.right;
            contentSizeY = _itemHeight + _lineSpace + _contentInsets.top + _contentInsets.bottom;
            maxWith = contentSizeX;
        }
    }
    contentSize = CGSizeMake(contentSizeX, contentSizeY);
    if (cacheX != maxWith || cacheY != contentSizeY) {
        cacheX = maxWith;
        cacheY = contentSizeY;
        if (_finshLayout) {
            _finshLayout(CGSizeMake(cacheX, cacheY));
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributesArray = [NSMutableArray array];

    for (NSInteger i = 0; i < _itemCount; i++) {
        
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGRect currentItemFrame = [[itemFrames objectAtIndex:i] CGRectValue];
        UICollectionViewLayoutAttributes *cellAttrs = [[self layoutAttributesForItemAtIndexPath:currentIndexPath] copy];
        cellAttrs.frame = currentItemFrame;
        [attributesArray addObject:cellAttrs];
    }
    return attributesArray;
}
- (CGSize)collectionViewContentSize{
    return contentSize;
}
- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(2000, _itemHeight)
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil];

    return rect.size;
}
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    return proposedContentOffset;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
