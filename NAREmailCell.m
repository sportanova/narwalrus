//
//  NAREmailCell.m
//  narwalrus
//
//  Created by Stephen Portanova on 8/13/14.
//  Copyright (c) 2014 sportanova. All rights reserved.
//

#import "NAREmailCell.h"


@implementation NAREmailCell

- (void)configureCellWithHtmlBody:(NSString *)htmlBody textBody:(NSString *)textBody sender:(NSDictionary *)sender
{
  UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] init];
  [doubleTap setNumberOfTapsRequired:2];
  [doubleTap setDelegate:self];
  [doubleTap addTarget:self action:@selector(handleDoubleTap:)];
  [self.webView addGestureRecognizer:doubleTap];
  
//  NSLog(@"HTML BODY %@", htmlBody);
//  NSLog(@"TEXT BODY %@", textBody);
  
//  NSString *html = [NSString stringWithFormat:@"%@ %@", @"<meta name='viewport' content='width=320,user-scalable=yes,initial-scale=1.0'>", body];
  NSMutableString *body = nil;
  
  if([htmlBody  isEqual: @""]) {
    body = [textBody mutableCopy];
  }
  else {
    body = [htmlBody mutableCopy];
  }

  [self.webView loadHTMLString:body baseURL:nil]; // <meta name="viewport" content="width=320,user-scalable=yes,initial-scale=1.0"> http://stackoverflow.com/questions/14181543/obj-c-uiwebview-responsive-html  <meta name="viewport" content="width=device-width, initial-scale=1"> goes in head tag
  self.webView.delegate = self;
  
  NSLog(@"sender %@", sender);
  
  NSMutableString *senderString = nil;

  for (id key in sender) {
     senderString = key;
  }
  
  self.senderLabel.text = senderString;
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//  webView.scalesPageToFit = YES; // makes text way too small, but responsive emails work way better
  return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView // finds full email size so it can be expanded on double tap
{
  CGSize size = CGSizeMake(webView.scrollView.contentSize.width,[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue]);

  webView.scrollView.scrollEnabled = false;
//  webView.scalesPageToFit = TRUE; // makes text way too small, but responsive emails work way better
  
  self.email.fullSize = size.height;
}

@end
