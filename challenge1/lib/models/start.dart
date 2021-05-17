class Start {
  String logoPath;
  String backgroundPath;
  String title;
  String subtitle;
  String textButton;

  Start.fromJson(Map<String, dynamic> json) {
    this.logoPath = json['logoPath'];
    this.backgroundPath = json['backgroundPath'];
    this.title = json['title'];
    this.subtitle = json['subtitle'];
    this.textButton = json['textButton'];
  }

  @override
  String toString() {
    return 'Start{logoPath: $logoPath, backgroundPath: $backgroundPath,'
        ' title: $title, subtitle: $subtitle, textButton: $textButton}';
  }
}
