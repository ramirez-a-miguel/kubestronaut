# Question 1 | SBOM

Your team received Software Bill Of Materials (SBOM) requests and you have been selected to generate some documents and scans:

Using bom:

Generate a SPDX-JSON SBOM of image registry.k8s.io/kube-apiserver:v1.31.0

Store it at /opt/course/1/sbom1.json on cks9640

Using trivy:

Generate a CycloneDX SBOM of image registry.k8s.io/kube-controller-manager:v1.31.0

Store it at /opt/course/1/sbom2.json on cks9640

Using trivy:

Scan the existing SPDX-JSON SBOM at /opt/course/1/sbom_check.json on cks9640 for known vulnerabilities. Save the result in Json format at /opt/course/1/sbom_check_result.json on cks9640

```bash
# 1. Using bom: Generate a SPDX-JSON SBOM of image registry.k8s.io/kube-apiserver:v1.31.0
bom generate \
  --image registry.k8s.io/kube-apiserver:v1.31.0 \
  --format json \
  --output /opt/course/1/sbom1.json

```

```bash

# 2. Using trivy: Generate a CycloneDX SBOM of image registry.k8s.io/kube-controller-manager:v1.31.0
trivy image \
  --format cyclonedx \
  --output /opt/course/1/sbom2.json \
  registry.k8s.io/kube-controller-manager:v1.31.0
```

```bash
# 3. Using trivy: Scan existing SPDX-JSON SBOM at /opt/course/1/sbom_check.json for known vulnerabilities
trivy sbom \
  --format json \
  --output /opt/course/1/sbom_check_result.json \
  /opt/course/1/sbom_check.json

```

