//
//  ViewController.m
//  AllPicks
//
//  Created by 王垒 on 2017/2/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "ViewController.h"
#import "FirstAddressPickViewController.h"
#import "FirstDatePickerViewController.h"

#define WLWindowWidth ([[UIScreen mainScreen] bounds].size.width)
#define WLWindowHeight ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ViewController

+ (void)initialize{

    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor redColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]
                                            }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择器";
    [self creatData];
    [self creatTableView];
    
}

- (void)creatData{

    self.dataArray = [NSArray arrayWithObjects:@"时间选择器",@"地点选择器",nil];
    
}

- (void)creatTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WLWindowWidth, WLWindowHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        FirstDatePickerViewController *vc = [[FirstDatePickerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        FirstAddressPickViewController *vc = [[FirstAddressPickViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
