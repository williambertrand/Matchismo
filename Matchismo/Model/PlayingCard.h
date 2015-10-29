//
//  PlayingCard.h
//  Matchismo
//
//  Created by William Bertrand on 2/24/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong, nonatomic) NSString *suit;
@property(nonatomic)NSUInteger rank;
@property (nonatomic) int numberOfMatchingCards;
+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
