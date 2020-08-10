package com.example.flutter_music_player.models

import android.database.Cursor
import android.provider.MediaStore.Audio.Artists.ARTIST
import android.provider.MediaStore.Audio.Artists.NUMBER_OF_ALBUMS
import android.provider.MediaStore.Audio.Artists.NUMBER_OF_TRACKS
import android.provider.MediaStore.Audio.Artists._ID
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaDescriptionCompat
import com.example.flutter_music_player.constants.TYPE_ARTIST
import com.example.flutter_music_player.extensions.value
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Artist(
        var id: Long = 0,
        var name: String = "",
        var songCount: Int = 0,
        var albumCount: Int = 0
) : MediaBrowserCompat.MediaItem(
        MediaDescriptionCompat.Builder()
                .setMediaId(MediaID(TYPE_ARTIST.toString(), id.toString()).asString())
                .setTitle(name)
                .setSubtitle("$albumCount albums")
                .build(), FLAG_BROWSABLE) {
    companion object {
        fun fromCursor(cursor: Cursor): Artist {
            return Artist(
                    id = cursor.value(_ID),
                    name = cursor.value(ARTIST),
                    songCount = cursor.value(NUMBER_OF_TRACKS),
                    albumCount = cursor.value(NUMBER_OF_ALBUMS)
            )
        }
    }
}