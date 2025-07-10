# 🧪 Full Stack Challenge – Elixir + React

This is a full stack application built with **Elixir (Phoenix)** on the backend and **React (Vite + TypeScript)** on the frontend. It includes **JWT-based authentication** and a **Product CRUD** interface. The entire stack runs in **Docker** and can be started with a single script.

---

## 🧰 Technologies

- **Backend**: Elixir + Phoenix
- **Frontend**: React + Vite + TypeScript
- **Database**: PostgreSQL
- **Authentication**: JWT (pre-existing users only)
- **Containerization**: Docker + Docker Compose

---

## 🚀 Setup Instructions

> Prerequisites:
> - Docker
> - Docker Compose


### 1. Clone the repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### 2. Configure environment variables

Create a `.env` file at the root of the project:

```bash
# .env
DB_USER=postgres
DB_PASS=postgres
DB_NAME=store_dev
PHX_SERVER=true
SECRET_KEY_BASE=your_phx_secret_base
GUARDIAN_SECRET_KEY=your_guardian_secret
```

### 3. Generate secret keys

Run the following commands to generate secure keys:

Generate it by running:
```bash
mix phx.gen.secret         # For SECRET_KEY_BASE
mix guardian.gen.secret    # For GUARDIAN_SECRET_KEY
```

Copy the generated values into your .env file.

### 4. Start the application

Simply run:
```bash
./start.sh
```

This will spin up:

PostgreSQL database

- PostgreSQL database
- Phoenix API (http://localhost:4001)
- React frontend (http://localhost:5173)

### 🧪 Testing the App

1. Visit http://localhost:5173
2. Log in using the seeded credentials:

```markdown
Email: admin@example.com
Password: 123456
```

3. Access the Product CRUD interface

---

### 🔐 Authentication

- Implemented using JWT

- Token is stored in localStorage

- Protected endpoints require:

```bash
Authorization: Bearer <your-token>
```

### 📁 Project Structure (Monorepo)

```bash
.
├── store_api       # Elixir/Phoenix backend
├── frontend        # React frontend
├── docker-compose.yml
├── .env
└── start.sh        # One-command startup script
```
