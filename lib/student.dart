class student
{
  String? id,name,contact,city,image;


  student(this.id, this.name, this.contact, this.city, this.image);

  factory student.fromMap(Map m)
  {
    return student(m['id'], m['name'], m['contact'], m['city'], m['image']);
  }

  @override
  String toString() {
    return 'student{id: $id, name: $name, contact: $contact, city: $city, image: $image}';
  }
}