//
//  ViewController.m
//  LFCalendar
//
//  Created by linfeng wang on 2019/7/31.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "ViewController.h"
#import "DACalendar/LFCalendarView.h"

static CGFloat DefaultCalendarViewHeight = 295;
//static CGFloat DefaultCalendarViewHeaderHeight = 70;
//static CGFloat DefaultCalendarViewCellHeight = 34;

@interface ViewController ()

@property (nonatomic, strong) LFCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.calendarView];
    self.calendarView.calenderShowDateBlock = ^(NSDate * _Nonnull date, NSInteger lines) {
        NSLog(@"%@",date);
    };
}

#pragma mark -- setter and getter

- (LFCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[LFCalendarView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, DefaultCalendarViewHeight)];
    }
    return _calendarView;
}

@end
