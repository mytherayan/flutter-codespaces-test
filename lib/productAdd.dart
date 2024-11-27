import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();
  final TextEditingController metaDescriptionController = TextEditingController();

  List<String> selectedColors = ['White'];
  Set<String> selectedSizes = {};
  List<String> sizes = [];
  List<Map<String, dynamic>> variations = [];

  final List<String> availableColors = [];

  // For Image Upload Placeholder
  String productThumbnail = '';
  Map<String, String> colorWiseImages = {};
  List<String> additionalImages = [];

  void generateVariations() {
    variations.clear();
    for (var color in selectedColors) {
      for (var size in sizes) {
        variations.add({
          'color': color,
          'size': size,
          'price': priceController.text,
          'sku': '$color-$size',
          'stock': 1,
        });
      }
    }
    setState(() {});
  }

  void addSizesFromInput() {
    // final inputSizes = sizeController.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    // sizes = inputSizes;
    // generateVariations();
    // Instead of splitting the input text, we directly use the selected sizes
    sizes = selectedSizes.toList();  // Convert Set to List if needed
    generateVariations();
  }


void submitProduct() async {
  final url = 'http://mystic.great-site.net/admin_dashboard/create_product.php'; // Update with your URL

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'product_name': productNameController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'sku': skuController.text,
      'category': 'Electronics', // Replace with actual category from UI
      'sub_category': 'Mobiles', // Replace with actual subcategory from UI
      'youtube_link': youtubeLinkController.text,
      'meta_description': metaDescriptionController.text,
      'product_thumbnail': productThumbnail,  // Image URL from upload
      'colors': selectedColors,
      'sizes': selectedSizes.toList(),
      'color_wise_images': colorWiseImages,  // color-wise image paths
      'additional_images': additionalImages,
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product created successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create product')));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Unable to reach the server')));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Tabs
              DefaultTabController(
                length: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        labelText: "Product Name (EN)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Description (EN)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // General Setup
              Text(
                "General Setup",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      ),
                      items: ['Electronics', 'Fashion', 'Home']
                          .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Sub Category",
                        border: OutlineInputBorder(),
                      ),
                      items: ['Mobiles', 'Clothes', 'Furniture']
                          .map((subCategory) => DropdownMenuItem(
                        value: subCategory,
                        child: Text(subCategory),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: skuController,
                decoration: InputDecoration(
                  labelText: "SKU",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Pricing
              Text(
                "Pricing & Others",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "₹ Unit Price",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              // Product Variation Setup
              Text(
                "Product Variation Setup",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
           
              MultiSelectDropdown(
                items: ['White', 'Black', 'Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Pink'],
                selectedItems: selectedColors,
                label: "Colors",
                onChanged: (updatedColors) {
                  setState(() {

                    selectedColors = updatedColors;
                    addSizesFromInput();
                  });
                },
              ),
              SizedBox(height: 16),
              TagInputField(
                chips: selectedSizes,
                onChanged: (updatedSizes) {
                  setState(() {
                    selectedSizes = updatedSizes;
                    addSizesFromInput();
                  });
                },
              ),

              SizedBox(height: 16),

              // Variations Table
              DataTable(
                columnSpacing: 100 ,
                columns: [
                  DataColumn(label: Text("Color")),
                  DataColumn(label: Text("Size")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("SKU")),
                  DataColumn(label: Text("Stock")),
                ],
                rows: variations.map((variation) {
                  return DataRow(cells: [
                    DataCell(Text(variation['color'])),
                    DataCell(Text(variation['size'])),
                    DataCell(Text(variation['price'])),
                    DataCell(Text(variation['sku'])),
                    DataCell(Text(variation['stock'].toString())),
                  ]);
                }).toList(),
              ),
              SizedBox(height: 16),

              // Image Upload Section
              Text(
                "Product Images",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
                  SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 16),
              ImageUploadField(
                label: "Product Thumbnail",
                onUploaded: (path) {
                  productThumbnail = path;
                },
              ),
              SizedBox(width: 16),
             Column(
              children: [
                 Text("Color Wise Product Images"),
              Wrap(
                spacing: 8,
                children: selectedColors.map((color) {
                  return ImageUploadField(
                    label: color,
                    onUploaded: (path) {
                      colorWiseImages[color] = path;
                    },
                  );
                }).toList(),
              ),
              ],
             ),
              SizedBox(width: 16),
              ImageUploadField(
                label: "Additional Images",
                onUploaded: (path) {
                  additionalImages.add(path);
                },
              ),
              SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 16),

              // Product Video
              Text(
                "Product Video",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: youtubeLinkController,
                decoration: InputDecoration(
                  labelText: "Youtube Video Link",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // SEO Section
              Text(
                "SEO Section",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: metaDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Meta Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text("Index"),
                  SizedBox(width: 8),
                  Checkbox(value: false, onChanged: (value) {}),
                  Text("No Index"),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed:submitProduct,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MultiSelectDropdown extends StatefulWidget {
  final List<String> items; // List of all items
  final List<String> selectedItems; // Currently selected items
  final String label; // Label for the field
  final Function(List<String>) onChanged; // Callback to handle selection changes

  MultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.label,
    required this.onChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: widget.selectedItems.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () {
                // Remove the item from the selection
                List<String> updatedSelection = List.from(widget.selectedItems);
                updatedSelection.remove(item);
                widget.onChanged(updatedSelection);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 8),
       
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: "Select ${widget.label}",
            border: OutlineInputBorder(),
          ),
          value: null, // Do not change the value to null here directly



    items:widget.items
              // .where((item) => !widget.selectedItems.contains(item)) // Filter unselected items
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ))
              .toList(),

          onChanged: (value) {

            if (value != null) {
              // Add the selected item to the selection

              // Update state: do not set value to null directly
              setState(() {
                // After adding the selected item, we do not need to clear the field by setting value to null.
                // Just remove the value from the dropdown items list.
                List<String> updatedSelection = List.from(widget.selectedItems);
                // updatedSelection.add(value!);
                // Add the value only if it's not already in the list
                if (!updatedSelection.contains(value)) {
                  updatedSelection.add(value);
                }
                // Call the widget's onChanged callback with the updated selection
                widget.onChanged(updatedSelection);
              });




            }
          },
        )


      ],
    );
  }
}

class TagInputField extends StatefulWidget {
  final Set<String> chips; // Expose chips as a parameter
  final Function(Set<String>) onChanged; // Callback for changes

  const TagInputField({
    super.key,
    required this.chips,
    required this.onChanged,
  });

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  late Set<String> chips; // Locally manage chips
  final controller = TextEditingController();
  late FocusNode inputFieldNode;

  @override
  void initState() {
    super.initState();
    chips = widget.chips;
    inputFieldNode = FocusNode();
  }

  @override
  void dispose() {
    inputFieldNode.dispose();
    controller.dispose();
    super.dispose();
  }

  void _addChip(String value) {
    if (value.isNotEmpty) {
      setState(() {
        chips.add(value);
      });
      widget.onChanged(chips);
      controller.clear();
      FocusScope.of(context).requestFocus(inputFieldNode);
    }
  }

  void _removeChip(String value) {
    setState(() {
      chips.remove(value);
    });
    widget.onChanged(chips);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          ...chips.map(
                (chip) => Chip(
              label: Text(chip),
              onDeleted: () => _removeChip(chip),
            ),
          ),
          SizedBox(
            width: 100,
            child: TextField(
              controller: controller,
              focusNode: inputFieldNode,
              onSubmitted: _addChip,
              decoration: InputDecoration(
                hintText: "Enter size",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageUploadField extends StatelessWidget {
  final String label;
  final Function(String) onUploaded;

  ImageUploadField({
    required this.label,
    required this.onUploaded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.cloud_upload),
        ),
      ],
    );
  }
}

