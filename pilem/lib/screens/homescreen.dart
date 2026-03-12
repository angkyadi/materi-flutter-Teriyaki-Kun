import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detailscreen.dart';
import 'package:pilem/services/apiservices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final ApiServices _apiService = ApiServices();
    List<Movie> _allMovies = [];
    List<Movie> _trendingMovies = [];
    List<Movie> _popularMovies = [];

    Future<void> _loadMovies() async {
      final List<Map<String, dynamic>> allMoviesData = await _apiService
          .getAllMovies();
      final List<Map<String, dynamic>> trendingMoviesData = await _apiService
          .getTrendingMovies();
      final List<Map<String, dynamic>> popularMoviesData = await _apiService
          .getPopularMovies();

      setState(() {
        _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
        _trendingMovies = trendingMoviesData
            .map((e) => Movie.fromJson(e))
            .toList();
        _popularMovies = popularMoviesData
            .map((e) => Movie.fromJson(e))
            .toList();
      });
    }
  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildMovieList("All Movie", _allMovies),
          _buildMovieList("Trending Movie", _trendingMovies),
          _buildMovieList("Popular Movie", _popularMovies),
        ],
      ),
    );
  }

  Widget _buildMovieList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext build, int index) {
              final Movie movie = movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(movie: movie),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        movie.title.length > 14
                            ? '${movie.title.substring(0, 10)}...'
                            : movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}