//centralizaremos nuestro sqflite usando singleton
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  //CREACIÓN DE BASE DE DATOS

  //usaremos una varianle de tipo Database, sera el encargado de getionar todo
  Database? _myDatabase;

  //*CREAREMOS UN SINGLETON*
  //step.2.- otro constructor pero creando un objeto instancia con el step.1
  static final DBAdmin _instance = DBAdmin._mandararina();
  //step.1.- necesitamos un constructor con nombre
  DBAdmin._mandararina();
  //step.3 nos creamos nuestro factory
  factory DBAdmin() {
    //retorna nuestra instancia
    return _instance;
  }

  //con esto verificamos la base de datos ya fue creada o no
  Future<Database?> _checkDatabase() async {
    //!mi base de datos es nullo entonces
    if (_myDatabase == null) {
      //!creamos nuestra base de datos
      _myDatabase = await _initDataBase();
    }
    //si es null
    return _myDatabase;
  }

  //antes vamos a verificar donde creamos nuestra base de datos
  //!añadimos el Future<Database> para realizar un retorno de tipo dataBase
  Future<Database> _initDataBase() async {
    //por defecto la funciona ara referencia a la libreria
    //este el objeto no que nos ayudara donde se a instaló nuestra data
    Directory directory =
        await getApplicationDocumentsDirectory(); //--> path_provider

    //nos creamos la ruta exacta donde vamos a crear nuestra DB
    //pondremos el nombre y la extención "DBBooks.db"| join = unir
    String pathDatabase = join(directory.path, "DBBooks.db"); //--> path

    //CREAR LA BASE DE DATOS
    //!al agregar await convertimos en un Database y deja ser Future  y retornamos!!!
    return await openDatabase(
      //-->sqflite
      //con pathDatabase= asgnamos el directorio y el nombre
      pathDatabase,
      //la versión que tendra
      version: 1,
      //Database db = es quien maneja las sentencias sql
      onCreate: (Database db, int version) async {
        //con esto ejecuatamos nuestro comando SQL
        await db.execute(
          "CREATE TABLE BOOK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, description TEXT, image TEXT)",
        );
      },
    ); //-->sqflite
  }

//Consultas
  getBook() async {
    Database? db = await _checkDatabase();
    //con el rawQuery te permite mandar una sentencias SQL
    //pasamos el curso por el "db!." nos aparece el tipo de dato que es
    List data = await db!.rawQuery("SELECT * FROM BOOK");
    print(data);
    //con eso mostramo de una forma organizada
    data.forEach((element) {
      print(element);
    });
  }

//inser ciones de forma directa
  insertBookRaw() async {
    //preguntamos si tiene o no una db para crearlos o solo retornar la DB
    Database? db = await _checkDatabase();
    //realizamos una inserción al frio
    int value = await db!.rawInsert(
        //los valoes a insertar en los campos
        "INSERT INTO BOOK(title,author,description,image) VALUES ('The Lord of the ring','JRR Tolkin','Leren Impson','http://image...')");
    // print(value);
  }

  insertBook() async {
    Database? db = await _checkDatabase();
    //el insert nos ayuda a inserta pero con mapas
    db!.insert(
      "BOOK",
      {
        "title": "Yawar Fiesta",
        "author": "José MariaArguedas",
        "description": "Loren impsonnnn",
        "image": "htpp://wwww.image...."
      },
    );
  }

//Actualizaciones
  updateBook() async {
    Database? db = await _checkDatabase();
  }
//eliminar
}
