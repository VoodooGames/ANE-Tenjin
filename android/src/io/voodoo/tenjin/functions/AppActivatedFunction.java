package io.voodoo.tenjin.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tenjin.android.TenjinSDK;
import io.voodoo.tenjin.TenjinExtensionContext;
import io.voodoo.tenjin.utils.FRELog;

public class AppActivatedFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        FRELog.i("App reactivated, reconnecting Tenjin");
        TenjinSDK.getInstance(context.getActivity(), ((TenjinExtensionContext) context).token).connect();

        return null;
    }
}
