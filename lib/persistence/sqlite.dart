import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Open the database and store the reference
  final Future<Database> database = openDatabase(
    // Set the path to the database.
    // Note: Using the 'join' function from the
    // 'path' package is best practice to ensure the
    // path is correcty constructed for each platform
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database
        return db.execute(
            "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
      },
      version: 1
  );

  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database
    final Database db = await database;

    // Insert eh Dog into the correct table. You might also specify the
    // 'conflictAlgorithm' to use in case the same dog is inserted twice
    //
    // In this case, replace any previous data
    await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  // A method that retrieves all the dogs from the dogs table
  Future<List<Dog>> dogs() async {
    // Get a reference to the database
    final Database db = await database;

    // Query the table for all the Dogs
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic>> into a List<Dog>

    return List.generate(
        maps.length,
        (i) {
          return Dog(
            id: maps[i]['id'],
            name: maps[i]['name'],
            age: maps[i]['age']
          );
        }
    );
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database
    final db = await database;

    //update the given dog
    await db.update(
        'dogs',
        dog.toMap(),
      // Ensure that the dog has a matching id
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection
      whereArgs: [dog.id]
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database
    final db = await database;

    // Remove the Dog form the database
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  // Create a Dog and add it to the table
  final lupe = Dog(
      id: 0,
      name: 'Lupe',
      age: 5
  );

  final milo = Dog(
    id: 1,
    name: 'Milo',
    age: 10
  );
  await insertDog(lupe);
  await insertDog(milo);

  print(await dogs());

  await updateDog(Dog(
    id: 0,
    name: 'Lupe',
    age: 6
  ));

  print(await dogs());

  await deleteDog(1);

  print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age
    };
  }

  @override
  String toString() {
    return 'My name is ${name} and i\'m ${age} years old';
  }
}
