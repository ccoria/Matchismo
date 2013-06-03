//
//  PlayingCard.m
//  Matchismo
//
//  Created by ccoria on 23/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else if ([otherCards count] > 1) {
        BOOL isASuitMatch = NO;
        BOOL isARankMatch = NO;
        
        for (PlayingCard *currentCard in otherCards) {
            
            if ([currentCard.suit isEqualToString:self.suit]) {
                if (isASuitMatch) score = 2;
                isASuitMatch = YES;
            } else if (currentCard.rank == self.rank) {
                if (isARankMatch) score = 5;
                isARankMatch = YES;
            }
        }
    }

    return score;
}

- (NSString *)contents {
    
    NSArray *rankString = [PlayingCard rankStrings];
    NSString *content = [rankString[self.rank] stringByAppendingString:self.suit];
    return content;
}


+ (NSArray *)validSuits {
    return @[@"♥",@"♠",@"♣",@"♦"];
}

- (void)setSuit:(NSString *)suit {
    
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

// Rank
+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank {
    
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
