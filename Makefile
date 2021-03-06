.PHONY: build-%
build-%:
	docker build -t logica0419/protoc-go:${@:build-%=%} . --no-cache

.PHONY: push-%
push-%: build-% build-latest
	docker push logica0419/protoc-go:${@:push-%=%}
	docker push logica0419/protoc-go:latest
