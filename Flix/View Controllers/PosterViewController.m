//
//  PosterViewController.m
//  Flix
//
//  Created by meganyu on 6/26/20.
//  Copyright © 2020 meganyu. All rights reserved.
//

#import "PosterViewController.h"
#import <WebKit/WebKit.h>

@interface PosterViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *posterWebView;

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:self.posterURL
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    // Load Request into WebView.
    [self.posterWebView loadRequest:request];
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
