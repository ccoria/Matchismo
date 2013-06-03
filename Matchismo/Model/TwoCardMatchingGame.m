//
//  TwoCardMatchingGame.m
//  Matchismo
//
//  Created by ccoria on 24/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "TwoCardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@end

@implementation TwoCardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@synthesize status;

- (void)flipCardAtIndex:(NSUInteger)integer
{
    NSLog(@"Flipping two card");
    
    Card *card = [self cardAtIndex:integer];
    
    if (card && !card.isUnplayable && !card.isFaceUp) {
        for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable){
                int matchScore = [card match:@[otherCard]];
                
                //NSLog(@"%@",[NSString stringWithFormat:@"score: %d", matchScore]);
                if (matchScore){
                    card.unplayable = YES;
                    otherCard.unplayable = YES;
                    
                    int turnPoints = matchScore * MATCH_BONUS;
                    self.score += turnPoints;
                    
                    self.status = [NSString stringWithFormat:@"Match %@ & %@ for %d points", card.contents, otherCard.contents, turnPoints];
                } else {
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    
                    self.status = [NSString stringWithFormat:@"No Match! %d penalty points", MISMATCH_PENALTY];
                }
            }
        }
    }
    card.faceUp = !card.isFaceUp;
    
}

@end
