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

- (void)refreshTable {
  id<EmailCellDelegate> strongDelegate = self.delegate;
  
  // Our delegate method is optional, so we should
  // check that the delegate implements it
  if ([strongDelegate respondsToSelector:@selector(refreshTable)]) {
    [strongDelegate refreshTable];
  }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
//  NSLog(@"TAP!!!"); // why would this throw an error... threads?
  if (sender.state == UIGestureRecognizerStateEnded) {
    // sometimes there's a ghost event that does makes it go 2ce??
    self.email.isFullSize = !self.email.isFullSize;

    [self refreshTable];
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

  webView.scrollView.scrollEnabled = false;
//  webView.scalesPageToFit = TRUE;
  
  NSLog(@"FINISHED LOADING: %f", size.height);
  self.email.fullSize = size.height;
}

@end
