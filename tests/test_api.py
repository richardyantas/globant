import json
import unittest
# import request
from app.api import app

class TestRoutes(unittest.TestCase):
    def setUp(self):
        app.testing = True
        self.app = app.test_client()

    def test_upload_json_from_csv_files(self):
        # modify
        data = {
            "departments": [{"id": 1, "name": "Test Department"}],
            "jobs": [{"id": 1, "title": "Test Job"}],
            "employees": [{"id": 1, "name": "Test Employee", "hire_datetime": "2021-08-01T00:00:00Z", "department_id": 1, "job_id": 1}]
        }
        response = self.app.post('/upload', json=data)
        result = json.loads(response.data)

        self.assertEqual(response.status_code, 201)
        self.assertEqual(result['message'], 'Data uploaded successfully')

if __name__ == '__main__':
    unittest.main()
