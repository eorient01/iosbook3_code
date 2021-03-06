//
//  ViewController.m
//  HTTPQueue
//
//  Created by 关东升 on 12-12-21.
//  Copyright (c) 2012年 516inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onClick:(id)sender {
    
    if (!_networkQueue) {
        _networkQueue = [[ASINetworkQueue alloc] init];
    }
    
    // 停止以前的队列
	[_networkQueue cancelAllOperations];
	
	// 创建ASI队列
	[_networkQueue setDelegate:self];
	[_networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
	[_networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[_networkQueue setQueueDidFinishSelector:@selector(queueFinished:)];

	for (int i=1; i<3; i++) {
	    NSString *strURL = [[NSString alloc] initWithFormat:@"http://iosbook3.com/service/download.php?email=%@&FileName=test%i.jpg",@"<你的iosbook3.com用户邮箱>",i];
        NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        request.tag = i;
		[_networkQueue addOperation:request];
	}
    
	[_networkQueue go];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    NSError *eror;
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&eror];
    
    if (!resDict) {
        UIImage *img = [UIImage imageWithData:data];
        if (request.tag ==1) {
            _imageView1.image = img;
        } else {
            _imageView2.image = img;
        }
    } else {
        NSNumber *resultCodeObj = [resDict objectForKey:@"ResultCode"];
        
        NSString *errorStr = [resultCodeObj errorMessage];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
    if ([_networkQueue requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
    NSLog(@"请求成功");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",[error localizedDescription]);
    if ([_networkQueue requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
    NSLog(@"请求失败");
}


- (void)queueFinished:(ASIHTTPRequest *)request
{
	if ([_networkQueue requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
    NSLog(@"队列完成");
}


@end
