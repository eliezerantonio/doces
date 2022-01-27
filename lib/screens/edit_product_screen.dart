import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:danny_doces/models/products/product.dart';
import 'package:danny_doces/widgets/custom_button.dart';
import 'package:danny_doces/widgets/custom_textfield.dart';
import 'package:danny_doces/widgets/messenger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product? product;
  EditProductScreen([Product? p])
      : editing = p != null,
        product = p != null ? p.clone() : Product();
  final bool editing;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  XFile? pickedFile;
  dynamic? imageFile;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey globalKey = GlobalKey();
  late Product? product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    imageFile = product?.image;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        key: globalKey,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );

                        imageFile = File(pickedFile!.path);
                        setState(() {});
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: imageFile == null
                            ? Image.asset(
                                "img/no-image.jpg",
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              )
                            : imageFile is File
                                ? Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  )
                                : Image.network(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    initialValue: widget.product?.name,
                    iconData: Icons.nat,
                    labelText: 'Nome',
                    onSaved: (name) => product!.name = name,
                    validator: (name) {
                      if (name!.trim().isEmpty) {
                        return 'Informe o nome';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    initialValue: widget.product?.price.toString() ?? "0.0",
                    iconData: Icons.money,
                    labelText: 'Preco',
                    keyboardType: TextInputType.number,
                    onSaved: (price) => product!.price = num.tryParse(price!),
                    validator: (price) {
                      // final p = num.parse(price!);
                      if (price!.trim().isEmpty) {
                        return 'Preco invalido';
                      } else if (num.tryParse(price)! < 0) {
                        return 'Preco invalido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    initialValue: widget.product?.description,
                    onSaved: (description) =>
                        product!.description = description!,
                    labelText: "Descricao",
                    iconData: Icons.all_inbox_sharp,
                    validator: (description) {
                      if (description!.trim().isEmpty) {
                        return 'Nome deve ser preenchidos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Salvar",
                    onPressed: () async {
                      if (imageFile == null) {
                        messenger("Selecione uma imagem", context);
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await product!.save(
                            imageFile: imageFile!,
                            onFail: () {
                              messenger("Falha ao cadastrar", context);
                            },
                            onSuccess: () {
                              formKey.currentState!.reset();
                              imageFile = null;
                              messenger("Sucesso ao cadastrar", context);
                            });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  product!.loading
                      ? Center(
                          child: FadeInUp(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.pink[300]!),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
