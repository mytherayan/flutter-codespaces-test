
import 'dart:io';
import 'package:flutter_app/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'dashboard.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final List<Map<String, dynamic>> _categories = [];
  String? _selectedPriority;
  File? _selectedImage;

  final List<String> _priorities = ['1', '2', '3', '4', '5'];
  late CategoryDataSource _categoryDataSource;

  @override
  void initState() {
    super.initState();
    _categoryDataSource = CategoryDataSource(_categories);
  }


  PlatformFile? _selectedFile;
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: kIsWeb, // Use bytes for web
      withReadStream: !kIsWeb, // Use stream for mobile
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.first;

      setState(() {
        _selectedFile = pickedFile;
      });
    }

  }



  Widget _buildImage(PlatformFile file) {
    if (kIsWeb) {
      // On the web, use bytes
      return file.bytes != null
          ? Image.memory(
        file.bytes!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      )
          : const Text('No image available');
    } else {
      // On mobile, use the file path
      return file.path != null
          ? Image.file(
        File(file.path!),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      )
          : const Text('No image available');
    }
  }



  void _addCategory() {
    print(_selectedFile);
    print(_selectedFile);
    print(_selectedFile);
    print(_selectedFile);
    print(_selectedFile);
    if (_categoryNameController.text.isNotEmpty &&
        _selectedPriority != null

    ) {
      setState(() {
        _categories.add({
          'name': _categoryNameController.text,
          'priority': _selectedPriority!,
          'image': '_selectedImage!.path',
          // 'image': _selectedImage!.path,
        });
        _categoryDataSource.buildDataSource();
      });

      _categoryNameController.clear();
      _selectedPriority = null;
      _selectedImage = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
    }
  }

  Future<void> _exportToExcel() async {
    final workbook = xlsio.Workbook();
    final sheet = workbook.worksheets[0];

    // Add header
    sheet.getRangeByIndex(1, 1).setText('ID');
    sheet.getRangeByIndex(1, 2).setText('Category Name');
    sheet.getRangeByIndex(1, 3).setText('Priority');

    // Add data rows
    for (int i = 0; i < _categories.length; i++) {
      sheet.getRangeByIndex(i + 2, 1).setNumber(i + 1);
      sheet.getRangeByIndex(i + 2, 2).setText(_categories[i]['name']);
      sheet.getRangeByIndex(i + 2, 3).setText(_categories[i]['priority']);
    }

    // Save Excel file
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/CategoryList.xlsx';
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);

    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Category Setup')),
      body: Responsive(
        mobile: _buildCategoryScreen(context, 1),
        tablet: _buildCategoryScreen(context, 2),
        desktop: _buildCategoryScreen(context, 3),
      ),
    );
  }

  Widget _buildCategoryScreen(BuildContext context, int columns) {
    final Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [

          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Add Category',
                    style: TextStyle(fontSize: defaultPadding*2, fontWeight: FontWeight.bold),
                  ),
                  _size.width > 750 ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height)/(defaultPadding/4),
                        width: (MediaQuery.of(context).size.width)/(defaultPadding/5),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            TextField(
                              controller: _categoryNameController,
                              decoration: const InputDecoration(
                                labelText: 'Category Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedPriority,
                              items: _priorities
                                  .map((priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(priority),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedPriority = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Priority',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Container(  height: (MediaQuery.of(context).size.height)/(defaultPadding/4),
                        width: (MediaQuery.of(context).size.width)/(defaultPadding/5),

                        child:  Center(child: Container(
                          height: defaultPadding*11,
                          width: defaultPadding*11,
                          decoration: BoxDecoration(
                            color:_selectedFile != null
                                ? Colors.transparent : Colors.grey.shade300,
                            border: Border.all(
                              color: Colors.black,  // Color of the border
                              width: 1.0,  // Thickness of the border
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),  // Radius of the corners (adjust as needed)
                            ),
                          ),
                          child: _selectedFile != null
                              ? _buildImage(_selectedFile!) :Center(child: Icon(Icons.image,size: defaultPadding*3)),
                        ),),)
                    ],
                  ):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          TextField(
                            controller: _categoryNameController,
                            decoration: const InputDecoration(
                              labelText: 'Category Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedPriority,
                            items: _priorities
                                .map((priority) => DropdownMenuItem(
                              value: priority,
                              child: Text(priority),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width)/(defaultPadding/10),

                        child:  Center(child: Container(
                          height: defaultPadding*11,
                          width: defaultPadding*11,
                          decoration: BoxDecoration(
                            color:_selectedFile != null
                                ? Colors.transparent : Colors.grey.shade300,
                            border: Border.all(
                              color: Colors.black,  // Color of the border
                              width: 1.0,  // Thickness of the border
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),  // Radius of the corners (adjust as needed)
                            ),
                          ),
                          child: _selectedFile != null
                              ? _buildImage(_selectedFile!) :Center(child: Icon(Icons.image,size: defaultPadding*3)),
                        ),),),
                      const SizedBox(height: 16),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Choose Image'),
                      ),

                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _categoryNameController.clear();
                          setState(() {
                            _selectedPriority = null;
                            _selectedImage = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text('Reset'),
                      ),
                      ElevatedButton(
                        onPressed: _addCategory,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: defaultPadding*2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Category List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _exportToExcel,
                icon: const Icon(Icons.download),
                label: const Text('Export to Excel'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SfDataGrid(
              source: _categoryDataSource,
              allowSorting: true,
              allowFiltering: true,
              columnWidthMode: ColumnWidthMode.none,
              columns: [
                GridColumn(
                  columnName: 'ID',
                  width: _size.width/8,
                  label: const Center(child: Text('ID')),
                ),
                GridColumn(
                  columnName: 'Image',
                  width: _size.width/6,
                  label: const Center(child: Text('Category Image')),
                ),
                GridColumn(
                  columnName: 'Name',
                  width: _size.width/4,
                  label: const Center(child: Text('Name')),
                ),
                GridColumn(
                  columnName: 'Priority',
                  width: _size.width/5,
                  label: const Center(child: Text('Priority')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryDataSource extends DataGridSource {
  final List<Map<String, dynamic>> categories;
  List<DataGridRow> _dataGridRows = [];

  CategoryDataSource(this.categories) {
    buildDataSource();
  }

  void buildDataSource() {
    _dataGridRows = categories
        .asMap()
        .entries
        .map(
          (entry) => DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'ID', value: entry.key + 1),
          DataGridCell<String>(columnName: 'Image', value: entry.value['image']),
          DataGridCell<String>(columnName: 'Name', value: entry.value['name']),
          DataGridCell<String>(columnName: 'Priority', value: entry.value['priority']),
        ],
      ),
    )
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Center(child: Text(row.getCells()[0].value.toString())),
      Image.asset("assets/ic_launcher.png", width: 50, height: 50),
      // Image.file(File(row.getCells()[1].value), width: 50, height: 50),
      Text(row.getCells()[2].value),
      Text(row.getCells()[3].value),
    ]);
  }
}
