import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Recursive input objects', () {
    test(
      'Artemis won\'t StackOverflow on recursive input objects',
      () async => testGenerator(
        query: query,
        schema: r'''
          type Mutation {
            mut(input: Input!): String
          }

          input Input {
            and: Input
            or: Input
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
      ),
    );
  });
}

const query = r'''
mutation custom($input: Input!) {
  mut(input: $input)
}
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query.graphql', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$Mutation',
      classes: [
        ClassDefinition(
            name: ClassName(name: r'Custom$Mutation'),
            properties: [
              ClassProperty(
                  type: r'String',
                  name: VariableName(name: r'mut'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: ClassName(name: r'Input'),
            properties: [
              ClassProperty(
                  type: r'Input',
                  name: VariableName(name: r'and'),
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'Input',
                  name: VariableName(name: r'or'),
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: r'Input', name: VariableName(name: r'input'), isNonNull: true)
      ],
      generateHelpers: false,
      suffix: r'Mutation')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$Mutation with EquatableMixin {
  Custom$Mutation();

  factory Custom$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Custom$MutationFromJson(json);

  String mut;

  @override
  List<Object> get props => [mut];
  Map<String, dynamic> toJson() => _$Custom$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Input with EquatableMixin {
  Input({this.and, this.or});

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  Input and;

  Input or;

  @override
  List<Object> get props => [and, or];
  Map<String, dynamic> toJson() => _$InputToJson(this);
}
''';
