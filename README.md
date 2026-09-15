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
Proyek ini terbagi menjadi 5 tahap analisis utama berdasarkan kueri SQL yang telah dieksekusi:
### 1. Pekerjaan Gaji Tertinggi (Top-Paying Jobs)
Menganalisis 10 posisi Data Analyst Remote dengan gaji tahunan tertinggi. Hasil menunjukkan bahwa posisi-posisi teratas menawarkan gaji di atas $100.000+ per tahun, di mana sebagian besar peran ini berfokus pada tingkat senioritas atau spesialisasi industri tertentu.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
from
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Berikut adalah hasil dari 10 posisi teratas: 

![Top Paying Data Analyst Jobs](https://raw.githubusercontent.com/Nadin55/SQL_Project_Data_Job_Analysis/main/asset/1_top-paying_data_analyst_jobs_.png) 

Berdasarkan grafik tersebut menunjukkan bahwa 
- Pengaruh Tingkat Jabatan (Seniority Level): Sebagian besar posisi bergaji paling tinggi dipegang oleh peran tingkat kepemimpinan (Director, Associate Director) serta kontributor individu senior (Principal Data Analyst).
- Nilai Spesialisasi Industri: Posisi dengan bidang spesifik seperti Marketing Analytics (Pinterest), Autonomous Vehicles (Motional), Healthcare (UCLA Health), dan Enterprise Risk Management (Get It Recruit) terbukti menawarkan standar gaji yang jauh di atas rata-rata pasar umum.
- Temuan Outlier (Mantys): Posisi Data Analyst di perusahaan Mantys mencatatkan angka ekstrem sebesar $650.000, yang secara statistik menjadi outlier utama dalam data ini (kemungkinan mencakup kompensasi berbasis saham/ekuitas awal).

### Skill untuk Pekerjaan Bergaji Tinggi (Skills for Top-Paying Jobs) 
Dengan menggabungkan data 10 pekerjaan tertinggi menggunakan CTE (WITH) dan INNER JOIN, terungkap bahwa lowongan bergaji tinggi tidak hanya meminta skill teknis dasar, tetapi juga kemampuan memproses data berskala besar dan manipulasi cloud.




### Skill Paling Dicari (Most In-Demand Skills)

Menggunakan fungsi agregasi COUNT() dan GROUP BY, analisis pada seluruh postingan kerja Data Analyst menunjukkan bahwa SQL, Excel, dan Python secara konsisten mendominasi posisi 3 teratas sebagai skill wajib bagi seorang Data Analyst.

### Skill Berdasarkan Rata-rata Gaji (Top Skills by Salary)

Menggunakan fungsi AVG(), analisis ini mengevaluasi nilai ekonomis dari tiap skill. Skill bernilai jual paling tinggi cenderung merupakan skill teknis spesifik seperti Big Data tools (misal: PySpark, Databricks) atau bahasa pemrograman analisis tingkat lanjut.

### Skill Paling Optimal (High Demand + High Paying)

Menggabungkan indikator popularitas (COUNT) dan indikator gaji (AVG) dengan filter tambahan HAVING COUNT(...) > 10, analisis ini menemukan skill terbaik untuk dipelajari.

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
