import 'package:get/get.dart';
import 'package:movie/models/favorite_movie_model.dart';
import 'package:movie/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskController extends GetxController {
  static Database? _db;

  var tasks = <TaskModel>[].obs;

  Future<TaskController> init() async {
    await _initDB();
    return this;
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'task_database.db');
    print("Database path: $path");
    
    return await openDatabase(
      path,
      version: 2, // Tingkatkan versi database
      onCreate: (Database db, int version) async {
        print("Creating database tables");
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            isCompleted INTEGER,
            imageUrl TEXT,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
        await db.execute('''
          CREATE TABLE favorite_movies(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            imageUrl TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          // Tambahkan kolom imageUrl ke tabel favorite_movies jika belum ada
          await db.execute('ALTER TABLE favorite_movies ADD COLUMN imageUrl TEXT');
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    _initDB().then((_) {
      addSampleMovies();
      loadTasks();
    });
  }

  // Fungsi untuk menambahkan tugas/film
  Future<int> addMovie(TaskModel task) async {
    var dbClient = await database;
    int result = await dbClient.insert('tasks', task.toMap());
    await loadTasks();
    return result;
  }

  // Fungsi untuk mendapatkan semua tugas/film dari database
  Future<void> loadTasks() async {
    var dbClient = await database;
    List<Map<String, dynamic>> queryResult = await dbClient.query('tasks');
    print('Jumlah film yang dimuat: ${queryResult.length}');
    tasks.assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  // Fungsi untuk mengupdate data tugas/film
  Future<int> updateMovie(TaskModel task) async {
    var dbClient = await database;
    int result = await dbClient.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await loadTasks();
    return result;
  }

  // Fungsi untuk menghapus data tugas/film berdasarkan ID
  Future<void> deleteMovie(int id) async {
    var dbClient = await database;
    await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await loadTasks();
  }

  // Fungsi untuk menambahkan beberapa film (sampel)
  Future<void> addSampleMovies() async {
    await deleteAllMovies();

    List<TaskModel> movies = [
      TaskModel(
        title: 'Inception',
        description: 'A mind-bending thriller about dreams within dreams.',
        imageUrl: 'lib/assets/inception.png',
      ),
       TaskModel(
        title: 'Thor',
        description: 'Thor, the god of thunder.',
        imageUrl: 'lib/assets/thor.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Hulk',
        description: 'The strongest Avenger.',
        imageUrl: 'lib/assets/hulk.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Iron Man',
        description: 'A billionaire industrialist and genius inventor.',
        imageUrl: 'lib/assets/ironman.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Captain America',
        description: 'The first Avenger.',
        imageUrl: 'lib/assets/captainamerica.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Black Panther',
        description: 'The king of Wakanda.',
        imageUrl: 'lib/assets/blackpanther.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Doctor Strange',
        description: 'A former neurosurgeon turned master of the mystic arts.',
        imageUrl: 'lib/assets/doctorstrange.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Guardians of the Galaxy',
        description: 'A group of intergalactic criminals who must pull together to stop a fanatical warrior.',
        imageUrl: 'lib/assets/guardiansofthegalaxy.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Ant-Man',
        description: 'A superhero with the ability to shrink in scale but increase in strength.',
        imageUrl: 'lib/assets/antman.png', // Ganti dengan path placeholder
      ),
      TaskModel(
        title: 'Spider-Man',
        description: 'A young man with spider-like abilities fights crime as a superhero in New York City.',
        imageUrl: 'lib/assets/spiderman.png', // Ganti dengan path placeholder
      ),
    ];

    for (var movie in movies) {
      await addMovie(movie);
    }
  }

  // Fungsi untuk mengambil semua film
  Future<List<TaskModel>> fetchMovies() async {
    var dbClient = await database;
    List<Map<String, dynamic>> queryResult = await dbClient.query('tasks');
    return queryResult.map((data) => TaskModel.fromMap(data)).toList();
  }

  Future<void> deleteAllMovies() async {
    var dbClient = await database;
    await dbClient.delete('tasks');
  }

  Future<void> addFavoriteMovie(FavoriteMovieModel movie) async {
    var dbClient = await database;
    try {
      await dbClient.insert('favorite_movies', movie.toMap());
      print("Favorite movie added successfully: ${movie.title}");
    } catch (e) {
      print("Error adding favorite movie: $e");
    }
  }

  Future<void> deleteFavoriteMovie(int id) async {
    var dbClient = await database;
    try {
      await dbClient.delete('favorite_movies', where: 'id = ?', whereArgs: [id]);
      print("Favorite movie deleted successfully: $id");
    } catch (e) {
      print("Error deleting favorite movie: $e");
    }
  }

  Future<List<FavoriteMovieModel>> fetchFavoriteMovies() async {
    var dbClient = await database;
    print("Fetching favorite movies from database...");
    List<Map<String, dynamic>> queryResult = await dbClient.query('favorite_movies');
    return queryResult.map((data) => FavoriteMovieModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'] ?? '',
    )).toList();
  }
}
