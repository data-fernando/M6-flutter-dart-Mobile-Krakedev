import 'package:flutter/material.dart';
import 'package:navegacionflutter/entities/clientes.dart';


class CustomersPage extends StatelessWidget {
  CustomersPage({Key? key}) : super(key: key);

  final List<Customer> customers = [
    Customer(name: 'Pedro Alvarado', email: 'cliente1@mail.com', phone: '099111111'),
    Customer(name: 'Marlon quispe', email: 'cliente2@mail.com', phone: '099222222'),
    Customer(name: 'Rodrigo basantes', email: 'cliente3@mail.com', phone: '099333333'),
    Customer(name: 'Emilia Betancour', email: 'cliente4@mail.com', phone: '099444444'),
    Customer(name: 'Raul vasquez', email: 'cliente5@mail.com', phone: '099555555'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Customers ListViewBuilder')),
        backgroundColor: Colors.tealAccent,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context, '/homepage2');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.teal),
              title: Text(
                customer.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${customer.email}\nTel: ${customer.phone}"),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
