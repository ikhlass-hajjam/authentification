class Event{
  final String title;
  final  String descrption;
  final humeur;
  final bool isAllDay;

 const Event( {

   required this.descrption,
   required this.humeur,
   required this.title,
   this.isAllDay= false,

 });
}