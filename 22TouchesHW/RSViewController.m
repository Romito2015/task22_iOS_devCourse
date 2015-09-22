//
//  RSViewController.m
//  22TouchesHW
//
//  Created by Roma Chopovenko on 9/14/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSViewController.h"
#import "RSBoard.h"

@interface RSViewController ()

@property (weak, nonatomic) RSBoard *checkersBoard;
@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    RSBoard *board = [[RSBoard alloc] initWithFrame:self.view.bounds];
    self.checkersBoard = board;
    
    if (board) {
        [self.view addSubview:board];
    }
    
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"BEGANtouch"];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint pointOnBoardView = [touch locationInView:self.checkersBoard];

    UIView *view = [self.checkersBoard hitTest:pointOnBoardView withEvent:event];
    

    if (![view isEqual:self.checkersBoard] &&
        ![view isEqual:self.checkersBoard.boardView] &&
                        view.tag != RSTagViewOccupied &&
                        view.tag != RSTagViewFree) {
        
        self.draggingView = view;
        
        [self.checkersBoard bringSubviewToFront:self.draggingView];
        
        CGPoint touchPoint = [touch locationInView:self.draggingView];
    
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.draggingView.alpha = 0.5f;
            
        }];
        
        
    } else {
        self.draggingView = nil;
    }
    
    //NSLog(@"inside %d", [self.draggingView pointInside:point withEvent:event]);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"MOVEtouch"];
    
    UITouch *touch = [touches anyObject];
    
    
    if (self.draggingView) {
        CGPoint pointOnMainView = [touch locationInView:self.checkersBoard];
        
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);
        
        NSLog(@"MOVEcorrection before %@", NSStringFromCGPoint(correction));
        
        //correction = [self.checkersBoard convertPoint:correction toView:self.view];
        self.draggingView.center = correction;
     
    }
    
}

- (void) onTouchesEnded {
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.draggingView.transform = CGAffineTransformIdentity;
        self.draggingView.alpha = 1.f;
        
    }];
self.draggingView = nil;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
   //[self logTouches:touches withMethod:@"touchesEnded"];
    [self onTouchesEnded];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self logTouches:touches withMethod:@"touchesCancelled"];
    [self onTouchesEnded];
    
}


- (void) logTouches:(NSSet*)touches withMethod:(NSString*) methodName {
    
    NSMutableString* string = [NSMutableString stringWithString:methodName];
    
    for (UITouch* touch in touches) {
        CGPoint point = [touch locationInView:self.checkersBoard];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}

-(UIColor *) getRandomRGB {
    
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    return color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
