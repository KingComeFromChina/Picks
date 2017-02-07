//
//  FirstAddressPickViewController.m
//  AllPicks
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "FirstAddressPickViewController.h"
#import "AddressPickView.h"

@interface FirstAddressPickViewController ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, copy) NSString *userCity;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *town;
@property (nonatomic, copy) NSString *addressText;

@end

@implementation FirstAddressPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"地点选择器";
    
}

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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
