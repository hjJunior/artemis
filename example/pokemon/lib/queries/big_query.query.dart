// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'big_query.query.g.dart';

@JsonSerializable()
class BigQuery {
  Charmander charmander;
  List<Pokemon> pokemons;

  BigQuery();
  factory BigQuery.fromJson(Map<String, dynamic> json) =>
      _$BigQueryFromJson(json);
  Map<String, dynamic> toJson() => _$BigQueryToJson(this);
}

@JsonSerializable()
class Charmander {
  String number;
  List<String> types;

  Charmander();
  factory Charmander.fromJson(Map<String, dynamic> json) =>
      _$CharmanderFromJson(json);
  Map<String, dynamic> toJson() => _$CharmanderToJson(this);
}

@JsonSerializable()
class Pokemon {
  String number;
  String name;
  List<String> types;
  List<Evolutions> evolutions;

  Pokemon();
  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
class Evolutions {
  String number;
  String name;

  Evolutions();
  factory Evolutions.fromJson(Map<String, dynamic> json) =>
      _$EvolutionsFromJson(json);
  Map<String, dynamic> toJson() => _$EvolutionsToJson(this);
}

Future<BigQuery> executeBigQueryQuery(String graphQLEndpoint,
    {http.Client client}) async {
  final httpClient = client ?? http.Client();
  final dataResponse = await httpClient.post(graphQLEndpoint, body: {
    'operationName': 'big_query',
    'query':
        'query big_query { charmander: pokemon(name: "Charmander") { number types } pokemons(first: 150) { number name types evolutions: evolutions { number name } } }',
  });
  httpClient.close();

  return BigQuery.fromJson(json.decode(dataResponse.body)['data']);
}