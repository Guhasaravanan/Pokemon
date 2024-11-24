import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> _favoritePokemon = [];
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 20;

  List<Map<String, dynamic>> get pokemonList => _pokemonList;
  List<Map<String, dynamic>> get favoritePokemon => _favoritePokemon;
  bool get isLoading => _isLoading;

  Future<void> fetchPokemon() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$_offset&limit=$_limit');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> results =
            List<Map<String, dynamic>>.from(data['results']);

        _pokemonList.addAll(results);
        _offset += _limit;
      }
    } catch (error) {
      debugPrint('Error fetching Pokémon data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFavorites() async {
    if (user == null) return;

    try {
      final snapshot = await firestore
          .collection('favorites')
          .doc(user!.uid)
          .collection('pokemon')
          .get();

      _favoritePokemon = snapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching favorites: $error');
    }
  }

  Future<void> addFavorite(Map<String, dynamic> pokemon) async {
    if (user == null) return;

    try {
      await firestore
          .collection('favorites')
          .doc(user!.uid)
          .collection('pokemon')
          .doc(pokemon['name'])
          .set(pokemon);

      _favoritePokemon.add(pokemon);
      notifyListeners();
    } catch (error) {
      debugPrint('Error adding favorite: $error');
    }
  }

  Future<void> removeFavorite(Map<String, dynamic> pokemon) async {
    if (user == null) return;

    try {
      await firestore
          .collection('favorites')
          .doc(user!.uid)
          .collection('pokemon')
          .doc(pokemon['name'])
          .delete();

      _favoritePokemon.removeWhere((fav) => fav['name'] == pokemon['name']);
      notifyListeners();
    } catch (error) {
      debugPrint('Error removing favorite: $error');
    }
  }
}
