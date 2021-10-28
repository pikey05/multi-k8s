# Build our images
docker build -t smcook55/multi-client:latest -t smcook55/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smcook55/multi-server:latest -t smcook55/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smcook55/multi-worker:latest -t smcook55/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# Push to docker hub
docker push smcook55/multi-client:latest
docker push smcook55/multi-client:$SHA
docker push smcook55/multi-server:latest
docker push smcook55/multi-server:$SHA
docker push smcook55/multi-worker:latest
docker push smcook55/multi-worker:$SHA
# Deploy to kubernetes
kubectl apply -f k8s
# Set new image tags
kubectl set image deployments/server-deployment server=smcook55/multi-server/$SHA
kubectl set image deployments/client-deployment client=smcook55/multi-client/$SHA
kubectl set image deployments/worker-deployment worker=smcook55/multi-worker/$SHA