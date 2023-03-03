import 'package:codigo6_books/db/db_admin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DBAdmin().getBook();
              },
              child: const Text(
                "Select",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //nos creamos una instancia de nuestra clase DBAdmin
                // DBAdmin admin = DBAdmin();
                // y luego realizamos la llamda
                // admin.initDataBase();
                //con esto ejecutaremos nuestra sntencia SQL
                // admin.insertBook();

                //*Realizamos la llamada usando singleton*
                DBAdmin().insertBook();
                //como aparecen varios de nuestras funciones que deberias de ser
                // privado agregamos el _ en nuestro db_admin las funciones
                //que no deben mostrarse
              },
              child: const Text(
                "insert",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
