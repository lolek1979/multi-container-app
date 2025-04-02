# Multi-Container App Deployment with Docker, Kubernetes & GitHub Actions

This project demonstrates a simple **multi-container web application** consisting of a **backend (Python Flask)** and a **frontend (Nginx + static HTML)**. It supports both **Docker Compose** for local development and **Kubernetes deployment** using a CI/CD workflow powered by GitHub Actions and [`act`](https://github.com/nektos/act) for local execution.

---

## 📁 Project Structure

```
├── backend/                   # Flask backend app
│   ├── app.py
│   └── Dockerfile
├── frontend/                  # Frontend served by Nginx
│   ├── default.conf
│   ├── Dockerfile
│   └── index.html
├── k8s/                       # Kubernetes manifests
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   └── frontend-service.yaml
├── docker-compose.yml         # Docker Compose setup
├── .github/workflows/deploy.yml # GitHub Actions CI/CD workflow
├── run-act.sh                 # Script to run workflow locally using `act`
├── .env / .env.example        # Optional environment config
└── README.md                  # You're here!
```

---

## 🚀 Local Development (Docker Compose)

To run the full app locally using Docker Compose:

```bash
docker-compose up --build
```

- Backend available at: `http://localhost:5000`
- Frontend available at: `http://localhost:8080`

To stop and remove containers:
```bash
docker-compose down
```

---

## ☸️ Kubernetes Deployment

Kubernetes manifests are stored in the `k8s/` directory and can be deployed manually or through automation.

Manual apply:

```bash
kubectl apply -f k8s/
```

Destroy:

```bash
kubectl delete -f k8s/
```

---

## 🤖 CI/CD Workflow with GitHub Actions

The workflow supports two operations via `workflow_dispatch`:

- **build**: Build Docker images, push to Docker Hub, deploy to Kubernetes
- **destroy**: Remove Kubernetes resources

### GitHub Actions Inputs

| Input     | Description                          | Default     |
|-----------|--------------------------------------|-------------|
| `action`  | `build` or `destroy`                 | `build`     |
| `version` | Docker image tag (e.g. `1.0.0`)      | `1.0.0`     |

---

## 🧪 Local CI/CD with `act`

To simulate the GitHub Actions workflow locally:

### 🛠️ Requirements

- [act](https://github.com/nektos/act)
- Kubernetes running locally (e.g., [OrbStack](https://orbstack.dev/), Minikube)
- Your kubeconfig accessible via `~/.kube/config`

### 🔁 Run build:

```bash
./run-act.sh build 1.0.0
```

### 💣 Run destroy:

```bash
./run-act.sh destroy 1.0.0
```

Make sure Docker is running and your kube context points to your local cluster.

---

## 🔐 Environment Variables

Set up your `.env` file (copied from `.env.example`) to include credentials like:

```dotenv
DOCKER_USERNAME=your_dockerhub_username
DOCKER_PASSWORD=your_dockerhub_password
```

These will be passed into GitHub Actions when run via `act` using:

```bash
--secret-file .env
```
