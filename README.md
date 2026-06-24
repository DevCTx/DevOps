# 🚀 DevOps — TWN Bootcamp Notes & Projects

> **Learning journal + technical portfolio** documenting my progression through modern DevOps practices.

[![Bootcamp](https://img.shields.io/badge/Bootcamp-TechWorld%20with%20Nana-orange)](https://www.techworld-with-nana.com/devops-bootcamp)
[![Notes](https://img.shields.io/badge/📝%20Notes-My%20DevOps%20Journey-green)](https://twn-devops-notes.super.site/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Cédric%20Tonquèze-0077B5?logo=linkedin)](https://www.linkedin.com/in/cedrictonqueze/)


---

## 📖 About

This repository is associated to my **[DevOps Notion Website](https://twn-devops-notes.super.site/)**. It contains exercises, scripts, configurations and projects completed during the [TWN DevOps Bootcamp](https://www.techworld-with-nana.com/devops-bootcamp) of Nana Janashia and personal explorations through DevOps environment.

I started in **December 2025**, dedicating **30-40 hours/week** - going well beyond the announced 15-20h - testing, experimenting, and deepening my understanding of each concept and tool.

> 💡 My goal is to become a real operational  **Cloud & DevOps Engineer**
> 
> and as said Enstein : *"The more I learn, the more I realize how much I don't know"*
>
> I build, I run, so if you're looking for a persevering candidate -> **[Please, let's connect](https://www.linkedin.com/in/cedrictonqueze/)**.

---

## 📚 Content Overview

### PART 1 — Prerequisites

| Topic | Key Concepts | What is in the repository |
|---|---|---|
| **VirtualBox** | Extension Pack<br>  clean install<br>  version checks |
| **Linux Basics** | OS info<br>  package managers<br>  Vim<br>  users/groups<br>  permissions<br>  SSH |  `script_install_java.sh` — Install Java + version check<br>`ps_user.sh` — List & sort user processes by CPU/mem<br>`install_server_js.sh` — Full Node.js app deployment (env vars, background run, log dir, service user)
| **Database Types** | Relational vs NoSQL<br>  organization patterns | Schema of Database's types
| **Bash Scripting** | Variables, conditions<br>  loops, functions, I/O | scripts with conditions, loops, functions with local scope and return codes, I/O: args, user input, file/CSV parsing, process substitution, file check |
| **Git Version Control** | Commands, branches, conflicts, stash, reset/revert |10 scripted exercises: clone, .gitignore, feature/bugfix branches, merge requests, conflict resolution, revert & reset commits, branch cleanup |
| **Build Tools & Package Managers** | Artifacts, Maven/Gradle, Webpack, Docker basics |6 exercises on a Gradle Java app (fix test, build, run jar, add params) + React/Node.js full-stack example with Webpack and Dockerfile |

---

### PART 2 — DevOps Fundamentals

| Topic | Key Concepts | What's in the repo |
|---|---|---|
| **Cloud & IaaS** | Cloud service types, DigitalOcean Droplet, firewall, SSH config | 6 exercises: package Node.js app (npm pack), provision DigitalOcean Droplet, install Node/npm, deploy artifact via SSH, run in background, open firewall port |
| **Nexus Repository Manager** | Installation, repo types, artifact publishing (Maven/Gradle), API, automation | 9 exercises: install Nexus, create npm & Maven repos, manage roles/users, publish Node.js tar & Gradle jar, query REST API, automate artifact fetch & deploy on DigitalOcean |
| **Docker Containers** | Images, volumes, networks, Dockerfile, Docker Compose, best practices, multi-stage builds | 8 exercises: MySQL + phpMyAdmin via Docker network & secrets, docker-compose with volumes & healthcheck, Dockerfile for Java app, push to Nexus Docker repo, full stack deployed on DigitalOcean |
| **Nginx** | Reverse proxy, web server, Kubernetes Ingress Controller | Submodule: Express app × 3 containers behind NGINX (reverse proxy, load balancer, TLS termination, gzip, cache) |

---

### PART 3 — DevOps Core

| Topic | Key Concepts | What's in the repo |
|---|---|---|
| **Jenkins CI/CD** | Freestyle jobs<br> Pipelines<br> Jenkinsfiles<br> Multibranch<br> Shared libraries<br> Webhooks<br> Auto-Versioning | `java-maven-app/` — freestyle → Jenkinsfile + script.groovy<br> `java-dockerhub-pipeline/` — pipeline CI to Docker Hub<br> `java-dockerhub-shared/` — global shared library<br> `java-dockerhub-limited-shared/` — project-scoped shared library (submodule, DockerHub/ECR, EC2 SSH/SSM) <br> `auto-versioning-pipeline/` — Maven patch auto-increment + SCM skip <br> `Jenkins-exercises/` — Node.js full pipeline: Jest, Docker Hub push, Git commit-back <br> `jenkins-docker-platform*.sh` — auto-install Jenkins+Docker (Ubuntu, AL2023) + scalable agents platform (docker/maven/nodejs/aws)<br> |
| **AWS Services** | IAM, VPC, EC2, ECR, S3, CLI — with full CI/CD projects via SSH and SSM |  `react-nodejs-example/` — React + Node.js API (Webpack) + Dockerfile <br> `js-app-db/` — Node.js + MongoDB + docker-compose <br> `AWS-exercises/` : Node.js app with Jenkinsfile and docker-compose <br> `jma-ssh-dockerhub-ec2/` — Java Maven app -> Git -> Jenkins -> Docker Hub -> EC2 via SSH <br> `jma-ssm-ecr-ec2/` — Java Maven app -> Git -> Jenkins -> ECR -> EC2 via SSM (IAM policies) + Docker Compose <br> `SSH-vs-SSM.drawio` — architecture comparison
| **Kubernetes Orchestration** | Core components<br> architecture<br> Minikube/kubectl<br> YAML manifests<br> Namespaces<br> Services<br> Ingress + TLS<br> Gateway API<br> Volumes<br> ConfigMap/Secret<br> | `nginx-deployment.yaml` / `nginx-service.yaml` — basic Deployment + Service <br> `MongoDB-Express-Deployment/` — MongoDB + Mongo Express, Secret + ConfigMap, NodePort access <br> `Test_Services/nginx-deployment.yaml` — Pod replication across nodes <br> `Test_Services/nginx-dpl-svc.NodePort.yaml` — NodePort service demo <br> `Test_Services/nginx-dpl-svc.LoadBalancer.yaml` — LoadBalancer service (minikube tunnel) <br> `Test_Services/nginx-prometheus-deploy.yaml` — multi-port named service (nginx + exporter) <br> `Test_Services/mongodb-replicaset.yaml` — Headless service for StatefulSet <br> `Test_Services/nginx-ingress.yaml` — Ingress routing <br> `Test_Ingress/` — dashboard Ingress + self-signed TLS <br> `Test_ConfigMap_Volume/Mosquitto_deployment/` — MQTT broker, ConfigMap + Secret mounted as volumes <br> `Test_ConfigMap_Volume/nginx_tls_to_ingress/` — TLS termination at Ingress <br> `Test_ConfigMap_Volume/nginx_tls_to_pods/` — end-to-end TLS re-encryption to Pods <br> `11-Kubernetes_Checklist.pdf` / `kubectl_Quick_Reference_Kubernetes.pdf` — reference docs |
| **Kubernetes on AWS** | EKS managed clusters |

---

### PART 4 — DevOps Advanced *(in progress)*
| Topic | Key Concepts | What's in the repo |
|---|---|---|

- [ ] **Terraform** — Infrastructure as Code
- [ ] **Python Automation Scripts**
- [ ] **Ansible** — Automation Platform
- [ ] **Prometheus** — Monitoring

---

## 🛠️ Technologies & Tools

![Linux](https://img.shields.io/badge/-Linux-FCC624?logo=linux&logoColor=black&style=flat)
![Docker](https://img.shields.io/badge/-Docker-2496ED?logo=docker&logoColor=white&style=flat)
![Kubernetes](https://img.shields.io/badge/-Kubernetes-326CE5?logo=kubernetes&logoColor=white&style=flat)
![Jenkins](https://img.shields.io/badge/-Jenkins-D24939?logo=jenkins&logoColor=white&style=flat)
[![AWS](https://custom-icon-badges.demolab.com/badge/AWS-232F32.svg?logo=aws&logoColor=FF9900&labelColor=232F32&color=232F32)](#)
![Nginx](https://img.shields.io/badge/-Nginx-009639?logo=nginx&logoColor=white&style=flat)
![Git](https://img.shields.io/badge/-Git-F05032?logo=git&logoColor=white&style=flat)

and soon ... 
![Terraform](https://img.shields.io/badge/-Terraform-7B42BC?logo=terraform&logoColor=white&style=flat)
![Ansible](https://img.shields.io/badge/-Ansible-EE0000?logo=ansible&logoColor=white&style=flat)
![Prometheus](https://img.shields.io/badge/-Prometheus-E6522C?logo=prometheus&logoColor=white&style=flat)


---

## 🔗 Resources

- 📝 **Full Notes Website**: [Notes on my DevOps journey](https://twn-devops-notes.super.site/)
- 🎓 **Bootcamp**: [TechWorld with Nana — DevOps Bootcamp](https://www.techworld-with-nana.com/devops-bootcamp)
- 🗺️ **Roadmap**: [DevOps Roadmap](./DevOps_Roadmap.md)
- 💼 **LinkedIn**: [Cédric Tonquèze](https://www.linkedin.com/in/cedrictonqueze/)
