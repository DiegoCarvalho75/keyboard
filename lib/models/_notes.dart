// import 'dart:convert';
// 
// class Note {
//   final String? octave;
//   final int? midiNumber;
//   final String? noteName;
//   final int? distancia;
//   Note({
//     this.octave,
//     this.midiNumber,
//     this.noteName,
//     this.distancia,
//   });
// 
//   Map<String, dynamic> toMap() {
//     return {
//       'octave': octave,
//       'midiNumber': midiNumber,
//       'noteName': noteName,
//       'distancia': distancia,
//     };
//   }
// 
//   factory Note.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
// 
//     return Note(
//       octave: map['octave'],
//       midiNumber: map['midiNumber']?.toInt(),
//       noteName: map['noteName'],
//       distancia: map['distancia']?.toInt(),
//     );
//   }
// 
//   String toJson() => json.encode(toMap());
// 
//   factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
// 
//   @override
//   String toString() {
//     return 'Notes(octave: $octave, midiNumber: $midiNumber, noteName: $noteName, distancia: $distancia)';
//   }
// }
