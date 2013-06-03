//
//  Deck.m
//  Matchismo
//
//  Created by ccoria on 23/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //array of Cards
@end

@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard {
    
    Card *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        
        [self.cards removeObject:randomCard];
    }
    
    return randomCard;
}

@end
