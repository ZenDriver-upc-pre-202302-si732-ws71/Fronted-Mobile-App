
class License{
  int id;
  String category; 
  

  License({required this.id, required this.category});

  License.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
      category = json['category'];

  
  
}