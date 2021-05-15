class Feeling {
  int index;
  String image;
  String title;
  String description;

  Feeling({
    this.index,
    this.image,
    this.title,
    this.description,
  });

  Feeling.fromJson(Map<String, dynamic> json) {
    this.image = json['image'];
    this.title = json['title'];
    this.description = json['description'];
  }

  @override
  String toString() {
    return 'Feeling{index: $index, image: $image, title: $title, description: $description}';
  }
}
