package io.voodoo.tenjin.utils;

import android.util.Log;
import com.adobe.fre.FREContext;
import io.voodoo.tenjin.TenjinEvent;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Provides some methods to bubble native logs to AS3.
 */
public class FRELog {
	
	private static final String TAG = "TenjinExtension";

	// PROPERTIES :
	/** The current extension context to use to dispatch log events. */
	public static FREContext context;
	/** A Date formatter used for logging. */
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss.SSS");
	
	
	
	//////////
	// LOGS //
	//////////
	
	/**
	 * Logs the given message at info level.
	 */
	public static void i(String message) {
		Log.i(TAG, message);
		if(context != null)
			context.dispatchStatusEventAsync(TenjinEvent.EVENT_LOG, dateFormat.format(new Date()) + " INFO " + message);
	}
	
	/**
	 * Logs the given message at warning level.
	 */
	public static void w(String message) {
		Log.w(TAG, message);
		if(context != null)
			context.dispatchStatusEventAsync(TenjinEvent.EVENT_LOG, dateFormat.format(new Date()) + " WARN " + message);
	}
	
	/**
	 * Logs the given message at error level.
	 */
	public static void e(String message) {
		Log.e(TAG, message);
		if(context != null)
			context.dispatchStatusEventAsync(TenjinEvent.EVENT_LOG, dateFormat.format(new Date()) + " ERROR " + message);
	}
}
