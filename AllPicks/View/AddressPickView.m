//
//  AddressPickView.m
//  AllPicks
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "AddressPickView.h"
#import "UIViewExt.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 240.0f
#define buttonWidth 80.0f
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

#define WLWindowWidth [UIScreen mainScreen].bounds.size.width
#define WLWindowHeight [UIScreen mainScreen].bounds.size.height


@interface AddressPickView ()

@property(nonatomic,strong)NSDictionary *pickerDic;
@property(nonatomic,strong)NSArray *provinceArray;
@property(nonatomic,strong)NSArray *selectedArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *townArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, assign) int level;

@end

@implementation AddressPickView
+ (instancetype)shareInstance{
    
    static AddressPickView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AddressPickView alloc] init];
    });
    
    [shareInstance showBottomView];
    return shareInstance;
    
}
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, WLWindowWidth, WLWindowHeight);
        [self addTapGestureRecognizerToSelf];
        self.parentId = @"100000";
        self.level = 1;
        [self getPickerData];
       
        [self createView];
    }
    return self;
    
}
#pragma mark - get data
- (void)getPickerData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}


- (void)addTapGestureRecognizerToSelf{
   
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
    
}
- (void)createView{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, WLWindowHeight, WLWindowWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, WLWindowWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    
    NSArray *buttonTitleArray = @[@"取消",@"地址选择",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(WLWindowWidth-buttonWidth)/2, 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight+65, WLWindowWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
    
    
}
-(void)tapButton:(UIButton*)button{
    
    //点击确定回调block
    if (button.tag == 2) {
        
        NSString *province = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
        NSString *city = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
        NSString *town = [self.townArray objectAtIndex:[_pickView selectedRowInComponent:2]];
        
        _block(province,city,town);
    }
    
    [self hiddenBottomView];
    
    
}
-(void)showBottomView{
    
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = WLWindowHeight - navigationViewHeight -pickViewViewHeight-64;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hiddenBottomView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = WLWindowHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _provinceArray.count;
    } else if (component == 1) {
        return _cityArray.count;
    } else {
        return _townArray.count;
    }
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16.0f];
    if (component == 0) {
        lable.text=[self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        lable.text=[self.cityArray objectAtIndex:row];
    } else {
        lable.text=[self.townArray objectAtIndex:row];
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = WLWindowWidth/3;
    
    return pickViewWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
    
    
}


@end
