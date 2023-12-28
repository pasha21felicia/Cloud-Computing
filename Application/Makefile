ENV_FILE ?= .env
LOCAL_ENV_FILE ?= .envrc
PROJECT_NAME = LICENTA

.PHONY: help
help:  ## Show this help.
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.env:
	@touch ${ENV_FILE}
	@touch ${LOCAL_ENV_FILE}
	@echo "DB_ROOT_PASSWORD=" >> ${ENV_FILE}
	@echo "DB_HOST=" >> ${ENV_FILE}
	@echo "DB_NAME=" >> ${ENV_FILE}
	@echo "DB_PASSWORD=" >> ${ENV_FILE}
	@echo "DB_USER=" >> ${ENV_FILE}
	@echo "#!/bin/sh" > ${LOCAL_ENV_FILE}
	@echo "dotenv" >> ${LOCAL_ENV_FILE}
	@direnv allow .

.PHONY: .install
.install: .env   ## Create .env files

.PHONY: init
init: .install  ## Setup local environment installing both develop and default packages from Pipfile.
	@. ./${ENV_FILE} && unset PYTHONPATH && pipenv install --dev