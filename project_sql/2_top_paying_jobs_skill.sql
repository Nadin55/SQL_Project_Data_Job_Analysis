/*
Pertanyaan: Keterampilan apa saja yang dibutuhkan untuk pekerjaan analis data dengan gaji tertinggi?
- Gunakan 10 pekerjaan Analis Data dengan bayaran tertinggi dari kueri pertama.
- Tambahkan keterampilan spesifik yang dibutuhkan untuk peran-peran ini.
- Mengapa? Karena memberikan gambaran detail tentang pekerjaan bergaji tinggi mana yang membutuhkan keterampilan tertentu, 
  membantu pencari kerja memahami keterampilan apa yang perlu dikembangkan agar sesuai dengan gaji tertinggi.
*/
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