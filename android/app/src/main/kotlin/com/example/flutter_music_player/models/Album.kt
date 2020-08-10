package com.example.flutter_music_player.models

import android.database.Cursor
import android.provider.MediaStore.Audio.Albums.ALBUM
import android.provider.MediaStore.Audio.Albums.ARTIST
import android.provider.MediaStore.Audio.Albums.FIRST_YEAR
import android.provider.MediaStore.Audio.Albums.NUMBER_OF_SONGS
import android.provider.MediaStore.Audio.Albums._ID
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaDescriptionCompat
import com.example.flutter_music_player.constants.TYPE_ALBUM
import com.example.flutter_music_player.extensions.value
import com.example.flutter_music_player.extensions.valueOrEmpty
import com.example.flutter_music_player.utils.Utils
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Album(
        var id: Long = 0,
        var title: String = "",
        var artist: String = "",
        var artistId: Long = 0,
        var songCount: Int = 0,
        var year: Int = 0
) : MediaBrowserCompat.MediaItem(
        MediaDescriptionCompat.Builder()
                .setMediaId(MediaID(TYPE_ALBUM.toString(), id.toString()).asString())
                .setTitle(title)
                .setIconUri(Utils.getAlbumArtUri(id))
                .setSubtitle(artist)
                .build(), FLAG_BROWSABLE) {

    companion object {
        fun fromCursor(cursor: Cursor, artistId: Long = -1): Album {
            return Album(
                    id = cursor.value(_ID),
                    title = cursor.valueOrEmpty(ALBUM),
                    artist = cursor.valueOrEmpty(ARTIST),
                    artistId = artistId,
                    songCount = cursor.value(NUMBER_OF_SONGS),
                    year = cursor.value(FIRST_YEAR)
            )
        }
    }
}