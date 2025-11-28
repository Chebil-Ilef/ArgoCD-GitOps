#!/usr/bin/env bash
# Usage: ./scripts/set_replicas.sh <replicas>
# Example: ./scripts/set_replicas.sh 3

REPLICAS="${1:-1}"

cat > app/deployment.yaml << EOY
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-demo
  namespace: demo-gitops
spec:
  replicas: ${REPLICAS}
  selector:
    matchLabels:
      app: nginx-demo
  template:
    metadata:
      labels:
        app: nginx-demo
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
EOY

echo "Updated app/deployment.yaml with replicas = ${REPLICAS}"
