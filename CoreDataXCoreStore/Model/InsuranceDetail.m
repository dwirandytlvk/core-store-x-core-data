//
//  InsuranceDetail.m
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 17/01/23.
//

#import "InsuranceDetail.h"


static NSString *const kInsuranceStatus = @"insuranceStatus";
static NSString *const kProviderId = @"providerId";
static NSString *const kProductType = @"productType";
static NSString *const kInsurancedPerson = @"insurancedPerson";

@implementation InsuranceDetail

- (instancetype)initWithDictionary:(NSDictionary *)dict
                           context:(NSManagedObjectContext *)context {
    self = [super initWithContext:context];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.insuranceStatus = [dict safeObjectForKey:kInsuranceStatus];
        self.providerId = [dict safeObjectForKey:kProviderId];
        self.productType = [dict safeObjectForKey:kProductType];
        
        NSArray<NSDictionary *> *personsDict = [dict safeObjectForKey:kInsurancedPerson];
        if (!self.insurancedPerson) {
            self.insurancedPerson = [NSMutableSet set];
        }
        
        for (id personDict in personsDict) {
            InsurancedPerson *person = [[InsurancedPerson alloc] initWithDictionary:personDict context: context];
            [self.insurancedPerson addObject:person];
        }
        
    }
    
    return self;
}

@end
