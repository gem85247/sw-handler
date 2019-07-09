package io.supremewatcher.supreme_handler;

import android.text.TextUtils;
import android.util.Log;
import android.webkit.CookieManager;

import java.net.URISyntaxException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * SupremeHandlerPlugin
 */
public class SupremeHandlerPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "supreme_handler");
        channel.setMethodCallHandler(new SupremeHandlerPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("clearCookies")) {
            deleteSupremeCookies();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    private synchronized void deleteSupremeCookies() {
        CookieManager cookieManager = CookieManager.getInstance();
        String url = "https://www.supremenewyork.com";
        String domainName = "supremenewyork.com";
        String cookiesString = cookieManager.getCookie(domainName);
        Log.e("cookies ====>", !TextUtils.isEmpty(cookiesString) ? cookiesString : "EMPTY");

        if (!TextUtils.isEmpty(cookiesString)) {
            String[] cookies = cookiesString.split("; ");

            for (String cookie : cookies) {
                if (TextUtils.isEmpty(cookie))
                    continue;
                int equalCharIndex = cookie.indexOf('=');
                if (equalCharIndex == -1)
                    continue;
                String cookieString = cookie.substring(0, equalCharIndex) + '='
                        + "; Domain=" + domainName;
                cookieManager.setCookie(url, cookieString);
            }
        }
    }
}
