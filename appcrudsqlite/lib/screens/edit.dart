import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbgeek.dart';

class EditProdutos extends StatefulWidget {
  int rollno;

  EditProdutos({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditProdutos();
  }
}

class _EditProdutos extends State<EditProdutos> {
  TextEditingController nomeProduto = TextEditingController();

  TextEditingController rollno = TextEditingController();

  TextEditingController tipoProduto = TextEditingController();

  TextEditingController precoProduto = TextEditingController();

  TextEditingController fornecedorProduto = TextEditingController();

  DBgeek mydb = DBgeek();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getProdutos(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        nomeProduto.text = data["Nome do Produto"];

        rollno.text = data["roll_no"].toString();

        tipoProduto.text = data["Tipo do Produto"];

        precoProduto.text = data["Preço do Produto"];

        fornecedorProduto.text = data["Fornecedor Do Produto"];

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Produtos"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nomeProduto,
                decoration: InputDecoration(
                  hintText: "Nome do Produto",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: tipoProduto,
                decoration: InputDecoration(
                  hintText: "Tipo do Produto",
                ),
              ),
              TextField(
                controller: precoProduto,
                decoration: InputDecoration(
                  hintText: "Preço do Produto",
                ),
              ),
              TextField(
                controller: fornecedorProduto,
                decoration: InputDecoration(
                  hintText: "Fornecedor do Produto",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE Produtos SET nomeProduto = ?, roll_no = ?, tipoProduto = ?, precoProduto=?, fornecedorProduto=? WHERE roll_no = ?",
                        [
                          nomeProduto.text,
                          rollno.text,
                          tipoProduto.text,
                          precoProduto.text,
                          fornecedorProduto.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Produto Alterado!")));
                  },
                  child: Text("Produto Livro")),
            ],
          ),
        ));
  }
}
