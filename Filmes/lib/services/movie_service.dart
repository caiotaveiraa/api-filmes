import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String _apiKey = '06456ce85a3768ec69f359362cf247fd';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List> fetchMovies([String query = '']) async {
    final url = query.isEmpty
        ? '$_baseUrl/movie/popular?api_key=$_apiKey&language=pt-BR&page=1'
        : '$_baseUrl/search/movie?api_key=$_apiKey&language=pt-BR&query=${Uri.encodeQueryComponent(query)}&page=1&include_adult=false';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao carregar filmes');
    }
  }
}
