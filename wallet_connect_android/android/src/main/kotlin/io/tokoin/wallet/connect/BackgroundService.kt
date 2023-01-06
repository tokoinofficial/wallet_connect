package io.tokoin.wallet.connect

import android.app.Service
import android.content.Intent
import android.os.IBinder
import java.util.ArrayList
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain
import io.flutter.view.FlutterNativeView
import io.flutter.view.FlutterRunArguments
import io.tokoin.wallet.connect.WalletConnectPlugin.Params

class BackgroundService : Service() {
    @Override
    fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val callbackDispatcherHandle: Long = intent.getLongExtra(Params.CALLBACK_DISPATCHER_HANDLE_KEY, 0)
        val flutterCallbackInformation: FlutterCallbackInformation =
            FlutterCallbackInformation.lookupCallbackInformation(callbackDispatcherHandle)
        val flutterRunArguments = FlutterRunArguments()
        flutterRunArguments.bundlePath = FlutterMain.findAppBundlePath()
        flutterRunArguments.entrypoint = flutterCallbackInformation.callbackName
        flutterRunArguments.libraryPath = flutterCallbackInformation.callbackLibraryPath
        val backgroundFlutterView = FlutterNativeView(this, true)
        backgroundFlutterView.runFromBundle(flutterRunArguments)
        val mBackgroundChannel = MethodChannel(backgroundFlutterView, "background_channel")
        val callbackHandle: Long = intent.getLongExtra(Params.CALLBACK_HANDLE_KEY, 0)
        val l: ArrayList<Object> = ArrayList<Object>()
        l.add(callbackHandle)
        l.add("Hello, I am transferred from java to dart world")
        mBackgroundChannel.invokeMethod("", l)
        return START_STICKY
    }

    @Nullable
    @Override
    fun onBind(intent: Intent?): IBinder? {
        return null
    }
}