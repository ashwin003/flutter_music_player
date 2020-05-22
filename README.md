# flutter_music_player

A music player build entirely in Flutter as a learning exercise.
Works on Android only.

## Functionalities
### Included
1. List all audio media (songs, artists, albums, playlists) from both internal and external storage.
2. Load songs from artists, albums, playlists.
3. Play one or more songs with:
    a. Scrubbing control
    b. Notification controls
    c. Lock screen controls

## Packages used
1. [audio_service](https://pub.dev/packages/audio_service) - Service for playing media files in the background
2. [flutter_audio_query](https://pub.dev/packages/flutter_audio_query) - Loads all media from both internal and external storage
3. [just_audio](https://pub.dev/packages/just_audio) - Media player

## Known issues
1. Artist, Album, Playlist dialog overlaps and completely hides the player sheet.
2. Does not load artwork for Android 10