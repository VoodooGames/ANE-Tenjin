package io.voodoo.tenjin.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tenjin.android.TenjinSDK;
import io.voodoo.tenjin.TenjinExtensionContext;
import io.voodoo.tenjin.utils.FRELog;
import io.voodoo.tenjin.utils.FREUtils;

public class SendEventFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String eventName = FREUtils.getString(args, 0);
        TenjinSDK.getInstance(context.getActivity(), ((TenjinExtensionContext) context).token).eventWithName(eventName);
        FRELog.i("Event sent to Tenjin : " + eventName);

        return null;
    }
}
