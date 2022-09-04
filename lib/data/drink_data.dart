import 'package:equatable/equatable.dart';

class DrinkData extends Equatable {
  const DrinkData(this.id, this.name, this.description, this.fileName);

  final int id;
  final String name;
  final String description;
  final String fileName;

  @override
  List<Object> get props => [name, description, fileName];

  factory DrinkData.fromJson(Map<String, dynamic> json) {
    return DrinkData(json['id'], json['name'], json['description'], json['fileName']);
  }
}
