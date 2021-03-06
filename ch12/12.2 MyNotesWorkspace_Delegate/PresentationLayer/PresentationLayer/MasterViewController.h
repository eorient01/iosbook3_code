//
//  MasterViewController.h
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook3.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"
#import "NoteBLDelegate.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NoteBLDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;
//删除数据索引
@property (nonatomic,assign) NSUInteger deletedIndex;
//删除数据
@property (nonatomic,strong) Note *deletedNote;

//BL对象
@property (nonatomic,strong) NoteBL *bl;

@end
