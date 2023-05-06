import 'dart:io';

void main() async {
  FileSystemEntity entity = Directory.current;

  var dir = Directory(entity.absolute.path);

  Stream<File> files = recursiveFunction(dir);

  files.listen((File file) {
    print(file.path.split(entity.absolute.path + '\\').last);
  });
}

Stream<File> recursiveFunction(Directory directory) async* {
  var listOfDirectory = directory.list();
  await for (final entity in listOfDirectory) {
    if (entity is File) {
      yield entity;
    } else if (entity is Directory) {
      // print(File(entity.path).uri.pathSegments.last + ' - ');
      yield* recursiveFunction(Directory(entity.path));
    }
  }
}
