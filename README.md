# Pendahuluan
Proyek analisis data ini bertujuan untuk mengeksplorasi pasar kerja Data Analyst secara komprehensif. Melalui serangkaian kueri SQL, proyek ini mengidentifikasi tren gaji, skill yang paling banyak dicari (in-demand skills), hingga menentukan skill paling optimal yang menawarkan kombinasi antara permintaan pasar yang tinggi dan potensi gaji yang besar.

SQL queries? cek disini : [project_sql folder](/project_sql/)

# Latar Belakang 
Pasar kerja bidang data berkembang sangat cepat, sehingga calon Data Analyst sering kali bingung dalam menentukan prioritas skill yang harus dipelajari. Mempelajari semua tool data secara bersamaan bukanlah strategi yang efisien. Oleh karena itu, proyek analisis ini dibuat untuk menjawab pertanyaan-pertanyaan kunci berbasis data:
1. Apa saja pekerjaan Data Analyst dengan gaji tertinggi?
2. Skill apa saja yang dibutuhkan oleh pekerja dengan gaji tertinggi tersebut?
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

### 2. Skill untuk Pekerjaan Bergaji Tinggi (Skills for Top-Paying Jobs) 
Dengan menggabungkan data 10 pekerjaan tertinggi menggunakan CTE (WITH) dan INNER JOIN, terungkap bahwa lowongan bergaji tinggi tidak hanya meminta skill teknis dasar, tetapi juga kemampuan memproses data berskala besar dan manipulasi cloud.

```SQL
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
)

SELECT
    top_paying_jobs.*,
    skills
from
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order by
    salary_year_avg DESC
```

Berikut adalah 10 skills dengan pekerjaan bergaji tertinggi

![Skills for Top-Paying Jobs](asset\2_Top_paying_jobs_skills.png) 

Berdasarkan hasil pemrosesan data terhadap posisi Data Analyst dengan tingkat kompensasi tertinggi ditemukan 3 pola utama kebutuhan industri:
- SQL dan Python Menjadi Keterampilan Utama Pekerja Bergaji Tertinggi: SQL menduduki posisi pertama sebagai keterampilan yang paling banyak disyaratkan oleh pekerjaan bergaji tertinggi dengan frekuensi 8 kali kemunculan. Sedangkan Python berada di posisi kedua dengan frekuensi 7 kali kemunculan, menunjukkan bahwa penguasaan bahasa pemrosesan data menjadi penentu utama dalam mencapai batas gaji teratas.
- Tableau Sangat Mendominasi Kebutuhan Visualisasi Data :Tableau menjadi alat Business Intelligence (BI) prioritas utama pada posisi bergaji tinggi dengan 6 kali kemunculan, mengungguli alat BI lainnya.Sedangkan R berada di posisi berikutnya dengan 4 kali kemunculan untuk kebutuhan analisis statistik mendalam pada peran-peran senior.
- Keterampilan Cloud dan Data Engineering Meningkatkan Nilai Tawar Gaji : Alat ekosistem data seperti Snowflake, Pandas, dan Excel dibutuhkan masing-masing sebanyak 3 kali pada lowongan bergaji tinggi.
Selain itu penguasaan teknologi cloud dan kolaborasi tim seperti Azure, Bitbucket, dan Go hadir sebanyak 2 kali, menjadi nilai tambah penting untuk mencapai tingkat kompensasi puncak. 

### 3. Skill Paling Dicari (Most In-Demand Skills)

Menggunakan fungsi agregasi COUNT() dan GROUP BY, analisis pada seluruh postingan kerja Data Analyst menunjukkan bahwa SQL, Excel, dan Python secara konsisten mendominasi posisi 3 teratas sebagai skill wajib bagi seorang Data Analyst.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Berikut adalah grafik skill yang paling dicari
![Most Demanded Skills](asset\3_most_demanded_skills.png) 

Berdasarkan grafik "Most Demanded Skills in the Data Job Market", berikut adalah 3 poin utama analisis permintaan keterampilan di pasar kerja secara umum 

- SQL Mendominasi Permintaan Pasar Kerja: SQL menjadi keterampilan yang paling banyak dicari dengan total permintaan mencapai 7.291. Jumlah ini unggul jauh dibandingkan keterampilan lainnya, membuktikan bahwa kemampuan pengelolaan basis data adalah fondasi utama bagi seorang Data Analyst.
- Excel dan Python Menjadi Alat Pemrosesan Data Utama: Excel berada di posisi kedua dengan 4.611 permintaan, menunjukkan alat spreadsheet tradisional masih sangat dibutuhkan di industri. Python menyulut di posisi ketiga dengan 4.330 permintaan, menjadi bahasa pemrograman paling populer untuk manipulasi data dan analisis statistik.
- Tableau dan Power BI Memenuhi Kebutuhan Visualisasi Data: Tableau mencatatkan permintaan sebanyak 3.745, menjadikannya alat Business Intelligence (BI) yang paling diminati secara umum.
Power BI melengkapi daftar top 5 dengan 2.609 permintaan sebagai solusi visualisasi data interaktif bagi perusahaan.


### 4. Skill Berdasarkan Rata-rata Gaji (Top Skills by Salary)

Menggunakan fungsi AVG(), analisis ini mengevaluasi nilai ekonomis dari tiap skill. Skill bernilai jual paling tinggi cenderung merupakan skill teknis spesifik seperti Big Data tools (misal: PySpark, Databricks) atau bahasa pemrograman analisis tingkat lanjut.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Berikut adalah tabel Keterampilan Berdasarkan Rata-Rata Gaji
| Nama Skill    | Rata-Rata Gaji Tahunan (USD)   |
|:--------------|:-------------------------------|
| Pyspark       | $208,172                       |
| Bitbucket     | $189,155                       |
| Couchbase     | $160,515                       |
| Watson        | $160,515                       |
| Datarobot     | $155,486                       |
| Gitlab        | $154,500                       |
| Swift         | $153,750                       |
| Jupyter       | $152,777                       |
| Pandas        | $151,821                       |
| Elasticsearch | $145,000                       |

Berdasarkan data 10 keterampilan dengan rata-rata gaji tertinggi untuk posisi Data Analyst, berikut adalah 3 poin utama analisis pasar kerja:
- Big Data dan Machine Learning Memimpin Gaji Tertinggi : PySpark menduduki posisi puncak dengan gaji $208,172/tahun, membuktikan pengolahan Big Data memiliki nilai kompensasi terbesar.
- Penguasaan Tools DevOps dan Version Control Sangat Dihargai : Bitbucket ($189,155) dan GitLab ($154,500) menempati papan atas, menunjukkan analis yang menguasai alur kerja pengembangan perangkat lunak dibayar lebih tinggi.
- Ekosistem Python dan Cloud Menjadi Standar Kompensasi Tinggi : Tools data science seperti Jupyter ($152,777) dan Pandas ($151,821) serta platform cloud seperti Databricks ($141,907) secara konsisten memberikan gaji di atas $140,000/tahun.


### 5. Skill Paling Optimal (High Demand + High Paying)

Menggabungkan indikator popularitas (COUNT) dan indikator gaji (AVG) dengan filter tambahan HAVING COUNT(...) > 10, analisis ini menemukan skill terbaik untuk dipelajari.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10 
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Berikut adalah scatter plot yang memvisualisasikan titik temu antara High Demand dan High Paying

![High Demand vs High Paying](asset\5_optimal_skills_scatter.png)


Berdasarkan grafik tersebut menunjukkan: 
- Python dan Tableau Menjadi Fondasi Utama Pasar Kerja :Python (236 permintaan, $101,397) dan Tableau (230 permintaan, $99,288) mendominasi dari sisi volume permintaan pasar, menjadikannya dua keterampilan yang paling aman dan menjamin ketersediaan lapangan kerja paling tinggi dengan gaji yang tetap sangat kompetitif.
- Snowflake dan Azure Menempati Titik Temu (Sweet Spot) Paling Optimal: Snowflake (37 permintaan, $112,948) dan Azure (34 permintaan, $111,225) berhasil menyeimbangkan volume permintaan yang relatif tinggi dengan kompensasi gaji di atas rata-rata, menjadikannya pilihan investasi keterampilan paling efisien untuk akselerasi karier.
- Spesialisasi Cloud dan Data Engineering Memberikan Premi Gaji Tertinggi: Keterampilan seperti Go ($115,320), Confluence ($114,210), dan Hadoop ($113,193) menawarkan tingkat kompensasi tertinggi meskipun dengan volume permintaan yang lebih niche (spesifik), menunjukkan bahwa keahlian infrastruktur modern dihargai sangat tinggi oleh industri.

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
