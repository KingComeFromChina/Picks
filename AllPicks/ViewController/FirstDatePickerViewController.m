//
//  FirstDatePickerViewController.m
//  AllPicks
//
//  Created by 王垒 on 2017/2/7.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "FirstDatePickerViewController.h"
#import "WLDatePickerView.h"

@interface FirstDatePickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FirstDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"时间选择器";
}

- (IBAction)timeBtnClick:(id)sender {
    
    WLDatePickerView * datePicker = [[WLDatePickerView alloc]initWithFrame:self.view.bounds];
    __weak typeof(self)weakself = self;
    [datePicker show:1 after:0 cancelButton:@"取消" doneButton:@"完成"  cancelButtonDidClikedAction:^(NSDate *date) {
        NSDateFormatter * format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"  yyyy-MM-dd HH:mm"];
        NSString * timeStr = [format stringFromDate:date];
        weakself.timeLabel.text = timeStr;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
