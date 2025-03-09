import random
import unittest
from app import app,db  # 导入你的 Flask 应用
from app.models import User


def getRandomRole():
    roles = ["visitor", "helper", "admin"]
    return random.choice(roles)

def randomActive():
    active = ["inactive", "active"]
    return random.choice(active)



class BasicTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.app = app.test_client()  # 创建测试客户端
        cls.app.testing = True  # 启用测试模式

        # 创建应用上下文
        with app.app_context():
            # 这里可以进行一些初始化操作，例如设置数据库
            User().get("user_id", 1)
            pass

    def test_some_feature(self):
        pass
        # with app.app_context():
        #     for i in range(20):
        #         value={
        #         "password_hash":"$2b$12$mzpvCA3B0gmJ5OTxQhntBO86E5QdgCzuld8BsCDgyi0PTLVpTbTd6",
        #         "username":f"u{i}",
        #         "email":f"{i}@qq.com",
        #         "first_name":f"f{i}",
        #         "last_name":f"l{i}",
        #         "location":f"{i}",
        #         "role":getRandomRole(),
        #         "status":randomActive()
        #         }
        #         # 这里可以进行一些初始化操作，例如设置数据库
        #         User().insert(value)


if __name__ == '__main__':
    unittest.main()
