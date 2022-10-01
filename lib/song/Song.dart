class Song {
  String artist;
  String title;
  String album;
  String release_date;
  String imageURL;
  String appleMusicURL;
  String spotifyURL;
  String generalURL;

  Song(
      {required this.artist,
      required this.title,
      required this.album,
      required this.release_date,
      required this.imageURL,
      required this.appleMusicURL,
      required this.spotifyURL,
      required this.generalURL});

  factory Song.fromJson(Map<String, dynamic> json) {
    var artist;
    try {
      artist = json["result"]["artist"];
    } catch (e) {
      artist = '';
    }

    var title;
    try {
      title = json["result"]["title"];
    } catch (e) {
      title = '';
    }

    var album;
    try {
      album = json["result"]["album"];
    } catch (e) {
      album = '';
    }

    var release_date;
    try {
      release_date = json["result"]["release_date"];
    } catch (e) {
      release_date = '';
    }

    var imageURL;
    try {
      imageURL = json["result"]["spotify"]["album"]["images"][0]["url"];
    } catch (e) {
      imageURL = '';
    }

    var appleMusicURL;

    try {
      appleMusicURL = json["result"]["apple_music"]["url"];
    } catch (e) {
      appleMusicURL = '';
    }

    var spotifyURL;
    try {
      spotifyURL = json["result"]["spotify"]["external_urls"]["spotify"];
    } catch (e) {
      spotifyURL = '';
    }

    var generalURL;
    try {
      generalURL = json["result"]["song_link"];
    } catch (e) {
      generalURL = '';
    }

    return Song(
        artist: artist,
        title: title,
        album: album,
        release_date: release_date,
        imageURL: imageURL,
        appleMusicURL: appleMusicURL,
        spotifyURL: spotifyURL,
        generalURL: generalURL);
  }
}
