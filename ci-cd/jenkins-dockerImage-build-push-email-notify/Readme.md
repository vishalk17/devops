**CI/CD using Jenkins**

This project uses Jenkins to automate the build, push Docker images and send email notification. 

The following steps are performed by Jenkins:

---

**Pipeline Stages:**

1. Global Condition: Skips all stages if is_build_needed is 'n' & vice-versa
2. Build image: Builds a Docker image.
3. Login to Docker: Logs in to Docker Hub.
4. Push Docker Image: Pushes the Docker image to Docker Hub.
5. Send an email notification for build start, failed, and success.

---

For more details, watch the [YouTube video](https://youtu.be/hpYBQwkQ3d0?feature=shared) explaining this pipeline.
