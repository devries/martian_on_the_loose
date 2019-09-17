WEBFILES := $(shell find static -type f \( ! -iname '*~' \) )
project_id := single-arcanum-633
container_name := martian
full_name := gcr.io/$(project_id)/$(container_name):latest
port := 3333

.PHONY: debug build push deploy run

debug:
	@echo $(WEBFILES)
	@echo $(full_name)

build.stamp: Dockerfile docker-entrypoint.sh nginx.conf $(WEBFILES)
	docker build -t $(full_name) .
	@touch build.stamp

build: build.stamp

push.stamp: build.stamp
	docker push $(full_name)
	@touch push.stamp

push: push.stamp

deploy.stamp: push.stamp
	gcloud beta run deploy martian --image $(full_name) --platform managed --region us-central1
	@touch deploy.stamp

deploy: deploy.stamp

run:
	@echo Running container martian on 127.0.0.1:$(port)
	docker run -d --name martian -e PORT=8080 -p 127.0.0.1:$(port):8080 $(full_name)
