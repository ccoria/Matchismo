//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by ccoria on 03/06/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (nonatomic) Card *firstCard;
@property (nonatomic) Card *secondCard;
@end

@implementation ThreeCardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@synthesize firstCard;
@synthesize secondCard;

- (void)flipCardAtIndex:(NSUInteger)integer
{
    Card *currentCard = [self cardAtIndex:integer];
    
    if (currentCard && !currentCard.isUnplayable && !currentCard.isFaceUp) {
        
        if (self.firstCard && self.secondCard) {
            //NSLog(@"Third: %@", currentCard.contents);
            [self match:currentCard];
        } else if (self.firstCard) {
            //NSLog(@"Second: %@", currentCard.contents);
            self.secondCard = currentCard;
        } else {
            //NSLog(@"First: %@", currentCard.contents);
            self.firstCard = currentCard;
            self.secondCard = nil;
        }
    }
    
    currentCard.faceUp = !currentCard.isFaceUp;
}

-(void)match:(Card *)thirdCard
{
    int matchScore = [self.firstCard match:@[self.secondCard, thirdCard]];
    NSLog(@"%@",[NSString stringWithFormat:@"score: %d", matchScore]);
    
    if (matchScore){
        self.firstCard.unplayable = YES;
        self.secondCard.unplayable = YES;
        thirdCard.unplayable = YES;

        int turnPoints = matchScore * MATCH_BONUS;
        self.score += turnPoints;
        
        self.status = [NSString stringWithFormat:@"Match %@,%@,%@ for %d points", self.firstCard.contents, self.secondCard.contents, thirdCard.contents, turnPoints];
        
        self.firstCard = nil;
        self.secondCard = nil;
        thirdCard = nil;
    } else {
        self.firstCard.faceUp = NO;
        self.secondCard.faceUp = NO;
        
        self.firstCard = thirdCard;
        self.secondCard = nil;
        
        self.score -= MISMATCH_PENALTY;
        
        self.status = [NSString stringWithFormat:@"No Match! %d penalty points", MISMATCH_PENALTY];
    }
}

@end
