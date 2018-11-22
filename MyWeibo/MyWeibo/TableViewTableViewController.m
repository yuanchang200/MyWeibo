//
//  TableViewTableViewController.m
//  MyWeibo
//
//  Created by zn on 2018/11/8.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TableViewTableViewController.h"
#import "TableCellTableViewCell.h"
#import "postItem.h"
#import "commentItem.h"
#import "likeItem.h"
#import "DetailedViewController.h"
//#import "DetailTableViewController.h"
#define UI_SCREEN_WIDTH 300

@interface TableViewTableViewController ()

@end

@implementation TableViewTableViewController

NSInteger column_t = 0;
NSInteger row_t = 0;
CGFloat imageWidth_t;
CGFloat leadingSpace_t = 8;
CGFloat imageSpace_t = 4;
CGFloat originY_t;
CGFloat contentLabelOriginY_t = 50;
CGFloat bottomButtonHeight = 20;

//load posts from posts.plist
-(NSArray *)posts{
    if(_posts == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"posts" ofType:@"plist"];
        NSArray *postsArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dic in postsArray){
            postItem *item = [postItem initPostItem:dic];
            [tmpArray addObject:item];
        }
        _posts = tmpArray;
    }
    return _posts;
}
//load comments from comments.plist
-(NSArray *)comments{
    if(_comments == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"comments" ofType:@"plist"];
        NSArray *commentsArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmpArray1 = [NSMutableArray array];
        for (NSArray *arr in commentsArray){
            NSMutableArray *tmpArray2 = [NSMutableArray array];
            for (NSDictionary *dic in arr){
                commentItem *item = [commentItem initCommentItem:dic];
                [tmpArray2 addObject:item];
            }
            [tmpArray1 addObject:tmpArray2];
        }
        _comments = tmpArray1;
    }
    return _comments;
}

//load reposts from reposts.plist
- (NSArray *)reposts{
    if(_reposts == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"reposts" ofType:@"plist"];
        NSArray *repostsArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmpArray1 = [NSMutableArray array];
        for(NSArray *arr in repostsArray){
            NSMutableArray *tmpArray2 = [NSMutableArray array];
            for(NSDictionary *dic in arr){
                commentItem *item = [commentItem initCommentItem:dic];
                [tmpArray2 addObject:item];
            }
            [tmpArray1 addObject:tmpArray2];
        }
        _reposts = tmpArray1;
    }
    return _reposts;
}
//load likes from likes.plist
- (NSArray *)likes{
    if(_likes == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"likes" ofType:@"plist"];
        NSArray *likesArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmpArray1 = [NSMutableArray array];
        for(NSArray *arr in likesArray){
            NSMutableArray *tmpArray2 = [NSMutableArray array];
            for(NSDictionary *dic in arr){
                likeItem *item = [likeItem initLikeItem:dic];
                [tmpArray2 addObject:item];
            }
            [tmpArray1 addObject:tmpArray2];
        }
        _likes = tmpArray1;
    }
    return _likes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"All Following";
    
    NSString *cellID = @"cellID";
    [_homeTableView registerNib:[UINib nibWithNibName:@"TableCellTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.sectionFooterHeight = 1.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    TableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    postItem *item = self.posts[indexPath.section];
    cell.singlePostItem = item;
    cell.reposts = self.reposts[indexPath.section];
    cell.comments = self.comments[indexPath.section];
    cell.likes = self.likes[indexPath.section];
    
    CGFloat contentHeight = [TableCellTableViewCell getLabelHeightWithText:cell.singlePostItem.content Width:UI_SCREEN_WIDTH - leadingSpace_t * 2 Font:[UIFont systemFontOfSize:15]];
    originY_t = contentLabelOriginY_t + contentHeight + leadingSpace_t;
    if (cell.singlePostItem.postImgs.count == 1){
        column_t = 1;
        imageWidth_t = UI_SCREEN_WIDTH * 0.55;
    }else if (cell.singlePostItem.postImgs.count == 2 || cell.singlePostItem.postImgs.count == 4){
        column_t = 2;
        imageWidth_t = (UI_SCREEN_WIDTH - (leadingSpace_t + imageSpace_t) * 2) / 3;
    }else {
        column_t = 3;
        imageWidth_t = (UI_SCREEN_WIDTH - (leadingSpace_t + imageSpace_t) * 2) / 3;
    }
    if(column_t != 0){
        if(cell.singlePostItem.postImgs.count % column_t == 0){
            row_t = cell.singlePostItem.postImgs.count / column_t;
        }else{
            row_t = cell.singlePostItem.postImgs.count / column_t + 1;
        }
    }
    
    CGRect rect = cell.frame;
    rect.size.height = originY_t + row_t * (imageWidth_t + imageSpace_t) + leadingSpace_t + bottomButtonHeight + 20;
    cell.frame = rect;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.posts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailedViewController *dViewController = [DetailedViewController alloc];
    dViewController.post = self.posts[indexPath.section];
    dViewController.comments = self.comments[indexPath.section];
    dViewController.reposts = self.reposts[indexPath.section];
    dViewController.likes = self.likes[indexPath.section];
    dViewController.tag = 0;
    [self.navigationController pushViewController:dViewController animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
