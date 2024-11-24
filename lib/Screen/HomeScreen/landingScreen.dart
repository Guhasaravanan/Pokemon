import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pokemon/Services/pokemon_Provider.dart';
import 'package:pokemon/utils/common.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    final pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);
    pokemonProvider.fetchPokemon();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        deleteSnackbarMessage('Error signing out: $e'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pokémon App',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Confirm Logout',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      content: Text(
                        'Are you sure you want to logout?',
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel',
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent)),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text('Logout',
                              style:
                                  GoogleFonts.poppins(color: Colors.redAccent)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await _signOut(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Home',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                child: Text(
                  'Favorites',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Home Tab
            pokemonProvider.pokemonList.isEmpty && !pokemonProvider.isLoading
                ? Center(
                    child: Text(
                      'No Pokémon found.',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!pokemonProvider.isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        pokemonProvider.fetchPokemon();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: pokemonProvider.pokemonList.length +
                          (pokemonProvider.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < pokemonProvider.pokemonList.length) {
                          final pokemon = pokemonProvider.pokemonList[index];
                          final isFavorite = pokemonProvider.favoritePokemon
                              .any((fav) => fav['name'] == pokemon['name']);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              elevation: 3,
                              child: ListTile(
                                title: Text(
                                  pokemon['name'],
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    if (isFavorite) {
                                      pokemonProvider.removeFavorite(pokemon);
                                    } else {
                                      pokemonProvider.addFavorite(pokemon);
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),

            // Favorites Tab
            pokemonProvider.favoritePokemon.isEmpty
                ? Center(
                    child: Text(
                      'No favorites added yet.',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: pokemonProvider.favoritePokemon.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemonProvider.favoritePokemon[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              pokemon['name'],
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  pokemonProvider.removeFavorite(pokemon),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
