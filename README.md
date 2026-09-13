<div align="center">
  <img src="./images/coderco.jpg" alt="CoderCo" width="300">
</div>

# Threat Composer ECS Deployment Project

A hands-on DevOps portfolio project for containerising the open-source AWS Threat Composer application and deploying it to Amazon ECS using Terraform and a CI/CD pipeline.

> **Project status:** In progress. The application has been containerised and tested locally. AWS infrastructure and automated deployment have not yet been implemented.

## Project goals

- Build the application as a container image
- Store the image in Amazon ECR
- Provision all AWS resources with reusable Terraform modules
- Deploy the container to Amazon ECS
- Expose the application through an Application Load Balancer
- Configure HTTPS and a custom domain
- Automate testing, image building, and deployment with GitHub Actions
- Add monitoring, logging, screenshots, and an architecture diagram

## Completed work

- [x] Added the supplied application under `app/`
- [x] Created a multi-stage Docker build
- [x] Used Node.js to build the static application
- [x] Used unprivileged NGINX as the runtime image
- [x] Served the application locally on port 8080
- [x] Added `.gitignore` and `.dockerignore` rules
- [x] Scanned the final image with Docker Scout
- [x] Provision Amazon ECR with Terraform
- [ ] Add a GitHub Actions CI/CD pipeline
- [ ] Provision the network, load balancer, and ECS resources
- [ ] Configure DNS and HTTPS
- [ ] Add monitoring and logging
- [ ] Add deployment screenshots and an architecture diagram

## Container architecture

The Dockerfile uses two stages:

1. **Build stage:** Node.js installs the locked dependencies and produces the static website files.
2. **Runtime stage:** Unprivileged NGINX serves only the finished website files on port 8080.

Keeping Node.js out of the runtime stage produces a smaller image with a reduced attack surface.

## Run locally with Docker

### Build the image

From the repository root:

```bash
docker build -t ecs-assignment ./app
```

### Run the container

```bash
docker run --rm -p 8080:8080 ecs-assignment
```

Open [http://localhost:8080](http://localhost:8080) in a browser.

Stop the container with `Ctrl+C`.

## Validation completed

- The Docker image builds successfully
- The container starts successfully
- The homepage and static assets return HTTP 200
- Docker Scout reported:
  - 0 critical vulnerabilities
  - 0 high vulnerabilities
  - 0 medium vulnerabilities
  - 3 low vulnerabilities
- Terraform created the ECR repository successfully
- The container image was pushed using an immutable Git commit tag
- Amazon ECR basic scanning completed with 0 findings

The vulnerability result is a snapshot of the image at the time it was scanned and may change as vulnerability databases are updated.

## Repository structure

```text
.
├── app/
│   ├── config/
│   ├── public/
│   ├── src/
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── package.json
│   └── yarn.lock
├── images/
├── .gitignore
└── README.md
```

## Application source

This project uses the open-source [AWS Threat Composer](https://github.com/awslabs/threat-composer) application as its workload. Threat Composer helps teams create and manage threat models.

The application code retains its original copyright and licence notices.

## Planned deployment

The target deployment will include:

- Amazon ECR for container images
- Amazon ECS for running the application
- An Application Load Balancer for incoming traffic and health checks
- AWS Certificate Manager for TLS certificates
- Route 53 or an existing DNS provider for the custom hostname
- CloudWatch for logs and monitoring
- Terraform modules for infrastructure management
- GitHub Actions for automated build, test, scan, and deployment

The final architecture will be documented after the infrastructure design has been completed and reviewed.