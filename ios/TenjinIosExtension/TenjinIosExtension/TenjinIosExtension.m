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

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

FRETypeConverter* typeConverter;

DEFINE_ANE_FUNCTION(tenjin_init)
{
    NSLog(@"Initializing Tenjin extension ...");
    
    NSString* token;
    
    [typeConverter FREGetObject:argv[0] asString:&token];
    
    [TenjinSDK sharedInstanceWithToken:token];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(tenjin_appActivated)
{
    return NULL;
}

DEFINE_ANE_FUNCTION(tenjin_sendEvent)
{
    NSString* eventName;
    [typeConverter FREGetObject:argv[0] asString:&eventName];
    
    NSLog(@"Sending Tenjin event %@", eventName);
    
    [TenjinSDK sendEventWithName:eventName];
    
    return NULL;

}

DEFINE_ANE_FUNCTION(tenjin_sendEventWithValue)
{
    NSString* eventName;
    NSString* eventValue;
    [typeConverter FREGetObject:argv[0] asString:&eventName];
    [typeConverter FREGetObject:argv[1] asString:&eventValue];
    
    [TenjinSDK sendEventWithName:eventName andEventValue:eventValue];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(tenjin_transaction)
{
    NSString* productName;
    NSString* currencyCode;
    int quantity;
    double unitPrice;
    
    [typeConverter FREGetObject:argv[0] asString:&productName];
    [typeConverter FREGetObject:argv[1] asString:&currencyCode];
    [typeConverter FREGetObject:argv[2] asInt:&quantity];
    [typeConverter FREGetObject:argv[3] asDouble:&unitPrice];
    
    [TenjinSDK transactionWithProductName:productName andCurrencyCode:currencyCode andQuantity:quantity andUnitPrice:[[NSDecimalNumber alloc] initWithDouble:unitPrice]];
    
    return NULL;
}


/////////////////////////////////////////////////////////////
// NATIVE EXTENSION


void TenjinContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction mopubFunctionMap[] =
    {
        MAP_FUNCTION(tenjin_init, NULL),
        MAP_FUNCTION(tenjin_appActivated, NULL),
        MAP_FUNCTION(tenjin_sendEventWithValue, NULL),
        MAP_FUNCTION(tenjin_transaction, NULL)
    };
        
    *numFunctionsToSet = sizeof( mopubFunctionMap ) / sizeof( FRENamedFunction );
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
