# Road Map on my DevOps Journey


## PART 1 - Prerequisites

  ### Introduction
    TWN's DevOps Bootcamp and its learning tools

  ### Virtual Box
    🧩 The Extension Pack
    ⚠️ Installation Conflicts
    ♻️ Clean Installation
    ✅ Check Good Versions

  ### Linux Basics
    🖥️ OS Information
    📦 Linux Package Manager 
    📝 Vim text editor
    👥 User and Group accounts
    🔐 Ownership and Permissions
    🏷️ Environment Variables
    🌐 Network configuration
    🔑 SSH : Secure Shell

  ### Bash Commands
    #! Shebang line
    🏷️ Print and variables
    🔀 Bash conditions
    🔁 Bash Loops
    ⬇️ Input parameters (arguments):
    🗂️ User / File / Output Readings
    🔧 Functions

  ### Git Version Control
    📸 What is Git ?
    🖥️ Bash prompt
    🗒️ Git Commands
    🌿 Branches
    ⚠️ Conflicts
    🏆 Good Pratices
    🙈 Git Ignore File (.gitignore)
    ⏳ Temporary save uncommited changes (stash)
    ⏪ Get back to an old commit (check log)
    🔃 Cancel Commits (reset or revert)

  ### Database Types
    Types of Database 
    How to organize database ?
    ✅ Code Review Checklist  

  ### Build tools and Package Managers
    📦 What is an artifact ?
    🛠️ Build Tools Overview
    💻 Operating System Setup
    🗒️ Build Artifacts Summary
    🧩 Managing Dependencies
    📤 Packaging & Deployment
    🗜️ Frontend Bundling (Webpack)
    🐳 Using Docker


## PART 2 - DevOps Fundamentals

  ### Cloud & IaaS Basics
    ☁️ 4 types of Cloud Services
    💧 Setup a Droplet on DigitalOcean
    🧱 Setup the Firewall
    📤 Deploy App on Droplet
    🔑 Set a User and Config SSH File
    ⚠ Destroy unused servers !

  ### Nexus Repository Manager

    Part 1 : Introduction and concepts
      What is an artefact repository ?
      The artifact repository manager
      Nexus Presentation

    Part 2 : Installation et configuration
      Nexus Installation
      Start Nexus on the server
      Add a local firewall on the server (Optional)
      Create a system daemon (Optional)

    Part 3 : Deposit Management
      Repository Types
      Prepare the user
      Prepare the repository
      Authentication required
  
    Part 4 : Publishing artifacts
      Publish a Gradle Java App
      Deploy a Maven Java App

    Part 5 : API et maintenance
      Nexus API
      Blob Store and Cleanup Policies
      Automation

  ### Docker Containers

    Part 1 - Docker Introduction
      What is a container ?
      Containers VS Images
      Containers VS Virtual Machines
      Docker Desktop installation
      Main Docker Commands
      Docker Network
  
    Part 2 - Docker development process
      Configuration of MongoDB + Mongo Express UI
      Using Docker Compose
      Build an NodeJS Docker Image with Dockerfile
      Full solution using a Docker compose
      Issue with Cross-Origin Ressource Sharing (CORS) Policy
  
    Part 3 - Docker repository on Nexus
      Docker Private repository
      Pass Password manager
      Docker Login
      Docker Tag and Docker Push
      Deploy a Docker image from Nexus
   
    Part 4 - Docker Volumes
      What is a Docker volume ?
      3 types of volumes
      Docker volumes in Docker compose
      Check the volumes
   
    Part 5 - Nexus as Docker Container
      Purpose
      Installation
      Nexus VS Docker Hub
  
    Part 6 - Best Practices
      1. Use official Docker images as base images
      2. Use specific image versions
      3. Use small-sized official images
      4. Optimize catching images layers
      5. Use .dockerignore file to exclude files and folders 
      6. Make use of multi-stage builds
      7. Use the least privileges users
      8. Scan your images for vulnerabilities

  ### Nginx Proxy / Web Server
    What is NGINX ?
    How to configure Nginx ?
    Nginx as Kubernetes Ingress Controller
    DEMO PROJECT
    Reference

## PART 3 - DevOps Core

  ### Jenkins CI-CD
  
    PART 1 - Concepts & Setup
      Introduction to Build Automation
      Install Jenkins
      Building Tools for Jenkins
  
    PART 2 - Freestyle Jobs & Git
      Jenkins Basics
      Git Repository with Jenkins
   
    PART 3 - Docker & Registries
      JAR image from Jenkins to Docker Hub (Freestyle CI)
      Docker into Jenkins
      JAR image from Jenkins to Nexus Repository
   
    PART 4 - Pipelines & Jenkinsfiles
      Jenkinsfiles and Pipeline Jobs
      JAR image from Jenkins to Docker Hub (Pipeline CI)
      Multibranch Pipelines
   
    PART 5 - CI/CD at scale
      Jenkins Global Shared Library
      Shared library within the project scope only.
      Trigger Jenkins Job - Webhooks
      Application Versioning
   
    PART6 - ADDONS
      Full Example with a NodeJS App

      Automated installation of Docker and Jenkins on a new server with Maven 3.9.12 / NodeJS 20.x and the Pipeline-Stage-View Plugin
      
      📌 Better ! Configure a Jenkins Controller Server with Docker, Node, Maven and AWS CLI Agents making it scalable and CI/CD properly.

### AWS Services
  
    Introduction to Amazon Web Services
    Create an AWS account
    
    IAM - Identity & Access Management
    VPC - Virtual Private Cloud
    EC2 - Elastic Compute Cloud
    
    PROJECT : Java App in CI/CD : Git / Jenkins / Docker Hub / EC2 via SSH
    
    ECR - Elastic Container Registry (AWS Docker Hub)
    CLI - Client Line Interface (and CloudShell)
    S3 - Simple Storage Service
    
    PROJECT : Java App CI/CD : Git / Jenkins / AWS ECR / AWS EC2 via SSM and Docker Compose for the Run
    
    ADDON
    Set the terminal prompt with the EC2 instance’s name (tag)

### Kubernetes Orchestration
  
    PART 1 
      Introduction to Kubernestes (K8s)
      Basic Concepts and Main K8s Components
      Kubernetes Architecture
      Minikube and kubectl - Local Setup
      Kubernetes CLI - Main kubectl commands
      Kubernetes YAML - Introduction to Configuration File
      Demo project deploying an app and a database : Mongo DB & Express
  
    PART 2
      Namespaces - Organize components
      Services - Configure connectivity
      Make App available - Ingress
      Persist data - Volumes
      Config Map & Secret as Volumes Types

I’m currently at this stage and will continue on …

      Deploy stateful Apps - Statefulset
      Package Manager of K8s - Helm
      Extended the K8s API - Operator
  
    PART 3 
      Introduction to Managed Kubernetes Services
      Helm - Package Manager of Kubernetes
      Helm Demo: Install a Stateful Application on Kubernetes using Helm
      Demo: Deploy App from Private Docker Registry
      Extending the K8s API with Operators
      Secure your cluster - Authorization with RBAC
      Microservices in Kubernetes
      Demo project: Deploy Microservices Application
      Production & Security Best Practices
      Demo project: Create Helm Chart for Microservices
      Demo project: Deploy Microservices with Helmfile

### Kubernetes on AWS - EKS

## PART 4 - DevOps Advanced

### Terraform - Infrastructure as Code
### Python Automation Scripts
### Ansible - Automation Platform
### Prometheus - Monitoring


# 

before moving on to the **DevSecOps** Bootcamp …

