//
//  DetailTableViewController.m
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailedPostTableViewCell.h"
#import "CommentTableViewCell.h"
#import "TableCellTableViewCell.h"
#import "DetailedBottomTableViewCell.h"
#define UI_SCREEN_WIDTH 300

NSInteger column_d = 0;
NSInteger row_d = 0;
CGFloat imageWidth_d;
CGFloat leadingSpace_d = 8;
CGFloat imageSpace_d = 4;
CGFloat originY_d;
CGFloat contentLabelOriginY_d = 50;

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *cellID1 = @"cellID1";
    NSString *cellID2 = @"cellID2";
    NSString *cellID3 = @"cellID3";
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailedPostTableViewCell" bundle:nil] forCellReuseIdentifier:cellID1];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:cellID2];
    //[self.tableView registerNib:[UINib nibWithNibName:@"DetailedBottomTableViewCell" bundle:nil] forCellReuseIdentifier:cellID3];
    [self.tableView registerClass:[DetailedBottomTableViewCell class] forCellReuseIdentifier:cellID3];
    self.tableView.sectionFooterHeight = 1.0;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section == 0) {
        DetailedPostTableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
        postCell.singlePostItem = self.post;
        
        CGFloat contentHeight = [TableCellTableViewCell getLabelHeightWithText:postCell.singlePostItem.content Width:UI_SCREEN_WIDTH - leadingSpace_d * 2 Font:[UIFont systemFontOfSize:15]];
        
        originY_d = contentLabelOriginY_d + contentHeight + leadingSpace_d;
        if (postCell.singlePostItem.postImgs.count == 1){
            column_d = 1;
            imageWidth_d = UI_SCREEN_WIDTH;
        }else if (postCell.singlePostItem.postImgs.count == 2 || postCell.singlePostItem.postImgs.count == 4){
            column_d = 2;
            imageWidth_d = (UI_SCREEN_WIDTH - (leadingSpace_d + imageSpace_d) * 2) / 2;
        }else {
            column_d = 3;
            imageWidth_d = (UI_SCREEN_WIDTH - (leadingSpace_d + imageSpace_d) * 2) / 3;
        }
        if(column_d != 0){
            if(postCell.singlePostItem.postImgs.count % column_d == 0){
                row_d = postCell.singlePostItem.postImgs.count / column_d;
            }else{
                row_d = postCell.singlePostItem.postImgs.count / column_d + 1;
            }
        }
        
        CGRect rect = postCell.frame;
        rect.size.height = originY_d + row_d * (imageWidth_d + imageSpace_d) + leadingSpace_d + 5;
        postCell.frame = rect;
        
        return postCell;
    }
    /*CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"cellID2"];
    commentCell.singleCommentItem = self.comments[0];
    
    CGFloat contentHeight = [CommentTableViewCell getLabelHeightWithText:commentCell.singleCommentItem.content Width:UI_SCREEN_WIDTH - leadingSpace_d * 2 Font:[UIFont systemFontOfSize:14]];
    
    originY_d = contentLabelOriginY_d + contentHeight + leadingSpace_d;
    CGRect rect = commentCell.frame;
    rect.size.height = originY_d;
    commentCell.frame = rect;
    
    return commentCell;*/
    
    DetailedBottomTableViewCell *detailedBottomCell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
    detailedBottomCell.comments = self.comments;
    return detailedBottomCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
