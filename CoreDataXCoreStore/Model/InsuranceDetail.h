//
//  InsuranceDetail.h
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 17/01/23.
//

#import <CoreData/CoreData.h>

#if __has_include("CoreDataXCoreStore-Swift.h")
#import "CoreDataXCoreStore-Swift.h"
#else
#import <CoreDataXCoreStore/CoreDataXCoreStore-Swift.h>
#endif

#import "NSDictionary+SafeObject.h"
#import "InsurancedPerson.h"

@import CoreStore;


NS_ASSUME_NONNULL_BEGIN

@interface InsuranceDetail : NSManagedObject

@property (nonatomic, assign) NSString *insuranceStatus;
@property (nonatomic, assign) NSString *providerId;
@property (nonatomic, assign) NSString *productType;

// Relationship
@property (nonatomic, assign, nullable) FlightBookingInfo *flightBookingInfo;
@property (nonatomic, assign, nullable) NSMutableSet<InsurancedPerson *> *insurancedPerson;

- (instancetype)initWithDictionary:(NSDictionary *)dict
                           context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
