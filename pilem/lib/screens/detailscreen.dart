import 'dart:convert';
import 'package:pilem/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }

  // Check if the movie is already in SharedPreferences
  Future<void> _checkIsFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favMovies = prefs.getStringList('favorite_movies') ?? [];

    // Look for this movie's ID in the saved list
    for (String movieJson in favMovies) {
      Map<String, dynamic> movieMap = jsonDecode(movieJson);
      if (movieMap['id'] == widget.movie.id) {
        setState(() {
          isFavorite = true;
        });
        break;
      }
    }
  }

  // Toggle favorite status and save/remove from SharedPreferences
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favMovies = prefs.getStringList('favorite_movies') ?? [];

    if (isFavorite) {
      // Remove it
      favMovies.removeWhere((movieJson) {
        Map<String, dynamic> movieMap = jsonDecode(movieJson);
        return movieMap['id'] == widget.movie.id;
      });
    } else {
      // Add it
      String jsonString = jsonEncode(widget.movie.toJson());
      favMovies.add(jsonString);
    }

    await prefs.setStringList('favorite_movies', favMovies);

    if (!mounted) return;

    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Overview:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleFavorite();
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.movie.overview),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  const SizedBox(width: 10),
                  const Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.movie.releaseDate),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 10),
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.movie.voteAverage.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}