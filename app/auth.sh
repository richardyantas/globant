#!/bin/bash
varSecretoID=globant
varProjectID=globant
gcloud config set project $varProjectID
echo "Iniciando acceso al secreto"
valueSecretSA=$(gcloud secrets versions access latest --secret=$varSecretoID)
echo $valueSecretSA | base64 --decode > output1.json
iconv -c -f utf-8 -t ascii output1.json > ./config/service_account.json
rm output1.json
python3 api.py