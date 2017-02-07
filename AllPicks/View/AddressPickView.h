//
//  AddressPickView.h
//  AllPicks
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AdressBlock) (NSString *province,NSString *city,NSString *town);

@interface AddressPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,copy)AdressBlock block;


+ (instancetype)shareInstance;


@end

