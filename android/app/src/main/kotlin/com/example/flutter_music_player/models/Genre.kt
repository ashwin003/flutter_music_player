package com.example.flutter_music_player.models

import android.database.Cursor
import android.provider.MediaStore.Audio.Genres.NAME
import android.provider.MediaStore.Audio.Genres._ID
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaDescriptionCompat
import com.example.flutter_music_player.constants.TYPE_GENRE
import com.example.flutter_music_player.extensions.value
import com.example.flutter_music_player.extensions.valueOrEmpty
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Genre(
        val id: Long,
        val name: String,
        val songCount: Int
) : MediaBrowserCompat.MediaItem(
        MediaDescriptionCompat.Builder()
                .setMediaId(MediaID("$TYPE_GENRE", "$id").asString())
                .setTitle(name)
                .setSubtitle("$songCount songs")
                .build(), FLAG_BROWSABLE) {
    companion object {
        fun fromCursor(cursor: Cursor, songCount: Int): Genre {
            return Genre(
                    id = cursor.value(_ID),
                    name = cursor.valueOrEmpty(NAME),
                    songCount = songCount
            )
        }
    }
}