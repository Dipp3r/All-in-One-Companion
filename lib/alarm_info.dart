class AlarmInfo{
  final String time;
  late String label;
  late bool ispending;

  AlarmInfo({required this.label,required this.time});

}

class AlarmDoc {
  String userid;
  String id;
  final String label;
  final String time;
  final bool isPending;

  AlarmDoc({required this.label, required this.time, required this.isPending,this.id = '', required this.userid});

  Map<String,dynamic> toJson() => {
    'userid':userid,
    'id':id,
    'label':label,
    'time':time,
    'isPending':isPending
  };

  static AlarmDoc fromJson(Map<String,dynamic> json) => AlarmDoc(
    userid: json['userid'],
    id: json['id'],
    label: json['label'],
    time: json['time'], 
    isPending: json['isPending'],
  );
}