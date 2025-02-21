ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
	ARCH := amd64
endif

flog:
	go build .

build-for-linux:
	GO111MODULE=on CGO_ENABLED=0 GOARCH=$(ARCH) GOOS=linux go build .

build-image: build-for-linux
	docker build -t localhost:5001/flog:latest -f Dockerfile.local .

push-image: build-image
	docker push localhost:5001/flog:latest
