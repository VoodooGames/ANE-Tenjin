package io.voodoo.tenjin {
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	/**
	 * The Tenjin extension. 
	 */
	public class Tenjin {
		
		// CONSTANTS :
		private static const EXTENSION_ID:String = "io.voodoo.Tenjin";
		
		// FUNCTIONS :
		private static const FN_INIT:String = "tenjin_init";
		private static const FN_APP_ACTIVATED:String = "tenjin_appActivated";
		private static const FN_SEND_EVENT:String = "tenjin_sendEvent";
		private static const FN_SEND_EVENT_WITH_VALUE:String = "tenjin_sendEventWithValue";
		private static const FN_TRANSACTION:String = "tenjin_transaction";
		
		// STATUS EVENTS :
		private static const EVENT_LOG:String = "Log";
		
		// PROPERTIES :
		/** The logging function you want to use. Defaults to trace. */
		public static var logger:Function = trace;
		/** The prefix appended to every log message. Defaults to "[Tenjin]". */
		public static var logPrefix:String = "[Tenjin]";
		
		private static var eventDispatcher:EventDispatcher = new EventDispatcher();
		
		private static var context:ExtensionContext;
		
		
		////////////////
		// PUBLIC API //
		////////////////
		
		/**
		 * Initializes Tenjin extension with the given token.
		 * @param token Your Tenjin token.
		 */
		public static function init(token:String):void {
			if(!isSupported()) {
				log("Unsupported platform. All calls will be ignored.");
				return;
			}
			
			context = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
			if(context == null)
				return;
			context.addEventListener(StatusEvent.STATUS, onNativeLog);
			
			context.call(FN_INIT, token);
			
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
			
			log("Tenjin extension initialized (token : " + token + ").");
		}
		
		/**
		 * Returns true when the platform is supported (ie: iOS / Android).
		 */
		public static function isSupported():Boolean {
			return Capabilities.manufacturer.indexOf("iOS") != -1 || Capabilities.manufacturer.indexOf("Android") != -1;
		}
		
		/**
		 * Sends the given event to Tenjin.
		 * 
		 * @param eventName	The name of the event
		 */
		public static function sendEvent(eventName:String):void {
			if(context == null)
				return;
			
			log("Sending event to Tenjin : " + eventName);
			context.call(FN_SEND_EVENT, eventName);
		}
		
		/**
		 * Sends the given event to Tenjin.
		 * 
		 * @param eventName	The name of the event
		 * @param value		The value associated with the event
		 */
		public static function sendEventWithValue(eventName:String, value:int):void {
			if(context == null)
				return;
			
			log("Sending event to Tenjin : " + eventName + " (" + value + ")");
			context.call(FN_SEND_EVENT_WITH_VALUE, eventName, "" + value);
		}
		
		/**
		 * Sends the given transaction to Tenjin.
		 */
		public static function transaction(productName:String, currencyCode:String, quantity:int, unitPrice:Number):void {
			if(context == null)
				return;
			
			log("Sending transaction to Tenjin : " + quantity + " x " + productName + " @" + unitPrice + " " + currencyCode);
			context.call(FN_TRANSACTION, productName, currencyCode, quantity, unitPrice);
		}
		
		
		////////////////////
		// APP ACTIVATION //
		////////////////////
		
		private static function onActivate(ev:Event):void {
			log("Application activated, informing Tenjin.");
			context.call(FN_APP_ACTIVATED);
		}
		
		
		/////////////
		// LOGGING //
		/////////////
		
		private static function onNativeLog(ev:StatusEvent):void {
			if(ev.code != EVENT_LOG)
				return;
			log(ev.level);
		}
		
		/**
		 * Outputs the given message(s) using the provided logger function, or using trace.
		 */
		private static function log(message:String, ... additionnalMessages):void {
			if(logger == null) return;
			
			if(!additionnalMessages)
				additionnalMessages = [];
			
			logger((logPrefix && logPrefix.length > 0 ? logPrefix + " " : "") + message + " " + additionnalMessages.join(" "));
		}
	}
}