docker build -t ju11an0/multi-client:latest -t ju11an0/multi-client:$GIT_SHA -f client/Dockerfile client
docker build -t ju11an0/multi-server:latest -t ju11an0/multi-server:$GIT_SHA -f server/Dockerfile server
docker build -t ju11an0/multi-worker:latest -t ju11an0/multi-worker:$GIT_SHA -f worker/Dockerfile worker

docker push ju11an0/multi-client:latest
docker push ju11an0/multi-server:latest
docker push ju11an0/multi-worker:latest
docker push ju11an0/multi-client:$GIT_SHA
docker push ju11an0/multi-server:$GIT_SHA
docker push ju11an0/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=ju11an0/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=ju11an0/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ju11an0/multi-worker:$GIT_SHA