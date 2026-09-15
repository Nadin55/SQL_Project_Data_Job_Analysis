/*
Pertanyaan: Apa saja keterampilan yang paling dibutuhkan untuk analis data?
- Gabungkan lowongan pekerjaan ke tabel inner join serupa dengan query 2
- Identifikasi 5 keterampilan yang paling dibutuhkan untuk seorang analis data.
- Fokus pada semua lowongan pekerjaan.
- Mengapa? Karena dapat menemukan 5 keterampilan teratas dengan permintaan tertinggi di pasar kerja, 
  memberikan wawasan tentang keterampilan paling berharga bagi para pencari kerja.
*/

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