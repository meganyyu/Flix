//
//  TrailerViewController.m
//  Flix
//
//  Created by meganyu on 6/25/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *trailerWebView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSURL *testURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=GD4rT3GDlEI"];
    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:self.trailerURL
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    // Load Request into WebView.
    [self.trailerWebView loadRequest:request];
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
