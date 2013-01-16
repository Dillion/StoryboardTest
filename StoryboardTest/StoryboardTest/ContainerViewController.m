/*
 
 File: ContainerViewController.m
 
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

#import "ContainerViewController.h"
#import "CustomPushSegue.h"
#import "CustomPopSegue.h"
#import "CustomPresentSegue.h"
#import "CustomDismissSegue.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

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
    UIViewController *rootViewController = [[self childViewControllers] objectAtIndex:0];
    
    NSLog(@"self.view %@ root %@", self.view, rootViewController.view);
    
    // If we break here, and po [&(rootViewController.view) recursiveDescription], we see that theres another uiview in between self.view and rootViewController.view, even though the rootViewController is the first child.
    // This is because by default in IB the child view controller has a superview in between its parent's view and itself

    rootViewController.view.superview.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// All manual segues called from code have to be run through this function
// From the child view controller, we simply message the parent the segue that we want to run
- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier compare:@"PushSegue"] == NSOrderedSame) {
        
        // we always push onto the last child view controller in the stack
        UIViewController *topViewController = [[self childViewControllers] lastObject];
        
        UIStoryboard *currentStoryboard = [UIStoryboard storyboardWithName:@"CustomContainerController" bundle:nil];
        UIViewController *pushViewController = (UIViewController *)[currentStoryboard instantiateViewControllerWithIdentifier:@"PushViewController"];
        CustomPushSegue *pushSegue = [[CustomPushSegue alloc] initWithIdentifier:@"PushSegue" source:topViewController destination:pushViewController];
        [pushSegue perform];
        
    }
    else if ([identifier compare:@"PopSegue"] == NSOrderedSame) {
    
        // If the unwinding is called manually (when there is no control to link up to Exit in storyboard), we will create and run the unwind segue here
        // The main difference between the manual call and the IB handled callback is that we don't have a direct reference to the calling view controller, unless the caller passes self in sender
        // If we have a fixed navigation stack however, or references are stored in the parent (ContainerViewController), we still have the options of returning to a previous or root child controller
        
        // Here I assume that sender is the calling view controller, and we are going back to the previous view controller in the stack
        UIViewController *fromViewController = (UIViewController *)sender;
        NSUInteger fromVCIndex = [[self childViewControllers] indexOfObjectIdenticalTo:fromViewController];
        UIViewController *previousViewController = [[self childViewControllers] objectAtIndex:fromVCIndex-1];
        
        NSLog(@"from %@ previous %@", fromViewController, previousViewController);
        CustomPopSegue *popSegue = [[CustomPopSegue alloc] initWithIdentifier:@"PopSegue" source:fromViewController destination:previousViewController];
        [popSegue perform];
    }
    else if ([identifier compare:@"PresentSegue"] == NSOrderedSame) {
        
        // presentation is done similarly as pushing
        UIViewController *topViewController = [[self childViewControllers] lastObject];
        
        UIStoryboard *currentStoryboard = [UIStoryboard storyboardWithName:@"CustomContainerController" bundle:nil];
        UIViewController *presentViewController = (UIViewController *)[currentStoryboard instantiateViewControllerWithIdentifier:@"PresentViewController"];
        CustomPresentSegue *presentSegue = [[CustomPresentSegue alloc] initWithIdentifier:@"PresentSegue" source:topViewController destination:presentViewController];
        [presentSegue perform];
    }
    else if ([identifier compare:@"DismissSegue"] == NSOrderedSame) {
        
        // dismissing is done similarly as popping
        UIViewController *fromViewController = (UIViewController *)sender;
        NSUInteger fromVCIndex = [[self childViewControllers] indexOfObjectIdenticalTo:fromViewController];
        UIViewController *previousViewController = [[self childViewControllers] objectAtIndex:fromVCIndex-1];
        
        NSLog(@"from %@ previous %@", fromViewController, previousViewController);
        CustomDismissSegue *dismissSegue = [[CustomDismissSegue alloc] initWithIdentifier:@"DismissSegue" source:fromViewController destination:previousViewController];
        [dismissSegue perform];
    }
}

# pragma mark -
# pragma mark Unwind segue

// When unwinding from IB, to control from the parent (ContainerViewController), uncomment this section

// This isn't executed, but is need to tell the system that ContainerViewController will handle any unwind segues with popUnwindSegue: action
- (IBAction)popUnwindSegue:(UIStoryboardSegue *)segue
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
    NSLog(@"segue is %@", segue);
}

// The parent needs to return a view controller for this method
// Various ways to handle this - 
// 1. Return a new view controller that you instantiate from storyboard (do this if your intent is to only have 1 child view controller at any point in time, your forward segue should also remove the previous child view controller when the new child view controller is added
// 2. Unwind to the root view controller. In this case we need to remove all view controllers in between, and call the appropriate container removal APIs
// 3. Unwind to the previous view controller in the stack
// NB: For any view controller that you return, it MUST be a child view controller. If you add it as a child here, your unwinding segue should take into account and reorder the containment API calls appropriately

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
    NSLog(@"sender is %@",sender);

////    option 1.
//    UIStoryboard *currentStoryboard = [UIStoryboard storyboardWithName:@"CustomContainerController" bundle:nil];
//    UIViewController *rootViewController = (UIViewController *)[currentStoryboard instantiateViewControllerWithIdentifier:@"RootViewController"];
//    
////    View controller to unwind to must be a child view controller at this point!!
//    [self addChildViewController:rootViewController];
    
////    option 2.
//    if ([[self childViewControllers] count] > 0) {
//        UIViewController *rootViewController = [[self childViewControllers] objectAtIndex:0];
//        if ([rootViewController isEqual:fromViewController]) {
//            NSLog(@"Source is the same as destination!!");
//            return nil;
//        } else {
//              // add in function to remove all intermediate view controllers
//            return rootViewController;
//        }
//    } else {
//        NSLog(@"No child view controllers!!");
//        return nil;
//    }
    
//    option 3.
    NSUInteger fromVCIndex = [[self childViewControllers] indexOfObjectIdenticalTo:fromViewController];
    if (fromVCIndex != NSNotFound && fromVCIndex > 0) {
        UIViewController *previousViewController = [[self childViewControllers] objectAtIndex:fromVCIndex-1];
        return previousViewController;
    } else {
        NSLog(@"No previous view controller!!");
        return nil;
    }
    
    return nil;
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
    return YES;
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    if (DEBUG_FLAG == DebugFlagAll || (DEBUG_FLAG & DebugFlagSegue) == DebugFlagSegue) {
        VC_LOG_METHOD_SEL;
    }
    if ([identifier compare:@"PopSegue"] == NSOrderedSame) {
        CustomPopSegue *popSegue = [[CustomPopSegue alloc] initWithIdentifier:@"PopSegue" source:fromViewController destination:toViewController];
        [popSegue perform];
    }
    return nil;
}

@end
