/*
Pertanyaan: Apa saja pekerjaan analis data dengan gaji tertinggi?
- Identifikasi 10 peran Analis Data dengan gaji tertinggi yang tersedia untuk pekerjaan jarak jauh.
- Berfokus pada lowongan pekerjaan dengan gaji yang ditentukan (hapus nilai null).
- Mengapa? Menyoroti peluang kerja dengan gaji tertinggi untuk Analis Data, 
  serta memberikan wawasan tentang peluang kerja.
*/

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