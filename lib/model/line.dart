import 'dart:convert';

class Line {
  // ignore: non_constant_identifier_names
  int? id_line;
  String? name;
  String? description;
  String? shift;
  String? operators;
  String? head;
  // ignore: non_constant_identifier_names
  String? id_spv;
  String? floor;

  Line(
      // ignore: non_constant_identifier_names
      {this.id_line,
      this.name,
      this.description,
      this.shift,
      this.operators,
      this.head,
      // ignore: non_constant_identifier_names
      this.id_spv,
      this.floor});

  factory Line.fromJson(Map<String, dynamic> map) {
    return Line(
        id_line: map['id_line'],
        name: map['name'],
        description: map['description'],
        shift: map['shift'],
        operators: map['operators'],
        head: map['head'],
        id_spv: map['id_spv'],
        floor: map['floor']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_line": id_line,
      "name": name,
      "description": description,
      "shift": shift,
      "operators": operators,
      "head": head,
      "id_spv": id_spv,
      "floor": floor
    };
  }

  @override
  String toString() {
    return 'Line{id_line: $id_line, name: $name, description: $description, shift: $shift, operators: $operators, head: $head, id_spv: $id_spv, floor: $floor}';
  }

  List<Line> lineFromJson(String jsonData) {
    final data = json.decode(jsonData);

    return List<Line>.from(data.map((item) => Line.fromJson(item)));
  }

  String lineToJson(Line data) {
    final jsonData = data.toJson();

    return json.encode(jsonData);
  }
}
