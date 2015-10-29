//
//  PlayingCard.m
//  Matchismo
//
//  Created by William Bertrand on 2/24/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//synthesize property when both getter and setter are overwritten
@synthesize suit=_suit;

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)validSuits
{
    static NSArray *validSuits=nil;
    if(!validSuits)validSuits=@[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit=suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit:@"?";
}

-(int)match:(NSArray *)otherCards
{
    int score=0;
    if ([otherCards count]==1) {
         //last object never gives you an index out of bounts--> will never crash, unlike objectAtIndex...
        //also returns an id
        
        id card=[otherCards lastObject];
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *playingCard=(PlayingCard *)card;
            
            if([[playingCard suit] isEqualToString:[self suit]]){
                score=1;
            }
            if(playingCard.rank==self.rank){
                score=4;
            }

        }
        
       
            }
    
    else{
        for(PlayingCard *otherCard in otherCards){
            if([[otherCard suit] isEqualToString:[self suit]]){
                score+=1;
            }
            
            if(otherCard.rank==self.rank){
                score+=4;
            }
            
            if(otherCard.rank!=self.rank&&![otherCard.suit isEqualToString:self.suit]){
                score=0;
                break;
            }
            
        }
        
        
    }
    
    return score;
    
}


+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

@end
