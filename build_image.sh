# export GOOGLE_APPLICATION_CREDENTIALS=../config/sa.json
# gcloud config set project $PROJECT_ID

PROJECT_ID=globant

DOCKER_IMAGE_URI=${PROJECT_ID}/globant_image
TAG_IMAGEN_CL_PROCESS_1=t1
docker build . -t $DOCKER_IMAGE_URI
DOCKER_TAGGED=gcr.io/${PROJECT_ID}/globant_image:${TAG_IMAGEN_CL_PROCESS_1} 
docker tag ${DOCKER_IMAGE_URI} ${DOCKER_TAGGED}
docker push ${DOCKER_TAGGED}

# docker run -d -p 8080:80 --name scrap_cont btot-cl-dev-laboratorioaa/web_scraping_sku:latest
# docker exec -it scrap_cont bash
# docker build . -t pc
# docker run -it --rm pc bash


