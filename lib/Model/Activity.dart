class Activity {
  String activty_id='';
  String activity_name='';


  Activity(this.activty_id, this.activity_name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'activty_id': activty_id,
      'activity_name': activity_name,
    };
    return map;
  }

  Activity.fromMap(Map<String, dynamic> map) {
    activty_id = map['activty_id'];
    activity_name = map['activity_name'];
  }

}