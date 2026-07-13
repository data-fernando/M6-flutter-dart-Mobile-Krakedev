import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basedatos_sqlite/database_helper.dart';
import 'package:basedatos_sqlite/entities/Product.dart';

void main() {
  group('DatabaseHelper', () {
    final dbHelper = DatabaseHelper.instance;

    setUpAll(() {
      // Inicializa una sola vez antes de todos los tests
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    tearDown(() async {
      // Limpia la tabla después de cada test
      final db = await dbHelper.database;
      await db.delete('products');
    });

    test('createProduct', () async {
      final product = Product(name: 'Test', price: 10.0, description: 'Test', correo: 'test@test.com');
      final createdProduct = await dbHelper.createProduct(product);
      expect(createdProduct.id, isNotNull);
    });

    test('getProduct', () async {
      final product = Product(name: 'Test', price: 10.0, description: 'Test', correo: 'test@test.com');
      final createdProduct = await dbHelper.createProduct(product);
      final retrievedProduct = await dbHelper.getProduct(createdProduct.id!);
      expect(retrievedProduct.id, createdProduct.id);
    });

    test('getProducts', () async {
      final product = Product(name: 'Test', price: 10.0, description: 'Test', correo: 'test@test.com');
      await dbHelper.createProduct(product);
      final products = await dbHelper.getProducts();
      expect(products.length, 1);
    });

    test('updateProduct', () async {
      final product = Product(name: 'Test', price: 10.0, description: 'Test', correo: 'test@test.com');
      final createdProduct = await dbHelper.createProduct(product);
      final updatedProduct = await dbHelper.updateProduct(
        createdProduct.copyWith(price: 20.0),
      );
      expect(updatedProduct.price, 20.0);
    });

    test('deleteProduct', () async {
      final product = Product(name: 'Test', price: 10.0, description: 'Test', correo: 'test@test.com');
      final createdProduct = await dbHelper.createProduct(product);
      final deleted = await dbHelper.deleteProduct(createdProduct.id!);
      expect(deleted, true);
    });
  });
}
