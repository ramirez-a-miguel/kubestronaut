#!/usr/bin/env bash
set -euo pipefail

# Solve on: ssh cks9640

mkdir -p /opt/course/1

# 1. Using bom: Generate a SPDX-JSON SBOM of image registry.k8s.io/kube-apiserver:v1.31.0
bom generate \
  --image registry.k8s.io/kube-apiserver:v1.31.0 \
  --format json \
  --output /opt/course/1/sbom1.json

# 2. Using trivy: Generate a CycloneDX SBOM of image registry.k8s.io/kube-controller-manager:v1.31.0
trivy image \
  --format cyclonedx \
  --output /opt/course/1/sbom2.json \
  registry.k8s.io/kube-controller-manager:v1.31.0

# 3. Using trivy: Scan existing SPDX-JSON SBOM at /opt/course/1/sbom_check.json for known vulnerabilities
trivy sbom \
  --format json \
  --output /opt/course/1/sbom_check_result.json \
  /opt/course/1/sbom_check.json
