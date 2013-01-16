/*
 
 File: CustomPopSegue.m
 
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

#import "CustomPopSegue.h"

@implementation CustomPopSegue

// Regardless of where the source is in the overall app view hierarchy (i.e. managed by a navigation controller), we don't mix with the view controllers outside of the source's parent. The source's parent (ContainerViewController) manages all pushing/popping/presenting from within its root, just like how a navigation controller manages its children

// If our concept of a container is to have a single child view controller at any point in time, we remove the outgoing view controller in the forward segue and add back the incoming controller in the dismissing segue (uncomment the lines with **)
// Otherwise we keep the outgoing child view controller in memory and reference it again from the parent whenever we want to unwind
- (void)perform {
    
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *dest = (UIViewController *)self.destinationViewController;
    
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        NSLog(@"%@:%s from %@ to %@", self, (char *)_cmd, self.sourceViewController, self.destinationViewController);
    }
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagFrame) == DebugFlagFrame) {
        VC_LOG_BOUNDS_AND_FRAME(source);
        VC_LOG_BOUNDS_AND_FRAME(dest);
    }
    
    [source willMoveToParentViewController:nil];
//    [[source parentViewController] addChildViewController:dest];  //**
    [source beginAppearanceTransition:YES animated:YES];
    [dest beginAppearanceTransition:YES animated:YES];
//    [[source parentViewController].view addSubview:dest.view];    //**
    
    // Before we run the transition we have to adjust the frame of the children by looking at the bounds
    CGRect sourceBounds = source.view.bounds;
    sourceBounds.origin.x = 0;
    source.view.frame = sourceBounds;
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        
        CGRect newSourceRect = CGRectMake(sourceBounds.origin.x + sourceBounds.size.width, sourceBounds.origin.y, sourceBounds.size.width, sourceBounds.size.height);
        source.view.frame = newSourceRect;
        
        dest.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [dest endAppearanceTransition];
        [source endAppearanceTransition];
//        [dest didMoveToParentViewController:[source parentViewController]];   //**
        [source.view removeFromSuperview];
        [source removeFromParentViewController];
        
        if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagFrame) == DebugFlagFrame) {
            VC_LOG_BOUNDS_AND_FRAME(source);
            VC_LOG_BOUNDS_AND_FRAME(dest);
        }
        
    }];
}

@end
