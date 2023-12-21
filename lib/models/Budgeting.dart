/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Budgeting type in your schema. */
class Budgeting extends amplify_core.Model {
  static const classType = const _BudgetingModelType();
  final String id;
  final String? _main_category;
  final double? _weekly_expenditure;
  final double? _weekly_limit;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BudgetingModelIdentifier get modelIdentifier {
      return BudgetingModelIdentifier(
        id: id
      );
  }
  
  String? get main_category {
    return _main_category;
  }
  
  double? get weekly_expenditure {
    return _weekly_expenditure;
  }
  
  double? get weekly_limit {
    return _weekly_limit;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Budgeting._internal({required this.id, main_category, weekly_expenditure, weekly_limit, createdAt, updatedAt}): _main_category = main_category, _weekly_expenditure = weekly_expenditure, _weekly_limit = weekly_limit, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Budgeting({String? id, String? main_category, double? weekly_expenditure, double? weekly_limit}) {
    return Budgeting._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      main_category: main_category,
      weekly_expenditure: weekly_expenditure,
      weekly_limit: weekly_limit);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Budgeting &&
      id == other.id &&
      _main_category == other._main_category &&
      _weekly_expenditure == other._weekly_expenditure &&
      _weekly_limit == other._weekly_limit;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Budgeting {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("main_category=" + "$_main_category" + ", ");
    buffer.write("weekly_expenditure=" + (_weekly_expenditure != null ? _weekly_expenditure!.toString() : "null") + ", ");
    buffer.write("weekly_limit=" + (_weekly_limit != null ? _weekly_limit!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Budgeting copyWith({String? main_category, double? weekly_expenditure, double? weekly_limit}) {
    return Budgeting._internal(
      id: id,
      main_category: main_category ?? this.main_category,
      weekly_expenditure: weekly_expenditure ?? this.weekly_expenditure,
      weekly_limit: weekly_limit ?? this.weekly_limit);
  }
  
  Budgeting copyWithModelFieldValues({
    ModelFieldValue<String?>? main_category,
    ModelFieldValue<double?>? weekly_expenditure,
    ModelFieldValue<double?>? weekly_limit
  }) {
    return Budgeting._internal(
      id: id,
      main_category: main_category == null ? this.main_category : main_category.value,
      weekly_expenditure: weekly_expenditure == null ? this.weekly_expenditure : weekly_expenditure.value,
      weekly_limit: weekly_limit == null ? this.weekly_limit : weekly_limit.value
    );
  }
  
  Budgeting.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _main_category = json['main_category'],
      _weekly_expenditure = (json['weekly_expenditure'] as num?)?.toDouble(),
      _weekly_limit = (json['weekly_limit'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'main_category': _main_category, 'weekly_expenditure': _weekly_expenditure, 'weekly_limit': _weekly_limit, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'main_category': _main_category,
    'weekly_expenditure': _weekly_expenditure,
    'weekly_limit': _weekly_limit,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<BudgetingModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<BudgetingModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final MAIN_CATEGORY = amplify_core.QueryField(fieldName: "main_category");
  static final WEEKLY_EXPENDITURE = amplify_core.QueryField(fieldName: "weekly_expenditure");
  static final WEEKLY_LIMIT = amplify_core.QueryField(fieldName: "weekly_limit");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Budgeting";
    modelSchemaDefinition.pluralName = "Budgetings";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Budgeting.MAIN_CATEGORY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Budgeting.WEEKLY_EXPENDITURE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Budgeting.WEEKLY_LIMIT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BudgetingModelType extends amplify_core.ModelType<Budgeting> {
  const _BudgetingModelType();
  
  @override
  Budgeting fromJson(Map<String, dynamic> jsonData) {
    return Budgeting.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Budgeting';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Budgeting] in your schema.
 */
class BudgetingModelIdentifier implements amplify_core.ModelIdentifier<Budgeting> {
  final String id;

  /** Create an instance of BudgetingModelIdentifier using [id] the primary key. */
  const BudgetingModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'BudgetingModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BudgetingModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}