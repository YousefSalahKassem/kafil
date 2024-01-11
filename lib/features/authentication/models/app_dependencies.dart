class AppDependencies {
  final List<Dependency> types;
  final List<Dependency> tags;
  final List<Social> socialMedia;

  const AppDependencies({
    required this.types,
    required this.tags,
    required this.socialMedia,
  });

  factory AppDependencies.fromJson(Map<String, dynamic> json) {
    return AppDependencies(
      types: (json['types'] as List<dynamic>)
          .map((type) => Dependency.fromJson(type))
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Dependency.fromJson(tag))
          .toList(),
      socialMedia: (json['social_media'] as List<dynamic>)
          .map((socialMedia) => Social.fromJson(socialMedia))
          .toList(),
    );
  }
}

class Dependency {
  final int value;
  final String label;

  const Dependency({
    required this.label,
    required this.value,
  });

  factory Dependency.fromJson(Map<String, dynamic> json) {
    return Dependency(
      label: json['label'] as String,
      value: json['value'] as int,
    );
  }
}

class Social {
  final String value;
  final String label;

  const Social({
    required this.label,
    required this.value,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      label: json['label'] as String,
      value: json['value'] as String,
    );
  }
}
