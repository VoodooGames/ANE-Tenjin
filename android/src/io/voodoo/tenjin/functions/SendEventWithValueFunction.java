package io.voodoo.tenjin.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tenjin.android.TenjinSDK;
import io.voodoo.tenjin.TenjinExtensionContext;
import io.voodoo.tenjin.utils.FRELog;
import io.voodoo.tenjin.utils.FREUtils;

public class SendEventWithValueFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String eventName = FREUtils.getString(args, 0);
        String eventValue = FREUtils.getString(args, 1);

        TenjinSDK.getInstance(context.getActivity(), ((TenjinExtensionContext) context).token)
                .eventWithNameAndValue(eventName, eventValue);
        FRELog.i("Event with value sent to Tenjin : " + eventName + " = " + eventValue);

        return null;
    }
}
