//
//  HomeNavigationController.m
//  MyWeibo
//
//  Created by zn on 2018/11/10.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "HomeNavigationController.h"

@interface HomeNavigationController ()

@end

@implementation HomeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _homeTabItem.title = @"Home";
    
    [_homeTabItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:124/255.0 blue:3/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    _homeTabItem.image = [UIImage imageNamed:@"homepage"];
    
    UIImage *selectImage = [[UIImage imageNamed:@"homepage-highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _homeTabItem.selectedImage = selectImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
