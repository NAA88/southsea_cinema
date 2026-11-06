import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  movie.title.toUpperCase(),
                  style: cinemaFilmTitleStyle.copyWith(
                    color: cinemaBrand,
                    fontSize: 22,
                  ),
                ),
                Text('(${movie.ageRating})', style: cinemaMutedStyle),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  movie.posterPath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(movie.synopsis, style: cinemaBodyStyle),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('BOOK TICKETS', style: cinemaBodyStyle),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(movie.screeningTime, style: cinemaBodyStyle),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('Book now pressed for ${movie.title}');
                  },
                  style: cinemaButtonStyle,
                  child: const Text('BOOK NOW'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
