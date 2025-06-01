class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String? description; // ✅ Ajout optionnel

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    this.description, // ✅ Paramètre optionnel
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'] ?? 'Titre inconnu',
      author: json['volumeInfo']['authors']?.join(', ') ?? 'Auteur inconnu',
      imageUrl: json['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
      description: json['volumeInfo']['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      imageUrl: map['imageUrl'],
      description: map['description'],
    );
  }
}