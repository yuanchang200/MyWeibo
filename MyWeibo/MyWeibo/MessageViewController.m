//
//  MessageViewController.m
//  MyWeibo
//
//  Created by zn on 2018/11/21.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _messageTabBarItem.title = @"Message";
    
    [_messageTabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:124/255.0 blue:3/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    _messageTabBarItem.image = [UIImage imageNamed:@"message"];
    
    UIImage *selectImage = [[UIImage imageNamed:@"message-highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _messageTabBarItem.selectedImage = selectImage;
    
    
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 200, 200, 20)];
    [moreLabel setText:@"More to come!"];
    [moreLabel setTextColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0]];
    moreLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:moreLabel];
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
