install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	# force install latest whisper
	# pip install --upgrade --no-deps --force-reinstall git+https://github.com/openai/whisper.git
test:
	python -m pytest -vv --cov=main --cov=calCLI --cov=mylib test_*.py

format:	
	black *.py mylib/*.py 

lint:
	pylint --disable=R,C ---extension-pkg-whitelist='pydantic' main.py --ignore-pattern=test_.*.py mylib/*.py

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

checkgpu:
	echo "Checking GPU for PyTorch"
	python utils/verify_pytorch.py
	echo "Checking GPU for Tensorflow"
	python utils/verify_tf.py	

refactor: format lint

deploy:
	#deploy goes here
		
all: install lint test format deploy