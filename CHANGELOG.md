# CHANGELOG

## gate-1 — Fondasi Smart Kost Mobile

### 1. Jadi
- Membuat halaman pemilihan role Tenant dan Owner.
- Mengimplementasikan Dashboard Tenant dan Dashboard Owner.
- Mengimplementasikan fitur pembuatan dan riwayat komplain penghuni.
- Mengimplementasikan pengelolaan status komplain oleh Owner: Menunggu, Diproses, dan Selesai.
- Menggunakan `ComplaintData` sebagai pengelola data sementara yang digunakan bersama oleh kedua role.
- Mengimplementasikan validasi input pada formulir komplain.
- Menguji tampilan pada konfigurasi HP portrait, HP landscape, dan tablet.

### 2. Macet
- Pada tahap pengembangan halaman Owner, `flutter analyze` sempat menunjukkan error karena halaman detail komplain belum dibuat, sementara halaman daftar sudah memanggilnya.
- Masalah diselesaikan dengan membuat `OwnerComplaintDetailScreen` dan menghubungkannya dengan halaman daftar komplain.
- Pengujian berikutnya menunjukkan `flutter analyze` berhasil tanpa issue.

### 3. Keputusan
- Menggunakan satu instance `ComplaintData` untuk Tenant dan Owner agar kedua role mengakses data komplain yang sama.
- Memisahkan model komplain, pengelolaan data, dan tampilan ke dalam folder berbeda agar kode lebih terstruktur.
- Memilih penyimpanan sementara di memori untuk G1 daripada langsung menggunakan database atau REST API karena persistensi dan jaringan merupakan cakupan G2.

### 4. AI
- **Bagian yang dibantu AI:** perancangan UI, struktur navigasi, pembuatan halaman Owner, pengelolaan status komplain, dan pemeriksaan error kode.
- **Satu prompt kunci:** [Tempel satu prompt yang benar-benar pernah digunakan, salin persis dari percakapan.]
- **Perubahan manual:** menyesuaikan kode dengan struktur folder project, menyambungkan `ComplaintData` ke kedua role, menguji hasil di Chrome, serta memperbaiki kode berdasarkan hasil `flutter analyze` dan pengujian aplikasi.
- **Alasan:** memastikan implementasi sesuai kebutuhan Smart Kost Mobile dan kriteria G1, bukan sekadar menerima kode AI tanpa pengujian.

### Video Demo
https://youtu.be/ZPYe_ZkrQGM