import 'package:movie/data/dto/movie_detail_dto.dart';

movieDetailDtoFromJson(MovieDetailDto data, Map<String, dynamic> json) {
	if (json['adult'] != null) {
		data.adult = json['adult'];
	}
	if (json['backdrop_path'] != null) {
		data.backdropPath = json['backdrop_path']?.toString();
	}
	if (json['belongs_to_collection'] != null) {
		data.belongsToCollection = json['belongs_to_collection'];
	}
	if (json['budget'] != null) {
		data.budget = json['budget']?.toInt();
	}
	if (json['genres'] != null) {
		data.genres = new List<MovieDetailDtoGenre>();
		(json['genres'] as List).forEach((v) {
			data.genres.add(new MovieDetailDtoGenre().fromJson(v));
		});
	}
	if (json['homepage'] != null) {
		data.homepage = json['homepage']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['imdb_id'] != null) {
		data.imdbId = json['imdb_id']?.toString();
	}
	if (json['original_language'] != null) {
		data.originalLanguage = json['original_language']?.toString();
	}
	if (json['original_title'] != null) {
		data.originalTitle = json['original_title']?.toString();
	}
	if (json['overview'] != null) {
		data.overview = json['overview']?.toString();
	}
	if (json['popularity'] != null) {
		data.popularity = json['popularity']?.toDouble();
	}
	if (json['poster_path'] != null) {
		data.posterPath = json['poster_path']?.toString();
	}
	if (json['production_companies'] != null) {
		data.productionCompanies = new List<MovieDetailDtoProductionCompany>();
		(json['production_companies'] as List).forEach((v) {
			data.productionCompanies.add(new MovieDetailDtoProductionCompany().fromJson(v));
		});
	}
	if (json['production_countries'] != null) {
		data.productionCountries = new List<MovieDetailDtoProductionCountry>();
		(json['production_countries'] as List).forEach((v) {
			data.productionCountries.add(new MovieDetailDtoProductionCountry().fromJson(v));
		});
	}
	if (json['release_date'] != null) {
		data.releaseDate = json['release_date']?.toString();
	}
	if (json['revenue'] != null) {
		data.revenue = json['revenue']?.toInt();
	}
	if (json['runtime'] != null) {
		data.runtime = json['runtime']?.toInt();
	}
	if (json['spoken_languages'] != null) {
		data.spokenLanguages = new List<MovieDetailDtoSpokenLanguage>();
		(json['spoken_languages'] as List).forEach((v) {
			data.spokenLanguages.add(new MovieDetailDtoSpokenLanguage().fromJson(v));
		});
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['tagline'] != null) {
		data.tagline = json['tagline']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['video'] != null) {
		data.video = json['video'];
	}
	if (json['vote_average'] != null) {
		data.voteAverage = json['vote_average']?.toInt();
	}
	if (json['vote_count'] != null) {
		data.voteCount = json['vote_count']?.toInt();
	}
	return data;
}

Map<String, dynamic> movieDetailDtoToJson(MovieDetailDto entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['adult'] = entity.adult;
	data['backdrop_path'] = entity.backdropPath;
	data['belongs_to_collection'] = entity.belongsToCollection;
	data['budget'] = entity.budget;
	if (entity.genres != null) {
		data['genres'] =  entity.genres.map((v) => v.toJson()).toList();
	}
	data['homepage'] = entity.homepage;
	data['id'] = entity.id;
	data['imdb_id'] = entity.imdbId;
	data['original_language'] = entity.originalLanguage;
	data['original_title'] = entity.originalTitle;
	data['overview'] = entity.overview;
	data['popularity'] = entity.popularity;
	data['poster_path'] = entity.posterPath;
	if (entity.productionCompanies != null) {
		data['production_companies'] =  entity.productionCompanies.map((v) => v.toJson()).toList();
	}
	if (entity.productionCountries != null) {
		data['production_countries'] =  entity.productionCountries.map((v) => v.toJson()).toList();
	}
	data['release_date'] = entity.releaseDate;
	data['revenue'] = entity.revenue;
	data['runtime'] = entity.runtime;
	if (entity.spokenLanguages != null) {
		data['spoken_languages'] =  entity.spokenLanguages.map((v) => v.toJson()).toList();
	}
	data['status'] = entity.status;
	data['tagline'] = entity.tagline;
	data['title'] = entity.title;
	data['video'] = entity.video;
	data['vote_average'] = entity.voteAverage;
	data['vote_count'] = entity.voteCount;
	return data;
}

movieDetailDtoGenreFromJson(MovieDetailDtoGenre data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> movieDetailDtoGenreToJson(MovieDetailDtoGenre entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}

movieDetailDtoProductionCompanyFromJson(MovieDetailDtoProductionCompany data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['logo_path'] != null) {
		data.logoPath = json['logo_path']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['origin_country'] != null) {
		data.originCountry = json['origin_country']?.toString();
	}
	return data;
}

Map<String, dynamic> movieDetailDtoProductionCompanyToJson(MovieDetailDtoProductionCompany entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['logo_path'] = entity.logoPath;
	data['name'] = entity.name;
	data['origin_country'] = entity.originCountry;
	return data;
}

movieDetailDtoProductionCountryFromJson(MovieDetailDtoProductionCountry data, Map<String, dynamic> json) {
	if (json['iso_3166_1'] != null) {
		data.iso31661 = json['iso_3166_1']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> movieDetailDtoProductionCountryToJson(MovieDetailDtoProductionCountry entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['iso_3166_1'] = entity.iso31661;
	data['name'] = entity.name;
	return data;
}

movieDetailDtoSpokenLanguageFromJson(MovieDetailDtoSpokenLanguage data, Map<String, dynamic> json) {
	if (json['iso_639_1'] != null) {
		data.iso6391 = json['iso_639_1']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	return data;
}

Map<String, dynamic> movieDetailDtoSpokenLanguageToJson(MovieDetailDtoSpokenLanguage entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['iso_639_1'] = entity.iso6391;
	data['name'] = entity.name;
	return data;
}