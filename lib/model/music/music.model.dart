/// this class model music for handling data about list music
/// this class generate using json to dart
class MusicModel {
  int? resultCount;
  List<DataMusic>? results;

  MusicModel({this.resultCount, this.results});

  MusicModel.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount']??0;
    if (json['results'] != null) {
      results = <DataMusic>[];
      json['results'].forEach((v) {
        results!.add(DataMusic.fromJson(v));
      });
    }else{
      results=[];
    }
  }

}

/// class for handling about music
class DataMusic {
  String? wrapperType;
  String? kind;
  int? artistId;
  int? collectionId;
  int? trackId;
  String? artistName;
  String? collectionName;
  String? trackName;
  String? collectionCensoredName;
  String? trackCensoredName;
  int? collectionArtistId;
  String? collectionArtistName;
  String? artistViewUrl;
  String? collectionViewUrl;
  String? trackViewUrl;
  String? previewUrl;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;
  double? collectionPrice;
  double? trackPrice;
  String? releaseDate;
  String? collectionExplicitness;
  String? trackExplicitness;
  int? discCount;
  int? discNumber;
  int? trackCount;
  int? trackNumber;
  int? trackTimeMillis;
  String? country;
  String? currency;
  String? primaryGenreName;
  bool? isStreamable;

  DataMusic(
      {this.wrapperType,
        this.kind,
        this.artistId,
        this.collectionId,
        this.trackId,
        this.artistName,
        this.collectionName,
        this.trackName,
        this.collectionCensoredName,
        this.trackCensoredName,
        this.collectionArtistId,
        this.collectionArtistName,
        this.artistViewUrl,
        this.collectionViewUrl,
        this.trackViewUrl,
        this.previewUrl,
        this.artworkUrl30,
        this.artworkUrl60,
        this.artworkUrl100,
        this.collectionPrice,
        this.trackPrice,
        this.releaseDate,
        this.collectionExplicitness,
        this.trackExplicitness,
        this.discCount,
        this.discNumber,
        this.trackCount,
        this.trackNumber,
        this.trackTimeMillis,
        this.country,
        this.currency,
        this.primaryGenreName,
        this.isStreamable});

  DataMusic.fromJson(Map<String, dynamic> json) {
    wrapperType = json['wrapperType'];
    kind = json['kind'];
    artistId = json['artistId'];
    trackId = json['trackId'];
    artistName = json['artistName'];
    collectionName = json['collectionName'];
    trackName = json['trackName'];
    // collectionCensoredName = json['collectionCensoredName'];
    // trackCensoredName = json['trackCensoredName'];
    // collectionArtistId = json['collectionArtistId'];
    // collectionArtistName = json['collectionArtistName'];
    // artistViewUrl = json['artistViewUrl'];
    // collectionViewUrl = json['collectionViewUrl'];
    // trackViewUrl = json['trackViewUrl'];
    previewUrl = json['previewUrl'];
    artworkUrl30 = json['artworkUrl30'];
    artworkUrl60 = json['artworkUrl60'];
    artworkUrl100 = json['artworkUrl100'];
  }

}
