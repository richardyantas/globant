
# enter data with json data
curl -X POST -H "Content-Type: application/json" -d '{
  "departments": [
    {"id": "55","department": "data"},
    {"id": "56","department": "robotics"}
  ],
  "jobs": [
    {"id": "125", "job": "Mechatronics engineer"},
    {"id": "126", "job": "Machine learning engineer"}
  ],
  "employees": [
    {"id": "10000", "name": "Rick Alcantara", "datetime": "2022-09-19T23:55:34Z", "department_id": "9", "job_id": "125"}
  ]
}'  http://127.0.0.1:5000/upload_json_data


# verify tables creation
sqlite3 ./instance/database.db

# enter data with csv file 

curl -X POST -H "Content-Type: multipart/form-data" -F "file=@../dataset/jobs.csv" http://127.0.0.1:5000/upload_csv_file
curl -X POST -H "Content-Type: multipart/form-data" -F "file=@../dataset/hired_employees.csv" http://127.0.0.1:5000/upload_csv_file

# curl -X POST -F "file=@../dataset/jobs.csv" http://127.0.0.1:5000/upload_csv_file


curl -X GET http://127.0.0.1:5000/upload_json_from_csv_files