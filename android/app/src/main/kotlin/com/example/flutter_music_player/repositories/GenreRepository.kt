package com.example.flutter_music_player.repositories

import android.content.ContentResolver
import android.database.Cursor
import android.provider.MediaStore
import com.example.flutter_music_player.models.Genre
import com.example.flutter_music_player.models.MediaID
import com.example.flutter_music_player.models.Song
import android.provider.MediaStore.Audio.Genres.NAME
import android.provider.MediaStore.Audio.Genres._ID
import android.provider.MediaStore.Audio.Media.DEFAULT_SORT_ORDER
import com.example.flutter_music_player.extensions.mapList
import com.example.flutter_music_player.extensions.value

interface IGenreRepository {

    fun getAllGenres(caller: String?): List<Genre>

    fun getSongsForGenre(genreId: Long, caller: String?): List<Song>
}

class RealGenreRepository(
        private val contentResolver: ContentResolver
) : IGenreRepository {

    override fun getAllGenres(caller: String?): List<Genre> {
        MediaID.currentCaller = caller
        return makeGenreCursor().mapList(true) {
            val id: Long = value(_ID)
            val songCount = getSongCountForGenre(id)
            Genre.fromCursor(this, songCount)
        }.filter { it.songCount > 0 }
    }

    override fun getSongsForGenre(genreId: Long, caller: String?): List<Song> {
        MediaID.currentCaller = caller
        return makeGenreSongCursor(genreId)
                .mapList(true) { Song.fromCursor(this) }
    }

    private fun makeGenreCursor(): Cursor? {
        val uri = MediaStore.Audio.Genres.EXTERNAL_CONTENT_URI
        val projection = arrayOf(_ID, NAME)
        return contentResolver.query(uri, projection, null, null, NAME)
    }

    private fun getSongCountForGenre(genreID: Long): Int {
        val uri = MediaStore.Audio.Genres.Members.getContentUri("external", genreID)
        return contentResolver.query(uri, null, null, null, null)?.use {
            it.moveToFirst()
            if (it.count == 0) {
                -1
            } else {
                it.count
            }
        } ?: -1
    }

    private fun makeGenreSongCursor(genreID: Long): Cursor? {
        val uri = MediaStore.Audio.Genres.Members.getContentUri("external", genreID)
        val projection = arrayOf("_id", "title", "artist", "album", "duration", "track", "album_id", "artist_id")
        return contentResolver.query(uri, projection, null, null, DEFAULT_SORT_ORDER)
    }
}