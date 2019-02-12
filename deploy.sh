docker build -t neworderx/multi-client:latest -t neworderx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neworderx/multi-server:latest -t neworderx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neworderx/multi-worker:latest -t neworderx/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push neworderx/multi-client:latest
docker push neworderx/multi-server:latest
docker push neworderx/multi-worker:latest

docker push neworderx/multi-client:$SHA
docker push neworderx/multi-server:$SHA
docker push neworderx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=neworderx/multi-server:$SHA
kubectl set image deployments/client-deployment client=neworderx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=neworderx/multi-worker:$SHA
