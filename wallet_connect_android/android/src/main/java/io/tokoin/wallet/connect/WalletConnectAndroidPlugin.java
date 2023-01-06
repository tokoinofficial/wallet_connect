package io.tokoin.wallet.connect;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import java.util.ArrayList;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * WalletConnectAndroidPlugin
 */
public class WalletConnectAndroidPlugin implements FlutterPlugin, MethodCallHandler {
    public static final String CALLBACK_HANDLE_KEY = "callback_handle_key";
    public static final String CALLBACK_DISPATCHER_HANDLE_KEY = "callback_dispatcher_handle_key";

    private MethodChannel channel;
    private Context mContext;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wallet_connect_android");
        channel.setMethodCallHandler(this);
        mContext = flutterPluginBinding.getApplicationContext();
    }

    private long mCallbackDispatcherHandle;

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        if (call.method.equals("getPlatformName")) {
            result.success("Android");
        } else if (call.method.equals("initializeForBackground")) {
            ArrayList args = call.arguments();
            long callBackHandle = (long) args.get(0);
            mCallbackDispatcherHandle = callBackHandle;
            result.success(null);
            return;
        } else if (call.method.equals("callBackgroundService")) {
            ArrayList args = call.arguments();
            long callbackHandle = (long) args.get(0);
            Intent i = new Intent(mContext, io.tokoin.wallet.connect.MyService.class);
            i.putExtra(CALLBACK_HANDLE_KEY, callbackHandle);
            i.putExtra(CALLBACK_DISPATCHER_HANDLE_KEY, mCallbackDispatcherHandle);
            mContext.startService(i);
            result.success(null);
        } else
            result.notImplemented();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
