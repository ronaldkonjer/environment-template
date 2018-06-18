CHART_REPO := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "change-me"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init
	helm repo add releases ${CHART_REPO}
	# helm repo add jenkins-x http://chartmuseum.build.cd.jenkins-x.io
	helm dependency build ${DIR}
	helm lint ${DIR}

install:
	helm template --name ${NAMESPACE} ${DIR} --namespace ${NAMESPACE}
	# first install (initialize) can take quite a while, therfore timout of 45min
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug --timeout 2700

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:
