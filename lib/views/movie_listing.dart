import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

const String filmTitle = "Nosferatu";
const String filmDescription =
    "An American Gothic horror film written and directed by Robert Eggers. It is a remake of  "
    "Nosferatu: A Symphony of Horror (1922), which was in turn inspired by Bram Stoker's novel "
    "Dracula (1897); the film combines elements of both. It stars Bill Skarsgård, Nicholas Hoult, Lily-"
    "Rose Depp, Aaron Taylor-Johnson,"
    "A gothic tale of obsession between a haunted young woman and the terrifying vampire"
    "infatuated with her, causing untold horror in its wake.";

const String filmAgeRating = "18";
const int filmRuntimeMinutes = 133;
const String filmDirector = "Robert Eggers";
const String filmCast =
    "Bill Skarsgård, Nicholas Hoult, Lily-Rose Depp, Aaron Taylor-Johnson";
const String filmScreening = 'Sunday 18 Oct 2026, 14:00';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle, style: cinemaHeaderStyle),
          backgroundColor: cinemaSurface,
          iconTheme: const IconThemeData(color: cinemaBrand),
          elevation: 0,
        ),
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(filmTitle),
                    SizedBox(width: 8),
                    Text('($filmAgeRating)'),
                  ],
                ),
                SizedBox(height: 4),
                Text('$filmRuntimeMinutes min · Dir. $filmDirector'),
                SizedBox(height: 12),
                Text(filmDescription),
                SizedBox(height: 8),
                Text('Starring: $filmCast'),
                SizedBox(height: 16),
                Text('BOOK TICKETS'),
                Divider(),
                Text(filmScreening),
                SizedBox(height: 12),
              ],
            ),
          ),
        ));
  }
}
