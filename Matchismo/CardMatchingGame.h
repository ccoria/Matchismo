//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by ccoria on 24/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)integer;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *cards; //of Card

@end
