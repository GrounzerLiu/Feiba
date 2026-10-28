package com.grounzerliu.feiba

import android.app.Activity
import android.content.Intent
import android.webkit.CookieManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var pendingLoginResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "feiba/login",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "openLogin" -> {
                    if (pendingLoginResult != null) {
                        result.error("busy", "login is already open", null)
                    } else {
                        pendingLoginResult = result
                        CookieManager.getInstance().removeAllCookies {
                            startActivityForResult(
                                Intent(this, LoginWebViewActivity::class.java),
                                LOGIN_REQUEST_CODE,
                            )
                        }
                    }
                }
                "clearCookies" -> {
                    CookieManager.getInstance().removeAllCookies {
                        result.success(true)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != LOGIN_REQUEST_CODE) return
        val pending = pendingLoginResult
        pendingLoginResult = null
        if (resultCode == Activity.RESULT_OK) {
            pending?.success(data?.getStringExtra(LoginWebViewActivity.EXTRA_COOKIE))
        } else {
            pending?.success(null)
        }
    }

    private companion object {
        const val LOGIN_REQUEST_CODE = 4101
    }
}