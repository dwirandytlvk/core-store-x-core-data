//
//  NSDictionary+SafeObject.m
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 18/01/23.
//

#import "NSDictionary+SafeObject.h"

@implementation NSDictionary (SafeObject)

- (nullable id)safeObjectForKey:(nonnull NSString *)key {
    id result = [self objectForKey:key];
    if ([result isEqual:[NSNull null]]) {
        return nil;
    }
    return result;
}

- (nullable id)safeValueForKeyPath:(nonnull NSString *)keyPath {
    id result = [self valueForKeyPath:keyPath];
    if ([result isEqual:[NSNull null]]) {
        return nil;
    }
    return result;
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
