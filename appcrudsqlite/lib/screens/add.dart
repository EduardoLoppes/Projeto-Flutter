import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbgeek.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController nomeProduto = TextEditingController();

  TextEditingController rollno = TextEditingController();

  TextEditingController tipoProduto = TextEditingController();

  TextEditingController precoProduto = TextEditingController();

  TextEditingController fornecedorProduto = TextEditingController();

  //test editing controllers for form

  DBgeek mydb = DBgeek(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Adicionar produto"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nomeProduto,
                decoration: const InputDecoration(
                  hintText: "Nome do produto",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: const InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: tipoProduto,
                decoration: const InputDecoration(
                  hintText: "Tipo do produto",
                ),
              ),
              TextField(
                controller: precoProduto,
                decoration: const InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              TextField(
                controller: fornecedorProduto,
                decoration: const InputDecoration(
                  hintText: "Nome do fornecedor",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO books(nomeProduto, roll_no, TipoProduto, precoProduto, fornecedorProduto) VALUES (?, ?, ?, ?, ?);",
                        [
                          nomeProduto.text,
                          rollno.text,
                          tipoProduto.text,
                          precoProduto.text,
                          fornecedorProduto.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Produto Adicionado")));

                    nomeProduto.text = "";

                    rollno.text = "";

                    tipoProduto.text = "";

                    precoProduto.text = "";

                    fornecedorProduto.text = " ";
                  },
                  child: Text("Salvar Produto")),
            ],
          ),
        ));
  }
}
