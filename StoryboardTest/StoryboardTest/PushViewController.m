/*
 
 File: PushViewController.m
 
 Copyright (c) 2013 Dillion Tan
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

@synthesize customPushButton;
@synthesize customPopButton;

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
	// Do any additional setup after loading the view.
    
    self.customPushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customPushButton.frame = CGRectMake(60, 60, 200, 60);
    [customPushButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [customPushButton setTitle:@"Push from code" forState:UIControlStateNormal];
    [self.view addSubview:customPushButton];
    
    self.customPopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customPopButton.frame = CGRectMake(60, 200, 200, 60);
    [customPopButton addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [customPopButton setTitle:@"Unwind from code" forState:UIControlStateNormal];
    [self.view addSubview:customPopButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push:(id)sender
{
    [[self parentViewController] performSegueWithIdentifier:@"PushSegue" sender:self];
}

- (void)pop:(id)sender
{
    [[self parentViewController] performSegueWithIdentifier:@"PopSegue" sender:self];
}

@end
