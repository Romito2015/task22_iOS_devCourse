//
//  RSBoard.m
//  22TouchesHW
//
//  Created by Roma Chopovenko on 9/16/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import "RSBoard.h"

#define NumberOfRows 8
#define insetBoard 2

@implementation RSBoard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cellsArray    = [NSMutableArray array];
        self.checkersArray = [NSMutableArray array];
        
        CGFloat underBoardMargin = MIN(frame.size.width, frame.size.height) - 80;
        
        CGFloat underBoardOriginX = (frame.size.width  - underBoardMargin) / 2;
        CGFloat underBoardOriginY = (frame.size.height - underBoardMargin) / 2;
        
        CGRect underBoardRect = CGRectMake(underBoardOriginX, underBoardOriginY, underBoardMargin, underBoardMargin);
        self.frame = underBoardRect;
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        self.boardMargin = underBoardMargin - (2 * insetBoard);
        
        CGRect insetedRect = CGRectMake(insetBoard, insetBoard, self.boardMargin, self.boardMargin);
        UIView *board = [[UIView alloc] initWithFrame:insetedRect];
        board.backgroundColor = [UIColor whiteColor];
        [self addSubview:board];
        self.boardView = board;
        
        self.cellMargin = self.boardMargin / NumberOfRows;
        
        CGFloat cellX = 0;
        CGFloat cellY = 0;
        
        int colorNumber;
        
        for (int i = 1; i <= 64; i++) {
            
            // create black Cells
            CGRect  blackCellRect = CGRectMake(cellX, cellY, self.cellMargin, self.cellMargin);
            UIView *blackCellView = [[UIView alloc] initWithFrame:blackCellRect];
            blackCellView.backgroundColor = [UIColor blackColor];
            
            if (colorNumber % 2 != 0) {
                
                [board addSubview:blackCellView];
                [self.cellsArray addObject:blackCellView];
            }
            
            if (i % 8 == 0) {
            
                cellX  = 0;
                cellY += self.cellMargin;
            } else {

                cellX += self.cellMargin;
                cellY  = cellY;
                colorNumber ++;
            }
        }

        [self addCheckersToCells];
        int f = 0;
        int o = 0;
        for (UIView *view in self.cellsArray) {
            if (view.tag == RSTagViewFree) {
                f++;
            } else if (view.tag == RSTagViewOccupied) {
                o++;
            }
        }
  NSLog(@"Free cells: %d Occupied cells : %d", f, o);
    }
    return self;
}

- (void) addCheckersToCells {
    
    CGRect  checkerCellRect = CGRectMake(self.cellMargin / 4, self.cellMargin / 4, self.cellMargin / 2, self.cellMargin / 2);
   
    for (int i = 0; i <32; i++) {
        
        //create Checkers
        UIView *checkerCellView = [[UIView alloc] initWithFrame:checkerCellRect];
        
        checkerCellView.layer.cornerRadius = CGRectGetWidth(checkerCellView.frame) / 2;
        UIView *tempView = [self.cellsArray objectAtIndex:i];
        
        if (i < 12) {
            
            tempView.tag = RSTagViewOccupied;
            checkerCellView.backgroundColor = [UIColor redColor];
            checkerCellView.tag = RSTagViewRedChecker;
            [tempView addSubview:checkerCellView];
            [self.checkersArray addObject:checkerCellView];
            
        } else if (i > 19) {
            
            tempView.tag = RSTagViewOccupied;
            checkerCellView.backgroundColor = [UIColor greenColor];
            checkerCellView.tag = RSTagViewGreenChecker;
            [tempView addSubview:checkerCellView];
            [self.checkersArray addObject:checkerCellView];
        } else {
            tempView.tag = RSTagViewFree;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
