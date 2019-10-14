//
//  DAPunchAwardCalendarCollectionViewCell.h
//  DAalendar
//
//  Created by linfeng wang on 2019/7/1.
//  Copyright © 2019 linfeng wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFCalendarCollectionViewCell : UICollectionViewCell


@property (unsafe_unretained, nonatomic) IBOutlet UIView *todayBgView;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *leftView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *rightView;


@end

NS_ASSUME_NONNULL_END
