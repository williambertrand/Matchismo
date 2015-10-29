//
//  GameResult.h
//  Matchismo
//
//  Created by William Bertrand on 4/2/13.
//  Copyright (c) 2013 William Bertrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
 

+(NSArray *)allGameResults; //of GameResult

@end
