package io.tokoin.wallet.connect

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.walletconnect.android.Core
import com.walletconnect.android.CoreClient
import com.walletconnect.android.relay.ConnectionType
import com.walletconnect.sign.client.Sign
import com.walletconnect.sign.client.SignClient
import java.util.ArrayList
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * WalletConnectAndroidPlugin
 */
class WalletConnectAndroidPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var activity: Activity
    private var channel: MethodChannel? = null
    private var mContext: Context? = null

    @Override
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wallet_connect_android")
        channel!!.setMethodCallHandler(this)
        mContext = flutterPluginBinding.getApplicationContext()
    }

    private var mCallbackDispatcherHandle: Long = 0

    @Override
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method.equals("getPlatformName")) {
            result.success("Android")
        } else if (call.method.equals("initializeForBackground")) {
            val args = call.arguments() as ArrayList<*>?
            val callBackHandle = args?.get(0) as Long
            mCallbackDispatcherHandle = callBackHandle
            result.success(null)
            return
        } else if (call.method.equals("callBackgroundService")) {
            val args = call.arguments() as ArrayList<*>?
            val callbackHandle = args?.get(0) as Long
            val i = Intent(mContext, io.tokoin.wallet.connect.MyService::class.java)
            i.putExtra(CALLBACK_HANDLE_KEY, callbackHandle)
            i.putExtra(CALLBACK_DISPATCHER_HANDLE_KEY, mCallbackDispatcherHandle)
            mContext?.startService(i)
            result.success(null)
        } else if (call.method.equals("signInitialize")) {
            val projectId =
                "407ef5be088b5f523d93af6aa138506a" // Get Project ID at https://cloud.walletconnect.com/
            val relayUrl = "relay.walletconnect.com"
            val serverUrl = "wss://$relayUrl?projectId=$projectId"
            val connectionType = ConnectionType.AUTOMATIC
            val appMetaData = Core.Model.AppMetaData(
                name = "Wallet Name",
                description = "Wallet Description",
                url = "Wallet Url",
                redirect = "kotlin-wallet-wc:/request", // Custom Redirect URI
                icons = listOf()
            )

            CoreClient.initialize(
                relayServerUrl = serverUrl,
                connectionType = connectionType,
                application = activity.application,
                metaData = appMetaData,
                onError = { error ->
                    print(error)
                })

            val init = Sign.Params.Init(core = CoreClient)

            SignClient.initialize(init) { error ->
                print(error)
            }
        } else result.notImplemented()
    }

    @Override
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.channel?.setMethodCallHandler(null)
    }

    companion object {
        const val CALLBACK_HANDLE_KEY = "callback_handle_key"
        const val CALLBACK_DISPATCHER_HANDLE_KEY = "callback_dispatcher_handle_key"
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}