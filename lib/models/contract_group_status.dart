// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContractGroupStatus {
  final int id;
  final String name;
  ContractGroupStatus({
    required this.id,
    required this.name,
  });

  ContractGroupStatus copyWith({
    int? id,
    String? name,
  }) {
    return ContractGroupStatus(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory ContractGroupStatus.fromMap(Map<String, dynamic> map) {
    return ContractGroupStatus(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContractGroupStatus.fromJson(String source) =>
      ContractGroupStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContractGroupStatus(id: $id, name: $name)';

  @override
  bool operator ==(covariant ContractGroupStatus other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
