//
//  DAPunchAwardCalendarCollectionView.m
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "DAPunchAwardCalendarCollectionView.h"
#import "DAPunchAwardCollectionViewPageLayout.h"
#import "DAPunchAwardCalendarCollectionViewCell.h"
#import "NSDate+DAPunchAwardCalendar.h"
#import "DAPunchAwardCalendarHeaderView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DAPunchAwardCalendarCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *calendarCollectionView;
/**
 当前月份
 */
@property (nonatomic, strong) NSDate *currentDate;
/**
 当前显示页面的月份
 */
@property (nonatomic, strong) NSDate *currentIndexDate;

/**
 网络数据的容器
 */
@property (nonatomic, strong) NSMutableDictionary *punchCardLogDic;

@end

@implementation DAPunchAwardCalendarCollectionView {
    CGPoint _lastContentOffset;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.scrollsToTop = NO;
        [self registerNib:[UINib nibWithNibName:@"DAPunchAwardCalendarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DAPunchAwardCalendarCollectionViewCell"];
        [self registerClass:[DAPunchAwardCalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DAPunchAwardCalendarHeaderView"];
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.currentDate = [NSDate date];
        self.currentIndexDate = [NSDate date];
        self.punchCardLogDic = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark -- delegate and datasource
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DAPunchAwardCalendarHeaderView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13 * 6 * 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DAPunchAwardCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DAPunchAwardCalendarCollectionViewCell" forIndexPath:indexPath];
    cell.dateLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NSInteger offsetNum = indexPath.row/(42) - 6;
    NSDate *date = [_currentDate offsetMonthDate:offsetNum];
//    NSInteger month = [date dateYear] * 100 + [date dateMonth];
    NSInteger weekIndex = [date firstWeekDayInMonth];
    NSInteger totalDay = [date totalDaysInMonth];
    if (indexPath.row%(42) - weekIndex + 1 >= 0&&indexPath.row%(42) - weekIndex + 1 < totalDay) {
        NSString *day = [NSString stringWithFormat:@"%ld",indexPath.row%(42) - weekIndex + 2];
        if (offsetNum > 0) {
            cell.dateLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        }else if (offsetNum == 0) {
            if (indexPath.row%(42) - weekIndex + 2 > [_currentDate dateDay]) {
                //超过当前日期
                cell.dateLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
            }
        }
        
        cell.dateLab.text = day;
    }else {
        cell.dateLab.text = @"";
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DAPunchAwardCalendarCollectionViewCell *cell = (DAPunchAwardCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_currentIndexDate];
    NSString *dayStr = cell.dateLab.text;
    if (dayStr) {
        components.day = [dayStr integerValue];
        NSDate *selectedDate = [calendar dateFromComponents:components];
        if (self.calendarCellSelectedDateBlock) {
            self.calendarCellSelectedDateBlock(selectedDate);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = ceil(scrollView.contentOffset.x/scrollView.frame.size.width);
    NSInteger offsetNum = pageIndex - 6;
    self.currentIndexDate = [_currentDate offsetMonthDate:offsetNum];
    if (self.calendarCurrentShowDateBlock) {
        self.calendarCurrentShowDateBlock(self.currentIndexDate);
    }
}


/**
 刷新日历
 */
- (void)reloadCalendar {
    NSInteger pageIndex = self.contentOffset.x/self.frame.size.width;
    NSMutableArray <NSIndexPath *>*reloadIndexPathArr = [NSMutableArray array];
    for (NSInteger i = pageIndex * 42; i < (pageIndex + 1) * 42; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [reloadIndexPathArr addObject:indexPath];
    }
    [self reloadItemsAtIndexPaths:reloadIndexPathArr];
}

@end
