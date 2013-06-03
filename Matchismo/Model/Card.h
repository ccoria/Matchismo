//
//  Card.h
//  Matchismo
//
//  Created by ccoria on 23/04/13.
//  Copyright (c) 2013 ccoria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)card;

@end
