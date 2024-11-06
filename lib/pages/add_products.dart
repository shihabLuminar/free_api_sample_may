import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_bloc.dart';
import 'package:free_api_sample_may/blocs/home/home_event.dart';
import 'package:free_api_sample_may/blocs/home/home_state.dart';
import 'package:free_api_sample_may/blocs/product_adding/adding_bloc.dart';
import 'package:free_api_sample_may/blocs/product_adding/adding_state.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _categoryController = TextEditingController();

  // Function to validate and submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, print details (in a real app, send to backend)
      print("Product Added");
      print("Name: ${_nameController.text}");
      print("Description: ${_descriptionController.text}");
      print("Price: ${_priceController.text}");
      print("Stock: ${_stockController.text}");
      print("Category: ${_categoryController.text}");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: BlocListener<AddingBloc, AddingState>(
        listener: (context, state) {},
        child: BlocBuilder<AddingBloc, AddingState>(
          builder: (context, state) {
            if (state is ProductAddingState) {
              return CircularProgressIndicator();
            }
            if (state is AddingInitial) {
              log("message");
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          if (value.length < 3 || value.length > 50) {
                            return 'Name must be between 3 and 50 characters';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          final price = double.tryParse(value);
                          if (price == null || price <= 0) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _stockController,
                        decoration: InputDecoration(labelText: 'Stock'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter stock quantity';
                          }
                          final stock = int.tryParse(value);
                          if (stock == null || stock < 0) {
                            return 'Please enter a valid stock quantity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(labelText: 'Category'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Add Product'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
