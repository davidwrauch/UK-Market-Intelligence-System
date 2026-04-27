# UK Market Intelligence System

This project analyzes UK data, analytics, and AI job postings to provide a clearer view of how roles and companies compare on pay and hiring activity.

The core idea is simple. Given a job posting, what would we expect it to pay based on similar roles in the market, and how does the actual listed salary compare?

The system ingests job data, standardizes it, and uses a machine learning model to estimate expected salary based on role, location, and related features. It then compares that estimate to the listed salary to identify where jobs appear to be above or below market.

At the company level, the tool aggregates these signals to show hiring intensity, typical pay positioning, and external reputation where available. This allows for a more informed view of which companies may be more competitive on compensation and which may be lagging.

An additional layer uses retrieval and a language model to answer questions about the market. Instead of summarizing everything broadly, it pulls the most relevant companies and explains patterns using only the underlying data.

The goal is not to produce a definitive ranking of companies or salaries, but to provide a structured, evidence-based way to compare opportunities and prioritize where to apply or negotiate.

## System overview

Job postings are sourced from the Adzuna API and processed through a pipeline built on BigQuery and SQL. A Python-based model estimates expected salary, and the results are combined with external company signals such as ratings and review counts where available.

The application is delivered through a Streamlit interface that supports both company-level exploration and job-level inspection, along with a question-and-answer layer for higher-level interpretation.

## Running locally

```bash
pip install -r requirements.txt
streamlit run app/dashboard.py
