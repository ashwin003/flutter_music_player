package com.example.flutter_music_player.utils

import android.content.ContentUris.withAppendedId
import android.content.Context
import android.os.Build
import android.provider.MediaStore.Audio.AudioColumns.IS_MUSIC
import android.provider.MediaStore.Audio.AudioColumns.TITLE
import androidx.core.net.toUri
import com.example.flutter_music_player.R
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*

object Utils {
    const val MUSIC_ONLY_SELECTION = "$IS_MUSIC=1 AND $TITLE != ''"
    const val EMPTY_ALBUM_ART_URI = "android.resource://com.example.flutter_music_player/drawable/icon"

    fun getAlbumArtUri(albumId: Long) = withAppendedId("content://media/external/audio/albumart".toUri(), albumId)

    fun makeShortTimeString(context: Context, secs: Long): String {
        var seconds = secs
        val hours: Long
        val minutes: Long

        hours = seconds / 3600
        seconds %= 3600
        minutes = seconds / 60
        seconds %= 60

        val formatString = if (hours == 0L) {
            R.string.durationformatshort
        } else {
            R.string.durationformatlong
        }
        val durationFormat = context.resources.getString(formatString)
        return String.format(durationFormat, hours, minutes, seconds)
    }

    fun isOreo() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.O

    fun makeLabel(
            context: Context,
            pluralInt: Int,
            number: Int
    ): String = context.resources.getQuantityString(pluralInt, number, number)

    fun getIPAddress(useIPv4: Boolean): String {
        try {
            val interfaces = Collections.list(NetworkInterface.getNetworkInterfaces())
            interfaces.forEach { netInterface ->
                val addresses = netInterface.inetAddresses
                while (addresses.hasMoreElements()) {
                    val address = addresses.nextElement()
                    if (!address.isLoopbackAddress) {
                        val result = processAddress(useIPv4, address)
                        if (result != null) return result
                    }
                }
            }
        } catch (_: Exception) {
        }

        return ""
    }

    private fun processAddress(useIPv4: Boolean, address: InetAddress): String? {
        val hostAddress = address.hostAddress
        val isIPv4 = hostAddress.indexOf(':') < 0
        if (useIPv4) {
            if (isIPv4) {
                return hostAddress
            }
        } else {
            if (!isIPv4) {
                val endIndex = hostAddress.indexOf('%') // drop ip6 zone suffix
                return if (endIndex < 0) {
                    hostAddress.toUpperCase(Locale.ROOT)
                } else {
                    hostAddress.substring(0, endIndex).toUpperCase(Locale.ROOT)
                }
            }
        }
        return null
    }
}