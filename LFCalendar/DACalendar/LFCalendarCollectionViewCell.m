//
//  LFCalendarCollectionViewCell.m
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import "LFCalendarCollectionViewCell.h"
#import "NSDate+LFCalendar.h"

@interface LFCalendarCollectionViewCell ()

@property (nonatomic, strong) UIColor *lightCalendarColor;
@property (nonatomic, strong) UIColor *calendarColor;

@end

@implementation LFCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lightCalendarColor = [UIColor colorWithRed:252/255.0 green:207/255.0 blue:0/255.0 alpha:0.2];
    self.calendarColor = [UIColor colorWithRed:252/255.0 green:207/255.0 blue:0/255.0 alpha:0.8];
    self.leftView.backgroundColor = self.lightCalendarColor;
    self.rightView.backgroundColor = self.lightCalendarColor;
    
    self.todayBgView.layer.cornerRadius = 12.f;
    self.dateLab.layer.masksToBounds = YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.leftView.hidden = YES;
    self.rightView.hidden = YES;
    self.todayBgView.hidden = YES;
    self.dateLab.backgroundColor = [UIColor clearColor];
    self.dateLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.dateLab.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(0, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.dateLab.bounds;
    maskLayer.path = maskPath.CGPath;
    self.dateLab.layer.mask = maskLayer;
}


@end
