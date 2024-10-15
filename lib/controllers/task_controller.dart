import 'package:get/get.dart';
import 'package:movie/models/favorite_movie_model.dart';
import 'package:movie/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskController extends GetxController {
  static Database? _db;

  var tasks = <TaskModel>[].obs;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  // Inisialisasi Database dengan onUpgrade untuk migrasi
  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'task_database.db');

    return await openDatabase(
      path,
      version: 4, // Tingkatkan versi untuk migrasi
      onCreate: (db, version) async {
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
            description TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('''
            CREATE TABLE favorite_movies(
              id INTEGER PRIMARY KEY,
              title TEXT,
              description TEXT
            )
          ''');
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    addSampleMovies(); // Panggil fungsi untuk menambahkan data sampel
    loadTasks(); // Load tasks when the controller is initialized
  }

  // Fungsi untuk menambahkan tugas/film
  Future<int> addMovie(TaskModel task) async {
    var dbClient = await db;
    int result = await dbClient!.insert('tasks', task.toMap());
    loadTasks(); // Muat ulang semua data setelah menambah
    return result;
  }

  // Fungsi untuk mendapatkan semua tugas/film dari database
  Future<void> loadTasks() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    print('Jumlah film yang dimuat: ${queryResult.length}'); // Tambahkan log ini
    tasks.assignAll(queryResult.map((data) => TaskModel.fromMap(data)).toList());
  }

  // Fungsi untuk mengupdate data tugas/film
  Future<int> updateMovie(TaskModel task) async {
    var dbClient = await db;
    int result = await dbClient!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await loadTasks(); // Pastikan untuk memuat ulang data setelah memperbarui
    return result;
  }

  // Fungsi untuk menghapus data tugas/film berdasarkan ID
  Future<void> deleteMovie(int id) async {
    var dbClient = await db;
    await dbClient!.delete('tasks', where: 'id = ?', whereArgs: [id]);
    await loadTasks(); // Pastikan untuk memuat ulang data setelah menghapus
  }

  // Fungsi untuk menambahkan beberapa film (sampel)
  void addSampleMovies() async {
    // Hapus semua film yang ada sebelum menambahkan yang baru
    await deleteAllMovies(); // Tambahkan fungsi ini untuk menghapus semua film

    List<TaskModel> movies = [
      TaskModel(
        title: 'Inception',
        description: 'A mind-bending thriller about dreams within dreams.',
        imageUrl: 'lib/assets/inception.png', // Ganti dengan path placeholder
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
      await addMovie(movie); // Pastikan untuk menunggu hingga film ditambahkan
    }
  }

  // Fungsi untuk mengambil semua film
  Future<List<TaskModel>> fetchMovies() async {
    var dbClient = await db;
    List<Map<String, dynamic>> queryResult = await dbClient!.query('tasks');
    return queryResult.map((data) => TaskModel.fromMap(data)).toList();
  }

  Future<void> deleteAllMovies() async {
    var dbClient = await db;
    await dbClient!.delete('tasks'); // Menghapus semua film dari tabel
  }

  Future<void> addFavoriteMovie(FavoriteMovieModel movie) async {
    var dbClient = await db;
    await dbClient!.insert('favorite_movies', {
      'id': movie.id,
      'title': movie.title,
      'description': movie.description,
    });
  }

  Future<void> deleteFavoriteMovie(int id) async {
    var dbClient = await db;
    print("Deleting favorite movie with id: $id"); // Log untuk debugging
    await dbClient!.delete('favorite_movies', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoriteMovieModel>> fetchFavoriteMovies() async {
    var dbClient = await db;
    // Tambahkan log untuk debugging
    print("Fetching favorite movies from database...");
    List<Map<String, dynamic>> queryResult = await dbClient!.query('favorite_movies');
    return queryResult.map((data) => FavoriteMovieModel(
      id: data['id'],
      title: data['title'],
      description: data['description'], imageUrl: '',
    )).toList();
  }
}
