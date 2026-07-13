import 'package:basedatos_sqlite/database_helper.dart';
import 'package:basedatos_sqlite/entities/Product.dart';
import 'package:flutter/material.dart';


class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de productos'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un precio';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _correoController,
              decoration: const InputDecoration(
                labelText: 'Correo',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un correo';
                }
                return null;
              },
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final parsedPrice = double.tryParse(_priceController.text);
                if (parsedPrice == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('El precio debe ser un número válido'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final productoNuevo = Product(
                  name: _nameController.text,
                  price: parsedPrice,
                  description: _descriptionController.text,
                  correo: _correoController.text,
                );

                await DatabaseHelper.instance.createProduct(productoNuevo);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Producto agregado correctamente'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context, true);
              },
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
    ),
    );
  }
}