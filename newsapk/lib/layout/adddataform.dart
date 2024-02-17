import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newsapk/bloc/addnews_bloc.dart';
import 'package:file_picker/file_picker.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final TextEditingController _judul = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _date = TextEditingController();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _pickedImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _judul,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _deskripsi,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: _date,
              decoration: InputDecoration(labelText: 'Tanggal'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formatteddate =
                      DateFormat('yyyy-mm-dd').format(pickedDate);
                  setState(() {
                    _date.text = formatteddate;
                  });
                }
              },
            ),
            _pickedImage != null
                ? Container(
                    height: 300,
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ))
                : SizedBox.shrink(),
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg'],
                  );
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _pickedImage = File(result.files.single.path!);
                    });
                  }
                },
                child: Text("Ambil gambar")),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_pickedImage != null) {
                  _judul.text = "";
                  _deskripsi.text = "";
                  _date.text = "";

                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text("Tidak ada gambar"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text("Silahkan lengkapi data"),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("ok"))
                            ],
                          ));
                } else {
                  final title = _judul.text;
                  final content = _deskripsi.text;
                  final date = _date.text;
                  final image = _pickedImage;

                  context.read<AddnewsBloc>().add(ClikTombolAddEvent(
                      title: title, desc: content, date: date, img: image!));
                }
                // Fungsi untuk menyimpan data
                // Implementasikan logika sesuai kebutuhan Anda
              },
              child: Text('Simpan Data'),
            ),
            if (_pickedImage != null)
              Image.file(
                _pickedImage!,
                height: 100.0,
                width: 100.0,
              ),
          ],
        ),
      ),
    );
  }
}
