import 'package:movie/generated/json/base/json_convert_content.dart';
import 'package:movie/generated/json/base/json_filed.dart';

class MovieDetailDto with JsonConvert<MovieDetailDto> {
	bool adult;
	@JSONField(name: "backdrop_path")
	String backdropPath;
	@JSONField(name: "belongs_to_collection")
	dynamic belongsToCollection;
	int budget;
	List<MovieDetailDtoGenre> genres;
	String homepage;
	int id;
	@JSONField(name: "imdb_id")
	String imdbId;
	@JSONField(name: "original_language")
	String originalLanguage;
	@JSONField(name: "original_title")
	String originalTitle;
	String overview;
	double popularity;
	@JSONField(name: "poster_path")
	String posterPath;
	@JSONField(name: "production_companies")
	List<MovieDetailDtoProductionCompany> productionCompanies;
	@JSONField(name: "production_countries")
	List<MovieDetailDtoProductionCountry> productionCountries;
	@JSONField(name: "release_date")
	String releaseDate;
	int revenue;
	int runtime;
	@JSONField(name: "spoken_languages")
	List<MovieDetailDtoSpokenLanguage> spokenLanguages;
	String status;
	String tagline;
	String title;
	bool video;
	@JSONField(name: "vote_average")
	int voteAverage;
	@JSONField(name: "vote_count")
	int voteCount;
}

class MovieDetailDtoGenre with JsonConvert<MovieDetailDtoGenre> {
	int id;
	String name;
}

class MovieDetailDtoProductionCompany with JsonConvert<MovieDetailDtoProductionCompany> {
	int id;
	@JSONField(name: "logo_path")
	String logoPath;
	String name;
	@JSONField(name: "origin_country")
	String originCountry;
}

class MovieDetailDtoProductionCountry with JsonConvert<MovieDetailDtoProductionCountry> {
	@JSONField(name: "iso_3166_1")
	String iso31661;
	String name;
}

class MovieDetailDtoSpokenLanguage with JsonConvert<MovieDetailDtoSpokenLanguage> {
	@JSONField(name: "iso_639_1")
	String iso6391;
	String name;
}
