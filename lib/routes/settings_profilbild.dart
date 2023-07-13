import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Profilbild extends StatefulWidget {
  const Profilbild({Key? key}) : super(key: key);

  @override
  State<Profilbild> createState() => _ProfilbildState();
}

class _ProfilbildState extends State<Profilbild> {
  bool _loading = false;
  bool _loadingDelete = false;
  String path = "";
  String status = "";
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profilbild ändern')),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _info(),
                  const Divider(height: 32, thickness: 3),
                  _selectImage(),
                  const Divider(height: 32, thickness: 3),
                  _change()
                ],
              ),
            )
          ],
        ));
  }

  Widget _info() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Hinweis",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "Das hier hochgeladene Bild wird in den verschiedensten Tools innerhalb vom Schulportal in Verbindung mit Deinem Namen angezeigt.\n")),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "· Auf dem Bild solltest Du gut von vorne (keine Seitenansichten) sichtbar sein.\n\n"
            "· Selbstverständlich musst Du das Urheberrecht an dem hochzuladenden Bild haben oder über eine entsprechende schriftliche Erlaubnis verfügen.\n"
            "· Ebenso darfst nur Du selbst auf dem Bild abgebildet sein (und damit keine weiteren Personen)!\n"
            "· Illegale und/oder pornografische Bilder, die gegen Gesetze verstoßen, oder dem Jugendschutz nicht entsprechen sind verboten!\n"
            "· Durch das Bild darf die Privatsphäre oder die Würde anderer Menschen nicht verletzt werden.\n",
            style: TextStyle(color: Colors.red),
          ),
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mit dem Upload bestätigst Du, dass diese Voraussetzungen erfüllt sind!",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )),
        if (status != "")
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                status,
                style: TextStyle(
                    color: success ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold),
              )),
      ],
    );
  }

  Widget _change() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: path == ""
          ? null
          : () async {
              if (!_loading) {
                if (path != "") {
                  setState(() {
                    _loading = true;
                  });
                  /*backend.changeImage(path).then((value) {
              if (value) {
                setState(() {
                  _loading = false;
                  success = true;
                  status = "Profilbild wurde erfolgreich geändert!";
                });
              } else {
                setState(() {
                  _loading = false;
                  success = false;
                  status = "Profilbild konnte nicht geändert werden!";
                });
              }
            });*/
                }
              }
            },
      child: SizedBox(
          width: double.infinity,
          height: 32,
          child: Align(
              alignment: Alignment.center,
              child: _loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text('Speichern'))),
    );
  }

  Widget _selectImage() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    _resizeImage(image.path);
                  }
                },
                child: const SizedBox(
                    height: 32,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Bild auswählen'))),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    _resizeImage(photo.path);
                  }
                },
                child: const SizedBox(
                    height: 32,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Kamera öffnen'))),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        //path != ""
        //    ? Image.file(File(path))
        //    : Image.file(File("${backend.userDir}/image.png")),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () async {
            if (!_loadingDelete) {
              setState(() {
                _loadingDelete = true;
              });
              /*backend.deleteImage().then((value) {
                if (value) {
                  setState(() {
                    _loadingDelete = false;
                    success = true;
                    status = "Profilbild wurde erfolgreich gelöscht!";
                  });
                } else {
                  setState(() {
                    _loadingDelete = false;
                    success = false;
                    status = "Profilbild konnte nicht gelöscht werden!";
                  });
                }
              });*/
            }
          },
          child: SizedBox(
              width: double.infinity,
              height: 32,
              child: Align(
                  alignment: Alignment.center,
                  child: _loadingDelete
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Bild löschen'))),
        )
      ],
    );
  }

  void _resizeImage(String path) async {
    if (mounted) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.png,
        maxHeight: 400,
        maxWidth: 400,
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Bild zuschneiden',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              dimmedLayerColor:
                  Theme.of(context).primaryColorDark.withOpacity(.75),
              activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
              title: 'Bild zuschneiden',
              aspectRatioLockEnabled: true,
              aspectRatioPickerButtonHidden: true,
              rectHeight: 400,
              rectWidth: 400,
              rectX: 400,
              rectY: 400),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          this.path = croppedFile.path;
        });
      }
    }
  }
}
