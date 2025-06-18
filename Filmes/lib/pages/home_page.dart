import 'package:flutter/material.dart';
import 'package:filmes/pages/movie_detail_page.dart';
import 'package:filmes/services/movie_service.dart';
import 'package:filmes/widgets/movie_card.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  late Future<List> _movies;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _movies = MovieService.fetchMovies();
  }

  void _searchMovies() {
    FocusScope.of(context).unfocus();
    final query = _searchController.text.trim();
    if (query == _searchQuery) return;
    setState(() {
      _searchQuery = query;
      _movies = MovieService.fetchMovies(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _movies = MovieService.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchMovies,
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: _movies,
        builder: (context, snapshot) {
          if (_isSearching ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return Center(
              child: Text(
                _searchQuery.isEmpty
                    ? 'Nenhum filme popular encontrado.'
                    : 'Nenhum resultado para "$_searchQuery".',
              ),
            );
          }

          return ListView.builder(
            itemCount: movies.length + 1,
            itemBuilder: (context, index) {
              if (index == movies.length) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Feito por Caio Taveira',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                );
              }

              final movie = movies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailPage(movie: movie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Buscar filmes...',
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        fillColor: Colors.grey[850],
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => _searchMovies(),
    );
  }
}
