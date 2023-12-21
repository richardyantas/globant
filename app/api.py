from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import csv
import os
import io
from io import TextIOWrapper

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Department(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    department = db.Column(db.String(255), nullable=False)

class Job(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    job = db.Column(db.String(255), nullable=False)

class Employee(db.Model):
    id = db.Column(db.Integer, primary_key=True)    
    name = db.Column(db.String(255), nullable=True)    
    datetime = db.Column(db.String(255), nullable=True)    
    department_id = db.Column(db.Integer, nullable=True)    
    job_id = db.Column(db.Integer, nullable=True)

@app.route('/upload_json_from_csv_files', methods=['GET'])
def upload_json_from_csv_files():
    departments_data = read_csv('../dataset/departments.csv')
    jobs_data = read_csv('../dataset/jobs.csv')
    employees_data = read_csv('../dataset/hired_employees.csv')
    insert_data_into_database(departments_data, Department)
    insert_data_into_database(jobs_data, Job)
    insert_data_into_database(employees_data, Employee)
    return jsonify({'message': 'Data uploaded successfully'}), 201


@app.route('/upload_csv_file', methods=['POST'])
def upload_csv_file():    
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']        
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    if not file.filename.endswith('.csv'):
        return jsonify({'error': 'File must be a CSV'}), 400
    csv_data = read_csv_stream(file.stream)    
    if file.filename == "departments.csv":        
        insert_data_into_database(csv_data, Department)
    elif file.filename == "jobs.csv":        
        insert_data_into_database(csv_data, Job)        
    else:        
        insert_data_into_database(csv_data, Employee)
    return jsonify({'message': 'Data uploaded successfully'}), 201


@app.route('/upload_json_data', methods=['POST'])
def upload_json_data():
    try:
        data = request.get_json()        
        departments = data.get('departments', [])
        jobs = data.get('jobs', [])
        employees = data.get('employees', [])        
        insert_data_into_database(departments, Department)
        insert_data_into_database(jobs, Job)
        insert_data_into_database(employees, Employee)

        return jsonify({'message': 'Data uploaded successfully'}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500

def insert_data_into_database(data, model):
    try:
        print(data)
        db.session.bulk_insert_mappings(model, data)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        raise e


def read_csv_stream(file_stream):    
    csv_data = []    
    text_buffer = io.StringIO(file_stream.read().decode('utf-8'))
    csv_reader = csv.DictReader(text_buffer)    
    csv_data =list(csv_reader)    
    return csv_data

def read_csv(file_path):
    data = []
    with open(file_path, 'r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        for row in csv_reader:
            data.append(row)
    return data



if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        meta = db.metadata
        meta.reflect(bind=db.engine)
        print("Tables created:", meta.tables.keys())
        app.run(debug=True)

