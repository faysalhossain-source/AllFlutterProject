class OnlineEmployee {
  final int?id;
  final String name;
  final String email;
  final String designation;
  final int age;
  final String address;
  final String dob; //
  final double salary;
  final String ?image;

  OnlineEmployee( {
       this.id,
        required this.name,
        required this.email,
        required this.designation,
        required this.age,
        required this.address,
        required this.dob,
        required this.salary,
        this.image,

      });

  factory OnlineEmployee.fromJson(Map<String,dynamic>Json){
    return OnlineEmployee(
      id: Json['id'],
        name: Json['name'],
        email:Json['email'],
        designation: Json['designation'],
        age: Json['age'],
        address: Json['address'],
        dob: Json['dob'],
        salary: Json['salary'],
        image: Json['image']
    );
  }

  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'designation':designation,
      'age':age,
      'address':address,
      'dob':dob,
      'salary':salary,
      'image':image,
    };
  }


}