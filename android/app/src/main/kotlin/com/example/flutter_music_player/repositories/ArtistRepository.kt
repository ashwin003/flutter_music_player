package com.example.flutter_music_player.repositories

import android.content.ContentResolver
import android.database.Cursor
import android.provider.MediaStore
import com.example.flutter_music_player.extensions.mapList
import com.example.flutter_music_player.models.Artist
import com.example.flutter_music_player.models.MediaID
import com.example.flutter_music_player.models.Song

interface IArtistRepository {

    fun getAllArtists(caller: String?): List<Artist>

    fun getArtist(id: Long): Artist

    fun getArtists(paramString: String, limit: Int): List<Artist>

    fun getSongsForArtist(artistId: Long, caller: String?): List<Song>
}

class RealArtistRepository(
        private val contentResolver: ContentResolver
) : IArtistRepository {

    override fun getAllArtists(caller: String?): List<Artist> {
        MediaID.currentCaller = caller
        return makeArtistCursor(null, null)
                .mapList(true, Artist.Companion::fromCursor)
    }

    override fun getArtist(id: Long): Artist {
        return makeArtistCursor("_id=?", arrayOf(id.toString()))
                .mapList(true, Artist.Companion::fromCursor)
                .firstOrNull() ?: Artist()
    }

    override fun getArtists(paramString: String, limit: Int): List<Artist> {
        val results = makeArtistCursor("artist LIKE ?", arrayOf("$paramString%"))
                .mapList(true, Artist.Companion::fromCursor)
        if (results.size < limit) {
            val moreArtists = makeArtistCursor("artist LIKE ?", arrayOf("%_$paramString%"))
                    .mapList(true, Artist.Companion::fromCursor)
            results += moreArtists
        }
        return if (results.size < limit) {
            results
        } else {
            results.subList(0, limit)
        }
    }

    override fun getSongsForArtist(artistId: Long, caller: String?): List<Song> {
        MediaID.currentCaller = caller
        return makeArtistSongCursor(artistId)
                .mapList(true) { Song.fromCursor(this, artistId = artistId) }
    }

    private fun makeArtistCursor(selection: String?, paramArrayOfString: Array<String>?): Cursor? {
        val artistSortOrder = MediaStore.Audio.Artists.DEFAULT_SORT_ORDER
        return contentResolver.query(
                MediaStore.Audio.Artists.EXTERNAL_CONTENT_URI,
                arrayOf("_id", "artist", "number_of_albums", "number_of_tracks"),
                selection,
                paramArrayOfString,
                artistSortOrder
        )
    }

    private fun makeArtistSongCursor(artistId: Long): Cursor? {
        val artistSongSortOrder = MediaStore.Audio.Media.DEFAULT_SORT_ORDER
        val uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
        val selection = "is_music=1 AND title != '' AND artist_id=$artistId"
        return contentResolver.query(uri, arrayOf("_id", "title", "artist", "album", "duration", "track", "album_id"), selection, null, artistSongSortOrder)
    }
}