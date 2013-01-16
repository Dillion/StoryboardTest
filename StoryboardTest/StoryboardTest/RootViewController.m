/*
 
 File: RootViewController.m
 
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

#import "RootViewController.h"
#import "CustomPopSegue.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize customPushButton;
@synthesize customPresentButton;

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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.customPushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customPushButton.frame = CGRectMake(60, 60, 200, 60);
    [customPushButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [customPushButton setTitle:@"Push from code" forState:UIControlStateNormal];
    [self.view addSubview:customPushButton];
    
    self.customPresentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customPresentButton.frame = CGRectMake(60, 200, 200, 60);
    [customPresentButton addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [customPresentButton setTitle:@"Present" forState:UIControlStateNormal];
    [self.view addSubview:customPresentButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)push:(id)sender
{
    [[self parentViewController] performSegueWithIdentifier:@"PushSegue" sender:self];
}

- (void)present:(id)sender
{
    [[self parentViewController] performSegueWithIdentifier:@"PresentSegue" sender:self];
}

// If unwinding is not handled by the parent, the children will be searched for matching unwinding action
// If the child handles the unwinding, we can run the segue directly within the IBAction callback
// prepareForSegue: will be called, then popUnwindSegue:
- (IBAction)popUnwindSegue:(UIStoryboardSegue *)segue
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
    NSLog(@"segue %@", segue);
    
    CustomPopSegue *newSegue = [[CustomPopSegue alloc] initWithIdentifier:@"PopSegue" source:segue.sourceViewController destination:segue.destinationViewController];
    [newSegue perform];
}

@end
