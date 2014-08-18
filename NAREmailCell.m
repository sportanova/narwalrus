//
//  NAREmailCell.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailCell.h"


@implementation NAREmailCell

- (void)configureCellWithBody:(NSString *)body sender:(NSString *)sender
{
  UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] init];
  [doubleTap setNumberOfTapsRequired:2];
  [doubleTap setDelegate:self];
  [doubleTap addTarget:self action:@selector(handleDoubleTap:)];
  [self.webView addGestureRecognizer:doubleTap];

  [self.webView loadHTMLString:body baseURL:nil];
  self.webView.delegate = self;
  
  self.senderLabel.text = sender;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
  if (sender.state == UIGestureRecognizerStateEnded) {
    id<EmailCellDelegate> strongDelegate = self.delegate;
    id<EmailCellDelegate> strongEmailDelegate = self.emailDelegate;
    
    double oldTime = self.delegate.getLastResizeTime;
    double newTime = CACurrentMediaTime();
    [self.delegate setLastResizeTime:newTime];
    double timeDiff = newTime - oldTime;
    
    if(timeDiff < .02) {}
    else {
      if ([strongDelegate respondsToSelector:@selector(refreshTable)]) {
        [strongEmailDelegate flipFullSize];
        [strongDelegate refreshTable];
      }
    }
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
  
//  NSLog(@"FINISHED LOADING: %f", size.height);
  self.email.fullSize = size.height;
}

@end
