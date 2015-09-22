//
//  RSBoard.h
//  22TouchesHW
//
//  Created by Roma Chopovenko on 9/16/15.
//  Copyright (c) 2015 RSChopovenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    RSTagViewRedChecker   = 0,
    RSTagViewGreenChecker = 1,
    RSTagViewOccupied     = 2,
    RSTagViewFree         = 3
    
} RSTagView ;

@interface RSBoard : UIView

@property (assign, nonatomic) CGFloat boardMargin;
@property (assign, nonatomic) CGFloat cellMargin;

@property (strong, nonatomic) NSMutableArray *cellsArray;
@property (strong, nonatomic) NSMutableArray *checkersArray;
@property (weak, nonatomic) UIView *boardView;


@end
