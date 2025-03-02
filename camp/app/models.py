from app import db


class Attribute:
    def __init__(self, name,primaryKey=False):
        self.name = name
        self.value = None
        self.primaryKey = primaryKey
    def __str__(self):
        return self.value
class Base:
    table=""
    def add(self):
        print()
    def delete(self,id):
        print()
    def updateWhere(self, key, key_value, values):
        # 将更新字段和占位符组合在一起
        set_clause = ', '.join([f"{field} = %s" for field in values.keys()])
        # 构造 SQL 语句
        sql = f'''
                UPDATE {self.table}
                SET {set_clause}
                WHERE {key} = %s;
                '''
        # 在 values 后面添加 key_value 作为最后一个参数
        with db.get_cursor() as cursor:
            cursor.execute(sql, tuple(values.values()) + (key_value,))
    def getValueList(self):
        valueList = []
        for attribute_name in dir(self):
            if not attribute_name.startswith('__'):  # Exclude special methods
                attribute = getattr(self, attribute_name)
                if isinstance(attribute, Attribute):  # Check if the attribute is of type 'Attribute'
                    valueList.append(attribute)
        return valueList
    def getAttribute(self):
        valueList =self.getValueList()
        h = ""
        for i in range(len(valueList)):
            h += f'{valueList[i].name},'
        h = h[:-1]  # 去掉最后一个字符
        return h
    def insert(self,values):
        # 插入代码如上所示
        columns = ', '.join(values.keys())
        placeholders = ', '.join(['%s'] * len(values))
        sql = f'''
                  INSERT INTO {self.table} ({columns})
                  VALUES ({placeholders});
              '''
        with db.get_cursor() as cursor:
            cursor.execute(sql, tuple(values.values()))

    def get(self, key, value):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                  SELECT {self.getAttribute()}
                  FROM {self.table}
                  WHERE {key} = %s;
              ''', (value,))  # 使用 value 参数化查询
            account = cursor.fetchone()
        return account
    def getWhere(self,position):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                       SELECT {self.getAttribute()}
                        FROM {self.table}
                       WHERE {position}; ''')
            account = cursor.fetchall()
        return account

    def getWhereByLimit(self, position,limit):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                        SELECT {self.getAttribute()}
                         FROM {self.table}
                        WHERE {position}  {limit}; ''')
            account = cursor.fetchall()
        return account

    def getPosition(self,position):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                       SELECT {self.getAttribute()}
                        FROM {self.table}
                         {position}; ''')
            account = cursor.fetchall()
        return account

    def getAll(self):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                          SELECT {self.getAttribute()}
                           FROM {self.table}; ''')
            account = cursor.fetchall()
        return account

    def getContainCount(self,key,value):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                      SELECT COUNT(*)
                      FROM {self.table}
                      WHERE {key} LIKE %s;
                  ''', (f'%{value}%',))  # 使用 LIKE 和通配符来模糊匹配
            count = cursor.fetchall() # 只取第一行第一列的结果
        return count


    def getContainPosition(self, key, value, position):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                               SELECT *
                               FROM {self.table}
                               WHERE {key} LIKE %s 
                               {position};
                           ''', (f'%{value}%',))  # 使用 LIKE 和通配符来模糊匹配
            count = cursor.fetchall()  # 只取第一行第一列的结果
        return count

    def getCount(self, situation):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                          SELECT COUNT(*)
                           FROM {self.table}
                           {situation}; ''')
            count = cursor.fetchall()
        return count

    def getCountWhere(self, situation):
        with db.get_cursor() as cursor:
            cursor.execute(f'''
                            SELECT COUNT(*)
                             FROM {self.table}
                             where {situation}; ''')
            count = cursor.fetchall()
        return count



    def create(self):
        pass
    def print(self):
        pass
class  User(Base):
    table = "users"
    user_id = Attribute("user_id", primaryKey=True)
    username = Attribute("username")
    password_hash = Attribute("password_hash")
    email = Attribute("email")
    first_name = Attribute("first_name")
    last_name = Attribute("last_name")
    location_name = Attribute("location")
    profile_image = Attribute("profile_image")
    status = Attribute("status")
    role=Attribute("role")
    def __init__(self):
        print()

    def update(self, id, values):
        # 将更新字段和占位符组合在一起
        set_clause = ', '.join([f"{key} = %s" for key in values.keys()])
        sql = f'''
                    UPDATE {self.table}
                    SET {set_clause}
                    WHERE user_id = %s;
                '''
        # 在 values 后面添加 id 作为最后一个参数
        with db.get_cursor() as cursor:
            cursor.execute(sql, tuple(values.values()) + (id,))

class Issue(Base):
    table = "issues"
    issue_id = Attribute("issue_id",primaryKey=True)
    user_id = Attribute("user_id")
    summary = Attribute("summary")
    description = Attribute("description")
    create_at = Attribute("create_at")
    status = Attribute("status")
    def __init__(self):
        print()
class Comment(Base):
    table = "comments"
    issue_id = Attribute("comment_id", primaryKey=True)
    user_id = Attribute("issue_id")
    summary = Attribute("user_id")
    description = Attribute("content")
    create_at = Attribute("create_at")
