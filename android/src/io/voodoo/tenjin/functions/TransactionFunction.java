package io.voodoo.tenjin.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.tenjin.android.TenjinSDK;
import io.voodoo.tenjin.TenjinExtensionContext;
import io.voodoo.tenjin.utils.FRELog;
import io.voodoo.tenjin.utils.FREUtils;

public class TransactionFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String productName = FREUtils.getString(args, 0);
        String currencyCode = FREUtils.getString(args, 1);
        Integer quantity = FREUtils.getInteger(args, 2);
        Double unitPrice = FREUtils.getDouble(args, 3);

        TenjinSDK.getInstance(context.getActivity(), ((TenjinExtensionContext) context).token)
                .transaction(productName, currencyCode, quantity, unitPrice);
        FRELog.i("Transaction sent to Tenjin : " + quantity + " x " + productName + " @" + unitPrice + " " + currencyCode);

        return null;
    }
}
