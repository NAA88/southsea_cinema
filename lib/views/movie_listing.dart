import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

const String filmtitle = "Nosferatu";
const String filmDescription =
    "An American Gothic horror film written and directed by Robert Eggers. It is a remake of  "
    "Nosferatu: A Symphony of Horror (1922), which was in turn inspired by Bram Stoker's novel "
    "Dracula (1897); the film combines elements of both. It stars Bill Skarsgård, Nicholas Hoult, Lily-"
    "Rose Depp, Aaron Taylor-Johnson,"
    "A gothic tale of obsession between a haunted young woman and the terrifying vampire"
    "infatuated with her, causing untold horror in its wake.";

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
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(filmtitle, style: cinemaHeaderStyle),
              const SizedBox(height: 8.0),
              Text(
                filmDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ));
  }
}
