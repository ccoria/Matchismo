//
//  Card.m
//  Matchismo
//
//  Created by ccoria on 23/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "Card.h"

@interface Card();

@end

@implementation Card

@synthesize contents;
@synthesize faceUp;
@synthesize unplayable;

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            return 1;
        }
    }
    
    return score;
}

@end
