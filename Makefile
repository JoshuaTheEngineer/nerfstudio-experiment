## build/docker: builds a custom pytorch dockerfile based off runpod/pytorch with nerfstudio
.PHONY: build/docker
build/docker:
	docker build --tag cadav001/pytorch-nerfstudio --platform linux/x86_64 .

## build/cmds: builds via a sequence of commands
.PHONY: build/cmds
build/cmds:
	conda create --name nerfstudio -y python=3.8
	source /opt/conda/etc/profile.d/conda.sh
	conda activate nerfstudio
	conda install cuda -c nvidia
	apt-get update -y
	apt-get install build-essential manpages-dev -y
	pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html
	pip install nerfstudio
	apt install libgl1-mesa-glx -y
	apt-get install ffmpeg libsm6 libxext6 -y

.PHONY: help
help: Makefile
	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /'