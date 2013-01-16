/*
 
 File: DebugViewController.m
 
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

#import "DebugViewController.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagInit) == DebugFlagInit) {
            VC_LOG_METHOD_SEL;
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagInit) == DebugFlagInit) {
            VC_LOG_METHOD_SEL;
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagInit) == DebugFlagInit) {
            VC_LOG_METHOD_SEL;
        }
        // if view is in nib/storyboard, it is being unarchived and doesn't exist at this point
    }
    return self;
}

- (void)awakeFromNib
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagInit) == DebugFlagInit) {
        VC_LOG_METHOD_SEL;
    }
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    if (self) {
        if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagInit) == DebugFlagInit) {
            VC_LOG_METHOD_SEL;
        }
    }
    return self;
}

- (void)loadView
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagLoad) == DebugFlagLoad) {
        VC_LOG_METHOD_SEL;
    }
    [super loadView];
}

- (void)viewDidLoad
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagLoad) == DebugFlagLoad) {
        VC_LOG_METHOD_SEL;
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super viewDidLayoutSubviews];
}

- (void)updateViewConstraints
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagAppear) == DebugFlagAppear) {
        VC_LOG_METHOD_SEL;
    }
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagRelease) == DebugFlagRelease) {
        VC_LOG_METHOD_SEL;
    }
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagRelease) == DebugFlagRelease) {
        VC_LOG_METHOD_SEL;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
}

@end
