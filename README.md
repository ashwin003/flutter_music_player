# flutter_music_player

A music player build entirely in Flutter as a learning exercise.
Works on Android only.
Feel free to suggest improvements as well as additional (or missing) functionalities

## Functionalities
### Included
1. List all audio media (songs, artists, albums, playlists) from both internal and external storage.
2. Load songs from artists, albums, playlists.
3. Play one or more songs with:
    a. Scrubbing control
    b. Notification controls
    c. Lock screen controls
4. Shuffle songs
5. Loading album artwork v 1

## Packages used
1. [audio_service](https://pub.dev/packages/audio_service) - Service for playing media files in the background
2. [flutter_audio_query](https://pub.dev/packages/flutter_audio_query) - Loads all media from both internal and external storage
3. [just_audio](https://pub.dev/packages/just_audio) - Media player