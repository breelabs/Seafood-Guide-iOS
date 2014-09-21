//
//  WebViewController.m
//  Oodeo
//
//  Created by Jon Brown on 8/25/14.
//  Copyright (c) 2014 Jon Brown Designs. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webTitle.title = theTitle;
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:theURL];
    [webView loadRequest:requestObject];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string {
    if( self = [super init] ) {
        theURL = url;
        theTitle = string;
    }
    return self;
}

-(id)initWithURL:(NSURL *)url {
    return [self initWithURL:url andTitle:nil];
}

- (IBAction) done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    webView.delegate = nil;
    [webView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)wv {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (error.code == NSURLErrorNotConnectedToInternet){
        NSLog(@"You are not connected");
    }
    
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%ld)", (long)error.code];
    
    UIAlertView *errorView =
    [[UIAlertView alloc] initWithTitle:errorTitle
                               message:errorString delegate:self cancelButtonTitle:nil
                     otherButtonTitles:@"OK", nil];
    [errorView show];
}
- (void)didPresentAlertView:(UIAlertView *)alertView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end
