import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import '../extensions/songItemExtensions.dart';

class AudioService {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  Future<List<MediaItem>> getSongs() async {
    List<SongInfo> songs = await audioQuery.getSongs();
    return songs.where((song) => song.isMusic).map((s) => s.toMediaItem()).toList();
  }

  Future<List<MediaItem>> getSongsFromAlbum(String albumId) async {
    List<SongInfo> songs = await audioQuery.getSongsFromAlbum(albumId: albumId);
    return songs.where((song) => song.isMusic).map((s) => s.toMediaItem()).toList();
  }

  Future<List<MediaItem>> getSongsFromArtist(String artistName) async {
    List<SongInfo> songs = await audioQuery.getSongsFromArtist(artist: artistName);
    return songs.where((song) => song.isMusic).map((s) => s.toMediaItem()).toList();
  }

  Future<List<MediaItem>> getSongsFromArtistAlbum(String artistName, String albumId) async {
    List<SongInfo> songs = await audioQuery.getSongsFromArtistAlbum(albumId: albumId, artist: artistName);
    return songs.where((song) => song.isMusic).map((s) => s.toMediaItem()).toList();
  }

  Future<List<MediaItem>> getSongsFromPlaylist(PlaylistInfo playlist) async {
    List<SongInfo> songs = await audioQuery.getSongsFromPlaylist(playlist: playlist);
    return songs.where((song) => song.isMusic).map((s) => s.toMediaItem()).toList();
  }

  Future<List<AlbumInfo>> getAlbums() async {
    List<AlbumInfo> albums = await audioQuery.getAlbums();
    return albums;
  }

  Future<List<AlbumInfo>> getAlbumsFromArtist(String artistId) async {
    List<AlbumInfo> albums = await audioQuery.getAlbumsFromArtist(artist: artistId);
    return albums;
  }

  Future<AlbumInfo> getAlbum(String albumId) async {
    List<AlbumInfo> album = await audioQuery.getAlbumsById(ids: [albumId]);
    return album[0];
  }

  Future<List<GenreInfo>> getGenres() async {
    List<GenreInfo> genres =  await audioQuery.getGenres();
    return genres;
  }

  Future<List<ArtistInfo>> getArtists() async {
    List<ArtistInfo> artists = await audioQuery.getArtists();
    return artists;
  }

  Future<List<PlaylistInfo>> getPlaylists() async {
    List<PlaylistInfo> playlists = await audioQuery.getPlaylists();
    return playlists;
  }

  Future<PlaylistInfo> createPlaylist(String playlistName) async {
    return await FlutterAudioQuery.createPlaylist(playlistName: playlistName);
  }
}