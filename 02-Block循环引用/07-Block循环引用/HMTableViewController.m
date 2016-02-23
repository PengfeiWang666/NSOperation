//
//  HMTableViewController.m
//  07-Block循环引用
//
//  Created by HM on 16/1/25.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMTableViewController.h"
#import "HMViewController.h"

@interface HMTableViewController ()

@end

@implementation HMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转控制器!
    HMViewController *vc = [[HMViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    
    
    return cell;
}
@end
