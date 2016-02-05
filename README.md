Air Native Extension for Tenjin on iOS and Android (ARM and x86)
==================================

- Tenjin Android SDK version : 1.2.0
- Tenjin iOS SDK version : 1.2.0
 
- Add this to your android manifest :

```xml
<android>
	<manifestAdditions><![CDATA[
		<manifest android:installLocation="auto">

			...

			<!-- TENJIN -->
			<uses-permission android:name="android.permission.INTERNET"/>

			...
			
			<application ...>
				
				...
				
				<!-- TENJIN -->
				<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
				<receiver android:name="com.tenjin.android.TenjinReferrerReceiver" android:exported="true">
					<intent-filter>
						<action android:name="com.android.vending.INSTALL_REFERRER"/>
					</intent-filter>
				</receiver>
				
				...
				
			</application>
		</manifest>
	]]></manifestAdditions>
</android>
```