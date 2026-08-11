# AI-Powered Data Analytics Assistant — Healthcare Operations

![PowerBI Dashboard Preview](powerbi/preview.png) *(Add a screenshot of your dashboard here later)*

## 1. Project Overview
This project is an end-to-end **AI-Powered Data Analytics System** designed for hospital administration and healthcare operations. It seamlessly bridges the gap between raw medical data and actionable business insights. It features a fully functioning Data Warehouse, an interactive 3-page Power BI dashboard, and an NLP-driven AI Assistant that allows users to ask questions in plain English and receive real-time answers from the database.

## 2. Business Problem & Solution
Healthcare organizations generate massive amounts of operational data daily. Executives often struggle to track performance bottlenecks (e.g., high waiting times) or analyze revenue streams without relying heavily on IT teams. 

**Solution:** This system provides a top-tier **Power BI Dashboard** for high-level monitoring and an **AI Assistant** (built with FastAPI & LLMs) for ad-hoc questioning. Users can simply ask, *"Which department generated the most revenue last month?"* and the AI will autonomously write safe SQL, query the database, and return the answer.

## 3. Tech Stack & Architecture
- **Data Engineering / ETL:** Python (Pandas, Numpy)
- **Database:** PostgreSQL (SQLAlchemy)
- **Backend API:** FastAPI, Uvicorn
- **Frontend UI:** HTML, CSS, Vanilla JavaScript
- **AI Integration:** LLM Text-to-SQL logic (OpenAI/Gemini)
- **Business Intelligence:** Power BI

## 4. Project Structure
```text
healthcare_analytics_project/
│
├── data/
│   ├── raw/                 # Original uncleaned datasets
│   └── cleaned/             # Processed datasets ready for SQL
│
├── python/                  # Jupyter notebooks and ETL scripts for Data Cleaning & EDA
├── sql/                     # Table definitions, inserts, analytical queries, and views
├── powerbi/                 # The 3-page interactive .pbix dashboard file
├── frontend/                # User interface for the AI Chat Assistant
└── backend/                 # FastAPI application, Database connection, and AI workflow
```

## 5. Dashboard Details (Power BI)
The Power BI report contains three highly detailed pages:
1. **Executive Overview:** Monthly appointment and revenue trends, overall hospital KPIs.
2. **Operations & Doctors Performance:** Doctor workload distribution, average consultation vs waiting times by department, and time-slot analysis.
3. **Revenue & Patient Experience:** Deep dive into revenue by treatment type and payment mode, paired with patient satisfaction scatter plots.

## 6. AI Workflow & Security
The backend utilizes an LLM to dynamically generate SQL based on user input. 
**Security Implementation:** Before any AI-generated SQL is executed against the PostgreSQL database, it passes through a custom Regex Validator (`utils/validators.py`). Any destructive commands (`DROP`, `DELETE`, `UPDATE`, `INSERT`, `ALTER`, `TRUNCATE`) are strictly blocked.

## 7. Setup & Run Instructions
### Prerequisites
- Python 3.9+
- PostgreSQL Server (Running locally on port 5432)

### Installation
1. Clone this repository.
2. Install Python dependencies:
   ```bash
   pip install -r backend/requirements.txt
   ```
3. Set up the PostgreSQL database (`healthcare_analytics`) and run the ETL scripts in the `python/` folder to populate the data.
4. Add your LLM API Key to `backend/.env`.

### Running the AI Assistant
Start the FastAPI server:
```bash
cd backend
python -m uvicorn app.main:app --reload
```
Open `frontend/index.html` in your browser to start querying the AI!
