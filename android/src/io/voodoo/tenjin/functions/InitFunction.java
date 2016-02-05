package io.voodoo.tenjin.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tenjin.android.TenjinSDK;
import io.voodoo.tenjin.TenjinExtensionContext;
import io.voodoo.tenjin.utils.FRELog;
import io.voodoo.tenjin.utils.FREUtils;

public class InitFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        FRELog.context = context;

        String token = FREUtils.getString(args, 0);

        ((TenjinExtensionContext) context).token = token;

        TenjinSDK.getInstance(context.getActivity(), token).connect();
        FRELog.i("Tenjin initialized with token : " + token);

        return null;
    }
}
