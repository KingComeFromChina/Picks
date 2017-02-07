//
//  WLDatePickerView.h
//  NewAppNotice
//
//  Created by 王垒 on 2016/10/18.
//  Copyright © 2016年 King. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^CancelButtonDidCliked)(NSDate * date);;
@interface WLDatePickerView : UIView


@property (nonatomic,copy)CancelButtonDidCliked cancelButtonDidCliked;

- (void)show:(NSInteger)before after:(NSInteger)after cancelButton:(NSString *)cancelButton doneButton:(NSString *)doneButton  cancelButtonDidClikedAction:(CancelButtonDidCliked)cancelButtonDidClikedAction;

@end
