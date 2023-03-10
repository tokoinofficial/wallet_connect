package io.tokoin.wallet.connect;

import static io.tokoin.wallet.connect.WalletConnectAndroidPlugin.CALLBACK_DISPATCHER_HANDLE_KEY;
import static io.tokoin.wallet.connect.WalletConnectAndroidPlugin.CALLBACK_HANDLE_KEY;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

import java.util.ArrayList;

import androidx.annotation.Nullable;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterCallbackInformation;
import io.flutter.view.FlutterMain;
import io.flutter.view.FlutterNativeView;
import io.flutter.view.FlutterRunArguments;

public class MyService extends Service {

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        long callbackDispatcherHandle = intent.getLongExtra(CALLBACK_DISPATCHER_HANDLE_KEY, 0);

        FlutterCallbackInformation flutterCallbackInformation =
                FlutterCallbackInformation.lookupCallbackInformation(callbackDispatcherHandle);

        FlutterRunArguments flutterRunArguments = new FlutterRunArguments();
        flutterRunArguments.bundlePath = FlutterMain.findAppBundlePath();
        flutterRunArguments.entrypoint = flutterCallbackInformation.callbackName;
        flutterRunArguments.libraryPath = flutterCallbackInformation.callbackLibraryPath;

        FlutterNativeView backgroundFlutterView = new FlutterNativeView(this, true);
        backgroundFlutterView.runFromBundle(flutterRunArguments);

        MethodChannel mBackgroundChannel = new MethodChannel(backgroundFlutterView, "background_channel");

        long callbackHandle = intent.getLongExtra(CALLBACK_HANDLE_KEY, 0);

        final ArrayList<Object> l = new ArrayList<Object>();
        l.add(callbackHandle);
        l.add("Hello, I am transferred from java to dart world");

        mBackgroundChannel.invokeMethod("", l);

        return START_STICKY;
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}