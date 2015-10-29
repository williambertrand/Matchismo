//
//  Card.h
//  Matchismo
//
//  Created by William Bertrand on 2/23/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString * contents;

@property(nonatomic, getter=isFaceUp) BOOL faceUp;
@property(nonatomic, getter=isUnplayable) BOOL unplayable;

-(int)match: (NSArray *)otherCards;

@end
