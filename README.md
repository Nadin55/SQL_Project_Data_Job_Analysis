# Pendahuluan
Proyek analisis data ini bertujuan untuk mengeksplorasi pasar kerja Data Analyst secara komprehensif. Melalui serangkaian kueri SQL, proyek ini mengidentifikasi tren gaji, skill yang paling banyak dicari (in-demand skills), hingga menentukan skill paling optimal yang menawarkan kombinasi antara permintaan pasar yang tinggi dan potensi gaji yang besar.

SQL queries? cek disini : [project_sql folder](/project_sql/)

# Latar Belakang 
Pasar kerja bidang data berkembang sangat cepat, sehingga calon Data Analyst sering kali bingung dalam menentukan prioritas skill yang harus dipelajari. Mempelajari semua tool data secara bersamaan bukanlah strategi yang efisien. Oleh karena itu, proyek analisis ini dibuat untuk menjawab pertanyaan-pertanyaan kunci berbasis data:
1. Apa saja pekerjaan Data Analyst dengan gaji tertinggi?
2. Skill apa saja yang dibutuhkan oleh pekerjaan bergaji tinggi tersebut?
3. Skill apa yang paling banyak dicari oleh pasar kerja secara umum?
4. Skill apa yang memiliki rata-rata gaji tertinggi?
5. Skill mana yang paling optimal (berada di titik temu antara High Demand dan High Paying)?

# Tools yang digunakan 
Berikut adalah tools yang digunakan 
1. SQL (PostgreSQL): Bahasa utama yang digunakan untuk data extraction, filtering, multi-table joins, dan data aggregation.
2. Visual Studio Code (VS Code): Editor kode tempat penulisan, pengujian, dan eksekusi kueri SQL.
3. Git & GitHub: Versi kontrol untuk mengelola repository dan menyajikan hasil analisis portofolio.

# Analisis

# Apa Yang Dipelajari 

Melalui pengerjaan proyek ini, beberapa kompetensi teknis dan logis yang berhasil dikuasai meliputi:

1. Decomposisi Pertanyaan Bisnis: Kemampuan membedah kebutuhan bisnis menjadi elemen-elemen logika SQL (SELECT, WHERE, GROUP BY, HAVING).
2. Penggunaan Relasi Multi-Tabel (JOIN): Memahami cara menghubungkan tabel fakta (job_postings_fact), tabel perantara/junction table (skills_job_dim), dan tabel dimensi (skills_dim).
3. Penggunaan CTE (Common Table Expression): Menyusun kueri SQL tingkat lanjut secara modular menggunakan klausa WITH agar kode lebih rapi dan efisien.
4. Agregasi Data: Mahir menggunakan kombinasi fungsi agregat (COUNT, AVG, ROUND) bersama GROUP BY dan HAVING untuk menyaring hasil hitungan kelompok.

# Kesimpulan
1. SQL dan Python adalah Skill Fondasi Utama: Keduanya merupakan skill dengan volume permintaan tertinggi yang wajib dikuasai untuk masuk ke industri data.
2. Spesialisasi Meningkatkan Nilai Gaji: Menguasai skill umum saja (seperti Excel) cukup untuk mendapatkan pekerjaan, tetapi mengombinasikannya dengan skill teknik/cloud (seperti Python, SQL, Cloud Data Warehousing) meningkatkan potensi gaji secara signifikan.
3. Strategi Belajar Terbaik: Calon Data Analyst disarankan fokus menguasai skill yang masuk dalam kategori Optimal (seperti SQL, Python, Tableau/Power BI) sebelum berinvestasi waktu mempelajari tools yang terlalu spesifik atau jarang digunakan di pasar kerja.