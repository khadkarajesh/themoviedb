class VideoDto {
  final String id;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  VideoDto({
    this.id,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory VideoDto.fromJson(Map<String, dynamic> json) {
    return VideoDto(
        id: json['id'],
        key: json['key'],
        name: json['name'],
        site: json['site'],
        size: json['size'],
        type: json['type']);
  }
}
