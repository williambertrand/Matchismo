//
//  Deck.h
//  Matchismo
//
//  Created by William Bertrand on 2/23/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card*)card atTop:(BOOL) atTop;

-(Card *)drawRandomCard;

@end
