//
//  DAPunchAwardCollectionViewPageLayout.m
//  DAalendar
//
//  Created by linfeng wang on 2019/6/28.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "DAPunchAwardCollectionViewPageLayout.h"

@interface DAPunchAwardCollectionViewPageLayout ()

@property (nonatomic, strong) NSMutableArray *attributs;
@property (nonatomic, strong) NSMutableArray *sectionPages;

@end

@implementation DAPunchAwardCollectionViewPageLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    NSInteger totalPages = 0;
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSMutableArray *attributsArray = [NSMutableArray array];
    NSInteger sections = self.collectionView.numberOfSections;
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        NSInteger pagesInSection = ceil(items/(self.lines*self.lineInteritems));
        totalPages += pagesInSection;
        [sectionArray addObject:@(pagesInSection)];
    }
    self.sectionPages = sectionArray;
    self.pages = totalPages;
    
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < items; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *layout = [self layoutAttributesForItemAtIndexPath:indexPath];
            if (layout) {
                [attributsArray addObject:layout];
            }
        }
    }
    self.attributs = attributsArray;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = [super collectionViewContentSize];
    size.width = self.collectionView.frame.size.width * self.pages;
    size.width -= self.collectionView.contentInset.left + self.collectionView.contentInset.right;
    return size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *collectionAttributs = [super layoutAttributesForItemAtIndexPath:indexPath];
    int pageIndex = [self pageIndexForIndexPath:indexPath];
    NSInteger pageResidue = indexPath.row % (_lines * _lineInteritems);
    NSInteger lineIndex = pageResidue/_lineInteritems;
    NSInteger lineInteritemIndex = pageResidue%_lineInteritems;
    
    CGSize itemSize = self.itemSize;
    CGFloat showWidth = self.collectionView.frame.size.width - self.collectionView.contentInset.left - self.collectionView.contentInset.right;
    CGFloat interitemTotalSpacing = (showWidth - itemSize.width * _lineInteritems);
    NSInteger interitemSpacing = _lineInteritems == 1 ? interitemTotalSpacing : interitemTotalSpacing / (_lineInteritems - 1);
    CGFloat showHeight = self.collectionView.frame.size.height - self.collectionView.contentInset.top - self.collectionView.contentInset.bottom;
    CGFloat lineTotalSpacing = (showHeight - itemSize.height * _lines);
    NSInteger lineSpacing = _lines == 1 ? lineTotalSpacing : lineTotalSpacing / (_lines - 1);
    CGRect itemFrame = collectionAttributs.frame;
    itemFrame.size = itemSize;
    itemFrame.origin.x = pageIndex * self.collectionView.frame.size.width + (itemSize.width + interitemSpacing) * lineInteritemIndex;
    itemFrame.origin.y = (itemSize.height + lineSpacing) * lineIndex;
    if (pageIndex > 0) {
        itemFrame.origin.x += self.collectionView.contentInset.left;
    }
    collectionAttributs.frame = itemFrame;
    return collectionAttributs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributs;
}

- (int)pageIndexForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger pageIndexInSection = indexPath.item/(self.lines * self.lineInteritems);
    NSInteger pageIndex = pageIndexInSection;
    if (indexPath.section < self.sectionPages.count) {
        for (int i = 0; i < indexPath.section; i++) {
            NSInteger totalPageInSection = [self.sectionPages[i] integerValue];
            pageIndex += totalPageInSection;
        }
    }
    return  [NSString stringWithFormat:@"%ld", (long)pageIndex].intValue;
}

- (int)pageIndexForSection:(int)section
{
    NSInteger pageIndex = 0;
    if (section < self.sectionPages.count) {
        for (int i = 0; i < section; i++) {
            NSInteger totalPageInSection = [self.sectionPages[i] integerValue];
            pageIndex += totalPageInSection;
        }
    }
    return  [NSString stringWithFormat:@"%ld", (long)pageIndex].intValue;
}

@end
