//
//  Card.m
//  Matchismo
//
//  Created by William Bertrand on 2/23/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score=0;
    
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score=1;
        }
    }
    return score;
}

@end
