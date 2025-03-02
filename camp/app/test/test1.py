import os
import unittest

from app import app, models
from app import db
from flask import redirect, render_template, request, session, url_for, jsonify, send_from_directory
from flask_bcrypt import Bcrypt
import re

from app.models import *


@app.route('/api', methods=['GET'])
def api():
    return jsonify({'message': 'Hello, World!'})

# 创建测试类
class FlaskAppTests(unittest.TestCase):
    def setUp(self):
        # 创建测试客户端
        self.app = app.test_client()
        self.app.testing = True

    def test_api(self):
        # 发送 GET 请求到 /api
        response = self.app.get('/api')
        # 断言响应状态码
        self.assertEqual(response.status_code, 200)
        # 断言返回的 JSON 数据
        self.assertEqual(response.get_json(), {'message': 'Hello, World!'})
        # u=User().get("user_id",1)
        # print(u)

# 运行测试
if __name__ == '__main__':
    unittest.main()
