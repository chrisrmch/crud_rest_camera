import 'package:crud_rest_camara/models/product.dart';
import 'package:crud_rest_camara/providers/product_form_provider.dart';
import 'package:crud_rest_camara/services/products_service.dart';
import 'package:crud_rest_camara/ui/input_decorations.dart';
import 'package:flutter/material.dart';

import 'package:crud_rest_camara/widget/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.selectedProduct),
      child: _ProductScreenBody(productService: productsService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductsService productService;

  const _ProductScreenBody({required this.productService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct.picture,
                ),
                _volverAtrasIcon(context),
                _cameraIcon(),
              ],
            ),
            ProductForm(
              product: productService.selectedProduct,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.save_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Positioned _cameraIcon() {
    return Positioned(
      top: 60,
      right: 20,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Positioned _volverAtrasIcon(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

class ProductForm extends StatelessWidget {
  final Product product;

  const ProductForm({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: _productFormDecoration(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'el nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                onChanged: (value) {
                  if (double.parse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '150€',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: true,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailability(value),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _productFormDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5)
        ]);
  }
}
