import 'dart:convert';

class ActorResponse {
    ActorResponse({
        required this.adult,
        required this.alsoKnownAs,
        required this.biography,
        this.birthday,
        required this.deathday,
        this.gender,
        required this.homepage,
        required this.id,
        this.imdbId,
        this.knownForDepartment,
        required this.name,
        this.placeOfBirth,
        this.popularity,
        this.profilePath,
    });

    bool adult;
    List<String> alsoKnownAs;
    String biography;
    DateTime? birthday;
    dynamic deathday;
    int? gender;
    dynamic homepage;
    int id;
    String? imdbId;
    String? knownForDepartment;
    String name;
    String? placeOfBirth;
    double? popularity;
    String? profilePath;

    factory ActorResponse.fromJson(String str) => ActorResponse.fromMap(json.decode(str));

    factory ActorResponse.fromMap(Map<String, dynamic> json) => ActorResponse(
        adult: json["adult"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        birthday: DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
    );
}
