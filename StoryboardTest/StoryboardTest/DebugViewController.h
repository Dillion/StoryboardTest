/*
 
 File: DebugViewController.h
 
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

#import <UIKit/UIKit.h>

typedef enum {
    DebugFlagAll            = 1 <<  0,
    DebugFlagInit           = 1 <<  1,
    DebugFlagLoad           = 1 <<  2,
    DebugFlagAppear         = 1 <<  3,
    DebugFlagSegue          = 1 <<  4,
    DebugFlagRelease        = 1 <<  5,
    DebugFlagFrame          = 1 <<  6,
} DebugFlag;

#define DEBUG_FLAG DebugFlagAll
#define VC_LOG_METHOD_SEL NSLog(@"%@:%s",self,(char *)_cmd)
#define VC_LOG_BOUNDS_AND_FRAME(vc) NSLog(@"%@:bounds %@ frame %@", vc, NSStringFromCGRect(vc.view.bounds), NSStringFromCGRect(vc.view.frame))

@interface DebugViewController : UIViewController

@end
