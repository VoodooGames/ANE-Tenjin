//
//  TenjinIosExtension.m
//  TenjinIosExtension
//
//  Created by Antoine Kleinpeter on 05/02/2016.
//  Copyright © 2016 Voodoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "FRETypeConverter.h"
#import "TenjinSDK.h"

FRETypeConverter* typeConverter;

FREObject tenjin_init(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString* token;
    [typeConverter FREGetObject:argv[0] asString:&token];
    
    NSLog(@"Initializing Tenjin extension with token : %@ ...", token);
    [TenjinSDK sharedInstanceWithToken:token];
    
    return nil;
}

FREObject tenjin_appActivated(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return nil;
}

FREObject tenjin_sendEvent(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString* eventName;
    [typeConverter FREGetObject:argv[0] asString:&eventName];
    
    NSLog(@"Sending Tenjin event %@", eventName);
    [TenjinSDK sendEventWithName:eventName];
    
    return nil;
}
    
FREObject tenjin_sendEventWithValue(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString* eventName;
    NSString* eventValue;
    [typeConverter FREGetObject:argv[0] asString:&eventName];
    [typeConverter FREGetObject:argv[1] asString:&eventValue];
    
    NSLog(@"Sending Tenjin event %@ with value %@", eventName, eventValue);
    [TenjinSDK sendEventWithName:eventName andEventValue:eventValue];
    
    return nil;
}

FREObject tenjin_transaction(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString* productName;
    NSString* currencyCode;
    int quantity;
    double unitPrice;
    
    [typeConverter FREGetObject:argv[0] asString:&productName];
    [typeConverter FREGetObject:argv[1] asString:&currencyCode];
    [typeConverter FREGetObject:argv[2] asInt:&quantity];
    [typeConverter FREGetObject:argv[3] asDouble:&unitPrice];
    
    NSLog(@"Sending transaction : %d x %@ @ %.2f %@", quantity, productName, unitPrice, currencyCode);
    [TenjinSDK transactionWithProductName:productName andCurrencyCode:currencyCode andQuantity:quantity andUnitPrice:[[NSDecimalNumber alloc] initWithDouble:unitPrice]];
    
    return nil;
}


/////////////////////////////////////////////////////////////
// NATIVE EXTENSION


void TenjinContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    *numFunctionsToSet = 5;
    NSLog(@"Setting %d extension functions ...", *numFunctionsToSet);
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToSet));
    
    func[0].name = (const uint8_t*) "tenjin_init";
    func[0].functionData = NULL;
    func[0].function = &tenjin_init;
    
    func[1].name = (const uint8_t*) "tenjin_appActivated";
    func[1].functionData = NULL;
    func[1].function = &tenjin_appActivated;
    
    func[2].name = (const uint8_t*) "tenjin_sendEvent";
    func[2].functionData = NULL;
    func[2].function = &tenjin_sendEvent;
    
    func[3].name = (const uint8_t*) "tenjin_sendEventWithValue";
    func[3].functionData = NULL;
    func[3].function = &tenjin_sendEventWithValue;
    
    func[4].name = (const uint8_t*) "tenjin_transaction";
    func[4].functionData = NULL;
    func[4].function = &tenjin_transaction;
    
    *functionsToSet = func;
}

void TenjinContextFinalizer( FREContext ctx )
{
}

void TenjinIosExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    extDataToSet = NULL;
    *ctxInitializerToSet = &TenjinContextInitializer;
    *ctxFinalizerToSet = &TenjinContextFinalizer;
    
    typeConverter = [[FRETypeConverter alloc] init];
}

void TenjinIosExtensionFinalizer()
{
    return;
}
