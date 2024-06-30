import 'package:flutter/material.dart';
import 'package:homework/product.dart';

class Product1 extends StatefulWidget {
  const Product1({super.key});

  @override
  State<Product1> createState() => _ProductStage();
}

class _ProductStage extends State<Product1> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  String _selectedLetter = 'All';
  bool _showWrap = false;
  int _wrapCount = 6;
  int _nameLength = 0;
  bool _checkNameLength = false;

  void _toggleWrap() {
    setState(() {
      _showWrap = !_showWrap;
      _wrapCount = _showWrap ? 27 : 6;
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

  void _maxLength() {
    for (int i = 0; i < products.length; i++) {
      if (products[i].name.length > _nameLength) {
        setState(() {
          _checkNameLength = true;
          _nameLength = products[i].name.length;
        });
      }
    }
  }

  void _minLength() {
    for (int i = 0; i < products.length; i++) {
      if (products[i].name.length < _nameLength) {
        setState(() {
          _checkNameLength = true;
          _nameLength = products[i].name.length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Filter by Price',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            RangeSlider(
                values: _currentRangeValues,
                max: 100,
                divisions: 10,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                }),
            const SizedBox(height: 5),
            const Text(
              'Filter by Alphabet',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Wrap(
                    spacing: 5.0,
                    children: List.generate(_wrapCount, (index) {
                      String letter =
                          index == 0 ? 'All' : String.fromCharCode(64 + index);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ChoiceChip(
                          label: Text(letter),
                          selected: _selectedLetter == letter,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedLetter = selected ? letter : 'All';
                            });
                          },
                        ),
                      );
                    }),
                  ),
                  TextButton(
                    onPressed: _toggleWrap,
                    child: Text(_showWrap ? 'Show Less' : 'Show More'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Filter by Name Length',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: const Text('Longest Name'),
                  selected: _nameLength == 4,
                  onSelected: (bool selected) {
                    setState(() {
                      _maxLength();
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Shortest Name'),
                  selected: _nameLength == 3,
                  onSelected: (bool selected) {
                    setState(() {
                      _minLength();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  if (_currentRangeValues.start <= product.price &&
                      product.price <= _currentRangeValues.end &&
                      (_selectedLetter == 'All' ||
                          product.name.startsWith(_selectedLetter))) {
                    if (_checkNameLength) {
                      if (_nameLength == product.name.length) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(product.imageUrl),
                            title: Text(product.name),
                            subtitle: Text(product.details),
                            trailing: Text('\$${product.price}'),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return Card(
                        child: ListTile(
                          leading: Image.network(product.imageUrl),
                          title: Text(product.name),
                          subtitle: Text(product.details),
                          trailing: Text('\$${product.price}'),
                        ),
                      );
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
