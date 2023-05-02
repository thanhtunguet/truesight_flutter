part of 'repositories.dart';

/// Repository that manipulates files
abstract class FileRepository extends Repository {
  /// Write data to file sync
  void writeFileSync(File file, dynamic content);

  /// Write data to file async
  Future<void> writeFile(File file, dynamic content);

  /// Read data from file sync
  void readFileSync(File file, dynamic content);

  /// Read data from file async
  Future<void> readFile(File file, dynamic content);

  /// Create new file sync
  void createNewFileSync(String path) {}

  /// Create new file async
  Future<void> createNewFile(String path);

  /// Unlink (delete) a file sync
  void unlinkSync(String path);

  /// Unlink (delete) a file async
  Future<void> unlink(String path);
}
