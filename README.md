# Aplikasi Kasir Mobile (UTS Pemrograman Mobile 2)

Aplikasi ini adalah simulasi kasir sederhana berbasis Flutter yang menerapkan konsep **State Management** menggunakan **Cubit**. Aplikasi ini memungkinkan pengguna untuk melihat daftar produk, menambahkan produk ke keranjang, mengubah jumlah item, dan melihat total harga secara *real-time*.

---

## 📝 Bagian A – Jawaban Teori (30 Poin)

Berikut adalah jawaban untuk pertanyaan teori pada soal Ujian Tengah Semester:

### 1. Jelaskan perbedaan antara Cubit dan Bloc dalam arsitektur Flutter.

**Cubit** dan **Bloc** keduanya adalah bagian dari paket `flutter_bloc` yang berfungsi untuk memisahkan logika bisnis dari UI, namun memiliki pendekatan yang berbeda:

* **Cubit (Subset dari Bloc):**
    * **Pendekatan:** Berbasis fungsi (*Function-driven*). Perubahan state dipicu dengan memanggil fungsi secara langsung dari UI.
    * **Kompleksitas:** Lebih sederhana dan membutuhkan lebih sedikit kode (*boilerplate*).
    * **Penggunaan:** Cocok untuk manajemen state yang sederhana hingga menengah di mana pelacakan *event* yang kompleks tidak diperlukan.
    * **Alur:** `UI -> Panggil Fungsi Cubit -> Emit State Baru -> UI Rebuild`.

* **Bloc (Business Logic Component):**
    * **Pendekatan:** Berbasis kejadian (*Event-driven*). UI mengirimkan *Event* ke Bloc, lalu Bloc memproses event tersebut menjadi *State*.
    * **Kompleksitas:** Lebih kompleks karena harus mendefinisikan file *Event* terpisah.
    * **Penggunaan:** Cocok untuk logika bisnis yang sangat kompleks, di mana kita perlu melacak riwayat kejadian (*event sourcing*) atau melakukan transformasi event (seperti *debounce* atau *throttle*).
    * **Alur:** `UI -> Add Event -> Bloc (MapEventToState) -> Emit State Baru -> UI Rebuild`.

### 2. Mengapa penting untuk memisahkan antara model data, logika bisnis, dan UI dalam pengembangan aplikasi Flutter?

Pemisahan ini (sering disebut *Separation of Concerns*) sangat krusial karena:

1.  **Maintainability (Kemudahan Perawatan):** Kode menjadi lebih terorganisir. Jika ada *bug* pada perhitungan total harga, pengembang langsung tahu harus memperbaikinya di *Cubit*, tanpa mengganggu kode tampilan (*Widget*).
2.  **Testability (Pengujian):** Logika bisnis (Cubit/Bloc) dapat diuji unit (*Unit Test*) secara independen tanpa memerlukan emulator atau rendering UI.
3.  **Reusability (Dapat Digunakan Kembali):** Model data dan logika bisnis yang sama dapat digunakan oleh berbagai halaman UI yang berbeda.
4.  **Scalability (Skalabilitas):** Memudahkan pengembangan fitur baru tanpa merusak fitur yang sudah ada.

### 3. Sebutkan dan jelaskan minimal tiga state yang mungkin digunakan dalam CartCubit beserta fungsinya.

Dalam konteks aplikasi keranjang belanja, berikut adalah tiga state umum:

1.  **`CartInitial`**:
    * **Fungsi:** State awal ketika aplikasi pertama kali dijalankan. Menandakan keranjang masih kosong (belum ada data) dan belum ada interaksi pengguna.
2.  **`CartLoading`**:
    * **Fungsi:** State sementara yang aktif saat aplikasi sedang melakukan proses asinkron, seperti mengambil data produk dari server atau sedang memproses perhitungan diskon yang berat. UI biasanya menampilkan *loading spinner*.
3.  **`CartLoaded` (atau `CartSuccess`)**:
    * **Fungsi:** State utama yang membawa data keranjang yang valid. State ini berisi daftar item (`List<CartItem>`), total harga, dan total item. UI menggunakan data dari state ini untuk menampilkan daftar belanjaan.

*(Catatan Tambahan: Bisa juga ada `CartError` untuk menangani kegagalan sistem).*

---

## 📱 Bagian B & C – Implementasi Proyek

### Fitur Aplikasi
1.  **Katalog Produk:** Menampilkan daftar produk dalam bentuk Grid.
2.  **Add to Cart:** Menambahkan produk ke keranjang dengan satu klik.
3.  **Cart Badge:** Indikator jumlah item di keranjang pada pojok kanan atas.
4.  **Cart Management:**
    * Menambah kuantitas item (+).
    * Mengurangi kuantitas item (-).
    * Menghapus item dari keranjang.
5.  **Real-time Calculation:** Total harga dan total item berubah otomatis.
6.  **Checkout:** Mengosongkan keranjang.

### Struktur Folder
Proyek ini menggunakan arsitektur yang memisahkan layer data, logika, dan tampilan:

```text
lib/
├── blocs/                # Layer Logika Bisnis (State Management)
│   ├── cart_cubit.dart   # Mengelola logika tambah/hapus/update keranjang
│   └── cart_state.dart   # Definisi state (data keranjang)
├── models/               # Layer Data
│   ├── cart_item.dart    # Model untuk item di dalam keranjang (produk + qty)
│   └── product_model.dart# Model data produk (id, nama, harga, gambar)
├── pages/                # Layer UI (Halaman)
│   ├── cart_home_page.dart    # Halaman utama (Scaffold & AppBar)
│   ├── cart_grid_page.dart    # Tampilan grid produk
│   └── cart_summary_page.dart # Halaman ringkasan keranjang & checkout
├── widgets/              # Widget Reusable
│   └── product_card.dart      # Komponen kartu produk
└── main.dart             # Entry point & BlocProvider
