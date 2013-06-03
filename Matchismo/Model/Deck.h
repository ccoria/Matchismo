//
//  Deck.h
//  Matchismo
//
//  Created by ccoria on 23/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
