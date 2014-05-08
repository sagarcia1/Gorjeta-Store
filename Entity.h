//
//  Entity.h
//  gorjeta
//
//  Created by Marcelo Garcia on 25/02/14.
//  Copyright (c) 2014 Celo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * categoria;
@property (nonatomic, retain) NSString * valor_total;
@property (nonatomic, retain) NSString * valor_pessoa;
@end

@interface Entity (CoreDataGeneratedAccessors)

-(void)addCategoriaObject:(Entity *)value;
-(void)removeCategoriaObject:(Entity *)value;
-(void)addCategoria:(NSSet *)values;
-(void)removeCategoria:(NSSet *)values;

@end
