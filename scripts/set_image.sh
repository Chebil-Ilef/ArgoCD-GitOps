#!/usr/bin/env bash
# Usage: ./scripts/set_image.sh <image>
# Example: ./scripts/set_image.sh nginx:1.27

IMAGE="${1:-nginx:1.25}"
REPLICAS=1

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
          image: ${IMAGE}
          ports:
            - containerPort: 80
EOY

echo "Updated app/deployment.yaml with image = ${IMAGE}"
