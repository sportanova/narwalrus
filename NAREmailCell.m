//
//  NAREmailCell.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailCell.h"

@implementation NAREmailCell

- (void)configureCellWithBody:(NSString *)body
{
  UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] init];
  [doubleTap setNumberOfTapsRequired:2];
  [doubleTap setDelegate:self];
  [doubleTap addTarget:self action:@selector(handleDoubleTap:)];
  [self.webView addGestureRecognizer:doubleTap];

  [self.webView loadHTMLString:body baseURL:nil];
  self.webView.delegate = self;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
  if (sender.state == UIGestureRecognizerStateEnded) {
    self.email.isFullSize = !self.email.isFullSize;
    NSLog(@"isFullSize: %d", self.email.isFullSize);
    [self.emailTableView reloadData];
  }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  CGSize size = CGSizeMake(webView.scrollView.contentSize.width,[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]);
  
//  NSLog(@"FINISHED LOADING: %f", size.height);
  self.email.fullSize = size.height;
}

@end
