import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'] ?? 'Detalhes'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (posterUrl != null)
              Center(child: Image.network(posterUrl))
            else
              Container(
                height: 200,
                color: Colors.grey,
                child: Center(child: Text('Sem imagem')),
              ),
            SizedBox(height: 16),
            Text(
              movie['title'] ?? 'Título indisponível',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nota: ${movie['vote_average']?.toString() ?? 'N/A'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              movie['overview'] ?? 'Sem descrição disponível.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
