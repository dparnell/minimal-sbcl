app_dir := $(dir $(CURDIR))

all: container

container: 
	sudo docker build -t minimal-sbcl .

run: container
	sudo docker run -a stdin -a stdout -a stderr -i -t minimal-sbcl /usr/local/bin/sbcl

clean:
	sudo docker rm $(docker ps -a -q)
	sudo docker rmi $(docker images -q)
