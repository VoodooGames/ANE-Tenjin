package io.voodoo.tenjin;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class TenjinExtension implements FREExtension {

    @Override
    public FREContext createContext(String s) {
        return new TenjinExtensionContext();
    }

    @Override
    public void initialize() {

    }

    @Override
    public void dispose() {

    }
}
