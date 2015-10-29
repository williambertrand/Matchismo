//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by William Bertrand on 2/24/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
@interface CardMatchingGame : NSObject

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *resultString;
@property(nonatomic)int numberOfMatchingCards;
//designated initializer
-(id) initWithCardCount:(NSUInteger) cardCount usingDeck:(Deck *)deck;
-(void)flipCardAtIndex: (NSUInteger) index;
-(Card *)cardAtIndex:(NSUInteger) index;


@end
