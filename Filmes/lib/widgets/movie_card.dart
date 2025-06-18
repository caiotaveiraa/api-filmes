import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Map movie;
  final VoidCallback onTap;

  const MovieCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w200${movie['poster_path']}'
        : null;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: posterUrl != null
            ? Image.network(posterUrl, width: 50, fit: BoxFit.cover)
            : Container(width: 50, color: Colors.grey),
        title: Text(movie['title'] ?? 'Título indisponível'),
        subtitle: Text(
          movie['overview'] ?? 'Sem descrição.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}
