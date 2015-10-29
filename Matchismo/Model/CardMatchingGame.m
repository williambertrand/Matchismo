//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by William Bertrand on 2/24/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "GameResult.h"
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1
@interface CardMatchingGame()

@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *resultString;
@property (strong, nonatomic) NSMutableArray *cards; //of cards, since NSArray is not type-bound
@property (strong, nonatomic) GameResult* gameResult;
@end


@implementation CardMatchingGame

@synthesize numberOfMatchingCards=_numberOfMatchingCards;



-(GameResult *)gameResult{
    
    if(!_gameResult)_gameResult=[[GameResult alloc] init];
    return _gameResult;
}
-(int)numberOfMatchingCards{
    
    if(!_numberOfMatchingCards)
        _numberOfMatchingCards=2;
    
    return _numberOfMatchingCards;
}


-(void)setNumberOfMatchingCards:(int)numberOfMatchingCards{
    if (numberOfMatchingCards<2) _numberOfMatchingCards=2;
    else if (numberOfMatchingCards>3) _numberOfMatchingCards=3;
    else _numberOfMatchingCards=numberOfMatchingCards;
    
}

-(NSMutableArray *)cards{
    
    if(!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}

-(id) initWithCardCount:(NSUInteger) cardCount usingDeck:(Deck *)deck
{
    self=[super init];
    
    if(self){
        for(int i=0;i< cardCount; i++){
            Card *card=[deck drawRandomCard];
            if(card){
                self.cards[i]=card;
            }
            else{
                self=nil;
                break;
            }
             
        }
    }
    
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count]) ? self.cards[index]: nil;
    
    //count is not a property of NSArray, it is a method, donc on doit usar []
    
}



-(IBAction)flipCard:(UIButton*)sender
{
    [self flipCardAtIndex:[self.cards indexOfObject:sender]];
    
}
- (void)flipCardAtIndex:(NSUInteger)index
{
    PlayingCard *card = (PlayingCard*)[self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            
            //code for multiple matches
            
            NSMutableArray* otherCards=[[NSMutableArray alloc] init];
            NSMutableArray* otherCardsContents=[[NSMutableArray alloc] init];
            
            for (PlayingCard *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [otherCardsContents addObject:otherCard.contents];
                    
                    /*if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.resultString = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                                                      card.contents, otherCard.contents,
                                                      matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.resultString = [NSString stringWithFormat:@"%@ and %@ don’t match! %d point penalty!",
                                                      card.contents, otherCard.contents,
                                                      MISMATCH_PENALTY];
                    }
                    break;
                     */
                }
                
            }
            
            //if count<NOMC-1, then the user still needs to flip a card to complete a match
            //so the resultString simply displays the card flipped up
            if([otherCards count]<self.numberOfMatchingCards-1){
                self.resultString = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            
            else{
                int matchScore=[card match:otherCards];
                NSLog(@"%d",matchScore);
                if (matchScore) {
                    card.unplayable = YES;
                    for(Card* otherCard in otherCards){
                        otherCard.unplayable=YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.resultString = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                                         card.contents, [otherCardsContents componentsJoinedByString:@" & "],
                                         matchScore * MATCH_BONUS];
                    
                }
                else{
                    for(Card* otherCard in otherCards){
                        otherCard.faceUp=NO;
                        
                        self.score-=MISMATCH_PENALTY;
                        self.resultString = [NSString stringWithFormat:@"%@ and %@ don’t match! %d point penalty!"      ,card.contents, [otherCardsContents componentsJoinedByString:@" & "],
                                             MISMATCH_PENALTY];

                    }
                }
            }
            
            
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}




-(void)newGame{
    self.score=0;
    self.resultString=@"New Game";
}




@end







