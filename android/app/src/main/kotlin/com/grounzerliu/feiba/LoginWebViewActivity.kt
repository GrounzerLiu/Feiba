package com.grounzerliu.feiba

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.webkit.CookieManager
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.LinearLayout
import android.widget.TextView

/**
 * A small native WebView used only for Baidu passport login.
 *
 * The page is intentionally separate from the Flutter widget tree so the
 * Android cookie store can be read after the redirect. BDUSS is HttpOnly and
 * cannot be read from JavaScript.
 */
class LoginWebViewActivity : Activity() {
    private lateinit var webView: WebView
    private var delivered = false

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.statusBarColor = Color.WHITE
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
        }

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.WHITE)
        }
        val bar = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            setPadding(dp(8), 0, dp(8), 0)
            setBackgroundColor(Color.WHITE)
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                dp(56),
            )
        }
        val close = TextView(this).apply {
            text = "×"
            textSize = 24f
            setTextColor(Color.BLACK)
            gravity = Gravity.CENTER
            setOnClickListener { finish() }
            layoutParams = LinearLayout.LayoutParams(dp(48), dp(48))
        }
        val title = TextView(this).apply {
            text = "网页登录"
            textSize = 17f
            setTextColor(Color.BLACK)
            layoutParams = LinearLayout.LayoutParams(
                0,
                ViewGroup.LayoutParams.WRAP_CONTENT,
                1f,
            )
        }
        bar.addView(close)
        bar.addView(title)

        webView = WebView(this).apply {
            layoutParams = LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                0,
                1f,
            )
            setBackgroundColor(Color.WHITE)
        }
        root.addView(bar)
        root.addView(webView)
        setContentView(root)

        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            databaseEnabled = true
            setSupportZoom(false)
        }
        CookieManager.getInstance().setAcceptCookie(true)
        CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true)
        webView.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView, url: String) {
                super.onPageFinished(view, url)
                if (delivered) return
                val host = runCatching { java.net.URI(url).host?.lowercase() }.getOrNull()
                if (host != "tieba.baidu.com" && host != "tiebac.baidu.com") return
                val cookies = CookieManager.getInstance().getCookie(url) ?: return
                if (!cookies.contains("BDUSS=")) return
                delivered = true
                val data = Intent().putExtra(EXTRA_COOKIE, cookies)
                setResult(RESULT_OK, data)
                CookieManager.getInstance().flush()
                finish()
            }
        }
        webView.loadUrl(LOGIN_URL)
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }

    override fun onDestroy() {
        webView.destroy()
        super.onDestroy()
    }

    private fun dp(value: Int): Int {
        return (value * resources.displayMetrics.density).toInt()
    }

    companion object {
        const val EXTRA_COOKIE = "cookie"

        private const val LOGIN_URL =
            "https://wappass.baidu.com/passport?login&u=https%3A%2F%2Ftieba.baidu.com%2Findex%2Ftbwise%2Fmine"
    }
}
