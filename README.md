##废话不多说，开整
##[Picker](http://www.jianshu.com/p/a7d02e535084)
###时间选择器
```
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

```
###地点选择器
```
- (IBAction)selectAdress:(id)sender {
[self.view endEditing:YES];
AddressPickView *addressPickView = [AddressPickView shareInstance];
[self.view addSubview:addressPickView];
addressPickView.block = ^(NSString *province,NSString *city,NSString *town){

//UITextField *cityTf = [self.view viewWithTag:702];

_province = province;
_city = city;
_town = town;
_userCity = [NSString stringWithFormat:@"%@,%@,%@",province,city,town];

self.addressLabel.text = _userCity;
self.addressLabel.textColor = [UIColor blackColor];
};

}
```

##[Clone](https://github.com/KingComeFromChina/Picks.git)
`git clone https://github.com/KingComeFromChina/Picks.git`
##Use
已经封装好，Clone下来后，直接把WLDatePickerView和AddressPickView拉入项目中
##Picture

![时间选择器](http://upload-images.jianshu.io/upload_images/3873966-926cd5983abf5e07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![时间](http://upload-images.jianshu.io/upload_images/3873966-8f9d3fa981b4edc2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![地点选择器](http://upload-images.jianshu.io/upload_images/3873966-da414e65fd1466fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![地点](http://upload-images.jianshu.io/upload_images/3873966-65820a6a93e6f2be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
