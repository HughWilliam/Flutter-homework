import 'package:flutter/material.dart';
import 'package:reload/product.dart';

class Product1 extends StatefulWidget {
  const Product1({super.key});

  @override
  State<Product1> createState() => _ProductStage();
}

class _ProductStage extends State<Product1> {
  bool isLoading = false;
  bool updateValid = false;
  int productIndex = 0;
  bool edit = false;
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void delay() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  bool _validatorProperties() {
    bool check = true;
    if (_nameController.text.isNotEmpty &&
        _imageController.text.isNotEmpty &&
        _detailController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      check = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Mời bạn nhập thêm thông tin!'),
      ));
      check = false;
    }
    for (int i = 0; i < products.length; i++) {
      if (_nameController.text == products[i].name) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Tên sản phẩm đã tồn tại!'),
        ));
        check = false;
      }
    }
    return check;
  }

  void _addProduct() {
    setState(() {
      if (_validatorProperties()) {
        products.add(Product(
            name: _nameController.text,
            imageUrl: _imageController.text,
            price: double.parse(_priceController.text),
            details: _detailController.text));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Thêm sản phẩm thành công!'),
        ));
      }
      isLoading = true;
      delay();
    });
  }

  void _editProduct(int index) {
    setState(() {
      productIndex = index;
      _nameController.text = products[index].name;
      _imageController.text = products[index].imageUrl;
      _detailController.text = products[index].details;
      _priceController.text = products[index].price.toString();
      edit = true;
    });
  }

  void _validChangInf() {
    setState(() {
      if (_nameController.text != products[productIndex].name ||
          _imageController.text != products[productIndex].imageUrl ||
          _detailController.text != products[productIndex].details ||
          _priceController.text != products[productIndex].price.toString()) {
        updateValid = true;
      } else {
        updateValid = false;
      }
    });
  }

  void _updateProduct() {
    setState(() {
      products[productIndex] = Product(
          name: _nameController.text,
          imageUrl: _imageController.text,
          price: double.parse(_priceController.text),
          details: _detailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cập nhật thành công!'),
      ));
      _validChangInf();
      isLoading = true;
      delay();
    });
  }

  void _deleteProduct(String name) {
    setState(() {
      products.removeWhere((product) => product.name == name);
    });
  }

  final List<Product> products = [
    Product(
      name: 'ABC',
      imageUrl: 'https://i.postimg.cc/MTtsXC7T/pngwing-com.png',
      details: 'This is the detail of Product 1.',
      price: 29.99,
    ),
    Product(
      name: 'CDF',
      imageUrl: 'https://i.postimg.cc/MTtsXC7T/pngwing-com.png',
      details: 'This is the detail of Product 2.',
      price: 19.99,
    ),
    Product(
      name: 'HGG',
      imageUrl: 'https://i.postimg.cc/MTtsXC7T/pngwing-com.png',
      details: 'This is the detail of Product 3.',
      price: 59.99,
    ),
    Product(
      name: 'WQA',
      imageUrl: 'https://i.postimg.cc/MTtsXC7T/pngwing-com.png',
      details: 'This is the detail of Product 4.',
      price: 9.99,
    ),
    Product(
      name: 'HGDS',
      imageUrl: 'https://i.postimg.cc/MTtsXC7T/pngwing-com.png',
      details: 'This is the detail of Product 5.',
      price: 9.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Maneger'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "Product Name",
                        ),
                        onChanged: (String value) {
                          _validChangInf();
                        },
                      ),
                      TextFormField(
                        controller: _imageController,
                        decoration: const InputDecoration(
                          labelText: "Image URL",
                        ),
                        onChanged: (String value) {
                          _validChangInf();
                        },
                      ),
                      TextFormField(
                        controller: _detailController,
                        decoration: const InputDecoration(
                          labelText: "Product Details",
                        ),
                        onChanged: (String value) {
                          _validChangInf();
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Product Price",
                        ),
                        onChanged: (String value) {
                          _validChangInf();
                        },
                      ),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isLoading ? null : _addProduct,
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : const Text('Add Product'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : (updateValid && edit ? _updateProduct : null),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : const Text('Update Product'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Card(
                    child: ListTile(
                      //leading: Image.network(product.imageUrl),
                      title: Text(product.name),
                      subtitle: Text(product.details),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editProduct(index),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteProduct(product.name);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ));
  }
}
