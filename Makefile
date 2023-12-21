conda-remove:
	conda env remove --name recommendation-boa
conda-update:
	conda env update -f environment.yml
pip-tools:
	pip-compile requirements/dev.in 
	pip-sync requirements/dev.txt