default: docker_build

docker_build:
	@docker build \
	    -t elevio-test .

