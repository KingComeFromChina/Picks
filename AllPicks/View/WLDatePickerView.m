//
//  WLDatePickerView.m
//  NewAppNotice
//
//  Created by 王垒 on 2016/10/18.
//  Copyright © 2016年 King. All rights reserved.
//

#import "WLDatePickerView.h"




#define WLWindowWidth ([[UIScreen mainScreen] bounds].size.width)
#define WLWindowHeight ([[UIScreen mainScreen] bounds].size.height)
#define customeColor(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]




@interface WLDatePickerView ()<UIPickerViewDelegate>

@property (nonatomic,retain)UIButton * doneButton;
@property (nonatomic,retain)UIButton * cancelButton;
@property (nonatomic,retain)UIDatePicker * datePickerView;
@property (nonatomic,retain)UIView * backView;
@property (nonatomic,retain)UIView * topBackView;
@property (nonatomic,assign)CGFloat bottonWidth;
@property (nonatomic,assign)CGFloat bottonHeight;


@end


@implementation WLDatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.bottonWidth = 80;
        self.bottonHeight = 40;
        [self createView:frame];

    }
    return self;
}
- (void)createView:(CGRect)frame{
    [self createBackView];
    [self createTopBackView];
    [self createTopButton];
    [self createDatePickerView];
    [self createBackGesture];
}

- (void)createBackGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [self  addGestureRecognizer:tap];
}

- (void)createDatePickerView{
    self.datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.bottonHeight,self.backView.frame.size.width, self.backView.frame.size.height - self.bottonHeight)];
//    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    [self.datePickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [self.backView addSubview:self.datePickerView];
}

- (void)createTopButton{
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];//UIButton(type: UIButtonType.Custom)
    self.doneButton.frame = CGRectMake(10, 0, self.bottonWidth, self.bottonHeight);
    self.doneButton.backgroundColor = [UIColor clearColor];
    [self.doneButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.doneButton setTitle:@"done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.topBackView addSubview:self.doneButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(self.frame.size.width - self.bottonWidth - 10, 0, self.bottonWidth, self.bottonHeight);
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(doneButtonDidCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.topBackView addSubview:self.cancelButton];
}
- (void)createTopBackView{
    self.topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WLWindowWidth, self.bottonHeight)];
    self.topBackView.backgroundColor = customeColor(210, 210, 210, 1);
    [self.backView addSubview:self.topBackView];
}
- (void)createBackView{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, WLWindowHeight, self.frame.size.width,300)];
    self.backView.backgroundColor = customeColor(242, 242, 242, 1);
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80.f;
}

- (void)setTime:(NSInteger)before after:(NSInteger)after{
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval interval = 12 * 60 ;
    NSString *titleString = [dateFormatter stringFromDate:[date initWithTimeInterval:interval sinceDate:date]];
    NSDate *minDate=[dateFormatter dateFromString:titleString];

    self.datePickerView.minimumDate = minDate;
    NSTimeInterval maxInter =60*60*24*30;
    NSString *masString=[dateFormatter stringFromDate:[date initWithTimeInterval:maxInter sinceDate:date]];
    NSDate *maxDate=[dateFormatter dateFromString:masString];
    self.datePickerView.maximumDate = maxDate;
}

- (void)buttonTitleChange:(NSString *)cancelTitle Done:(NSString *)done{
    [self.cancelButton setTitle:done forState:UIControlStateNormal];
    [self.doneButton setTitle:cancelTitle forState:UIControlStateNormal];
}

- (void)show:(NSInteger)before after:(NSInteger)after cancelButton:(NSString *)cancelButton doneButton:(NSString *)doneButton cancelButtonDidClikedAction:(CancelButtonDidCliked)cancelButtonDidClikedAction{
    self.cancelButtonDidCliked = cancelButtonDidClikedAction;
    [self setTime:before after:after];
    [self buttonTitleChange:cancelButton Done:doneButton];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window addSubview:self.backView];
    [UIView animateWithDuration:0.01 animations:^{
        self.backgroundColor = customeColor(0, 0, 0, 0.5);
    } completion:^(BOOL finished) {
        self.backView.frame = CGRectMake(0, self.frame.size.height -300, self.frame.size.width, 300);
    }];
    
}


- (void)doneButtonDidCliked{
    if (self.cancelButtonDidCliked) {
        self.cancelButtonDidCliked(self.datePickerView.date);
        [self close];
    }
}
- (void)close{
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, WLWindowHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = customeColor(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
}
@end
