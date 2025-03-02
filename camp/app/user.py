import os

from app import app, models
from flask import redirect, render_template, request, session, url_for, jsonify, send_from_directory
from flask_bcrypt import Bcrypt
import re

from app.models import *

# Create an instance of the Bcrypt class, which we'll be using to hash user
# passwords during login and registration.
flask_bcrypt = Bcrypt(app)
# Default role assigned to new users upon registration.
DEFAULT_USER_ROLE = 'customer'


# page_size =6  # 每页显示的记录数
page_size =5 # 每页显示的记录数

def get_html(role):
    if role == 'visitor':
        r="visitor_home.html"
    elif role == 'helper':
        r = "helper_home.html"
    elif role == 'admin':
        r = 'admin_home.html'
    return r


def user_home_url():
    """Generates a URL to the homepage for the currently logged-in user.
    If the user is not logged in, or the role stored in their session cookie is
    invalid, this returns the URL for the login page instead."""
    role = session.get('role', None)
    if role=='visitor':
        home_endpoint='visitor_home'
    elif role=='helper':
        home_endpoint='helper_home'
    elif role=='admin':
        home_endpoint='admin_home'
    else:
        home_endpoint = 'login'
    return url_for(home_endpoint)





@app.route('/edit_person', methods=['GET', 'POST'])
def edit_person():
    user_id = session["user_id"]
    role=session["role"]
    email = request.form['email']
    first_name = request.form['firstName']
    last_name = request.form['lastName']
    location = request.form['location']
    file = request.files['profileImage']
    # 如果用户没有选择文件
    data={}
    data["email"] = email
    data["first_name"] = first_name
    data["last_name"] = last_name
    data["location"] = location
    if file.filename != '':
        file.save( os.path.join(app.root_path, 'static/images')+"/"+file.filename)
        data['profile_image'] = file.filename
    User().updateWhere("user_id",user_id, data)
    user=User().get("user_id",user_id)
    return render_template(get_html(role),active_page="v2",user=user,edit_invalid="Edited successfully")





@app.route('/person', methods=['GET', 'POST'])
def person():
    user_id = session["user_id"]
    user=User().get("user_id",user_id)
    role=session["role"]
    return render_template(get_html(role),active_page="v2",user=user)


@app.route('/add_issue', methods=['POST'])
def add_issue():
    user_id = session["user_id"]
    data = request.get_json()
    summary = data.get('summary')
    description =data.get('description')
    value = {
        'user_id': user_id,
        'summary': summary,
        'description': description,
        'status': "new"
    }
    Issue().insert(value)
    return jsonify({"message": "密码更改成功"}), 200  # 返回成功的消息，HTTP 状态码为 200


@app.route('/add_comment', methods=['POST'])
def add_comment():
    user_id = session["user_id"]
    data = request.get_json()
    content = data.get('content')
    issue_id =data.get('issue_id')
    value = {
        'user_id': user_id,
        'content': content,
        'issue_id': issue_id
    }
    Comment().insert(value)
    if session["role"]!="visitor":
        #如果不是访问者 将问题状态打开为new
        issue=Issue().get("issue_id",issue_id)
        value={
            "status":"new"
        }
        Issue().updateWhere("issue_id",issue_id,value)
    return jsonify({"message": "添加信息成功"}), 200  # 返回成功的消息，HTTP 状态码为 200


@app.route('/password', methods=['POST'])
def change_password():
    # 从请求中获取 JSON 数据
    data = request.get_json()
    confirm = data.get('confirm')
    user_id=session["user_id"]
    p=flask_bcrypt.generate_password_hash(confirm)
    passwordStr=p.decode("utf-8")
    user=User().get("user_id", user_id)
    password_hash = user['password_hash']  # 数据库密码
    if flask_bcrypt.check_password_hash(password_hash, confirm):
        return jsonify({"message": "失败"}), 400
    values = {
        'password_hash': passwordStr
    }
    User().updateWhere("user_id",user_id, values)
    # 假设密码更改成功
    return jsonify({"message": "密码更改成功"}), 200  # 返回成功的消息，HTTP 状态码为 200



@app.route('/change_user_role', methods=['POST'])
def change_user_role():
    # 从请求中获取 JSON 数据
    data = request.get_json()
    user_id = data.get('user_id')
    role = data.get('role')
    values = {
        'role': role
    }
    User().updateWhere("user_id", user_id, values)
    # 假设密码更改成功
    return jsonify({"message": ""}), 200  # 返回成功的消息，HTTP 状态码为 200





@app.route('/change_user_status', methods=['POST'])
def change_user_status():
    # 从请求中获取 JSON 数据
    data = request.get_json()
    user_id = data.get('user_id')
    status = data.get('status')
    values = {
        'status': status
    }
    User().updateWhere("user_id", user_id, values)
    # 假设密码更改成功
    return jsonify({"message": ""}), 200  # 返回成功的消息，HTTP 状态码为 200



@app.route('/change_status', methods=['POST'])
def change_status():
    # 从请求中获取 JSON 数据
    data = request.get_json()
    issue_id = data.get('issue_id')
    status = data.get('status')
    values = {
        'status': status
    }
    Issue().updateWhere("issue_id", issue_id, values)
    # 假设密码更改成功
    return jsonify({"message": ""}), 200  # 返回成功的消息，HTTP 状态码为 200


@app.route('/clear_image', methods=['POST'])
def clear_image():
    user_id = session["user_id"]
    value={
        "profile_image":""
    }
    User().updateWhere("user_id", user_id, value)
    return jsonify({"message": ""}), 200  # 返回成功的消息，HTTP 状态码为 200




#$2b$12$mzpvCA3B0gmJ5OTxQhntBO86E5QdgCzuld8BsCDgyi0PTLVpTbTd6
#$2b$12$mzpvCA3B0gmJ5OTxQhntBO86E5QdgCzuld8BsCDgyi0PTLVpTbTd6


@app.before_request
def check_user_login():
    path=request.path
    # 检查是否存在 'user_id' 在 session 中
    if 'user_id' not in session:
        if path!= '/login' and path!= "/signup" and path!="/register" and path!="/check_username":  #没有登录  如果不是登录页面或追注册  返回登录页面
            return redirect(user_home_url())



@app.route('/issues_status', methods=['POST', "GET"])
def issues_status():
    global    page_size# 每页显示的记录数
    total_records=Issue().getCountWhere(f"status='new'")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    current_page = int(request.args.get('pageNum', 1))  # 如果没有，默认为 1
    offset = (current_page - 1) * page_size# 计算 OFFSET
    w = f"status = 'new' LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getWhere(w)
    # 转换 datetime 对象为字符串格式，以便 JSON 序列化
    for item in data:
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
    # 渲染 visitor_home.html，传递 issues 变量
    return render_template('visitor_home.html', issues=data, active_page="v1",current_page=current_page,total_pages=total_pages)


@app.route('/issues_all', methods=['POST', "GET"])
def get_issues_all():
    global    page_size# 每页显示的记录数
    total_records=Issue().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    current_page = int(request.args.get('current_page', 1))  # 如果没有，默认为 1
    offset = (current_page - 1) * page_size# 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getPosition(w)
    # 转换 datetime 对象为字符串格式，以便 JSON 序列化
    for item in data:
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user=User().get("user_id", item['user_id'])
        item["username"]=user['username']
    role=session["role"]
    # 渲染 visitor_home.html，传递 issues 变量
    return render_template(get_html(role), issues=data, active_page="v1",current_page=current_page,total_pages=total_pages)




@app.route('/search_issue', methods=['GET', 'POST'])
def search_issue():
    global  page_size
    role=session["role"]
    current_page = int(request.form.get('current_page'))  # 获取第一个 POST 参数
    value = request.form.get('statusSelect')  # 获取第二个 POST 参数
    key = request.form.get('statusSelect')  # 获取第三个 POST 参数
    if key=="all":
        total_records = Issue().getCount(f"")[0]['COUNT(*)']
    elif key=="resolved":
        total_records = Issue().getCountWhere(f" status = 'resolved'")[0]['COUNT(*)']
    else:
        total_records = Issue().getCountWhere(f" status != 'resolved'")[0]['COUNT(*)']
    if total_records == 0: #如果没有数据 直接返回
        return render_template(get_html(role), issues=[], current_page=0, status_select=key,  active_page="v1", total_pages=0)
    if current_page < 1:
        current_page = 1
    total_pages = (total_records + page_size - 1) // page_size
    if current_page>total_pages: #如果总页数不够 设置为第一页
        current_page = 1  #那就第一页
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    if key=="all":
        issues = Issue().getPosition(w)
    elif key=="resolved":
        issues = Issue().getWhereByLimit(" status = 'resolved'", w)
    else:
        issues = Issue().getWhereByLimit(" status != 'resolved'", w)

    for item in issues:
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user = User().get("user_id", item['user_id'])
        item["username"] = user['username']

    return render_template(get_html(role), issues=issues, current_page=current_page,status_select=key,active_page="v1",  total_pages=total_pages)






@app.route('/search_user', methods=['GET', 'POST'])
def search_user():
    global  page_size
    current_page = int(request.form.get('currentPage'))  # 获取第一个 POST 参数
    value = request.form.get('userInput')  # 获取第二个 POST 参数
    key = request.form.get('selectedText')  # 获取第三个 POST 参数
    if value=="":
        total_records=User().getCount(f"")[0]['COUNT(*)']
    else:
        total_records = User().getContainCount(key,value)[0]['COUNT(*)']
    if total_records == 0: #如果没有数据 直接返回
        return render_template('admin_home.html', users=[],  selectedText=key,userInput=value,active_page="v3", current_page=0, total_pages=0)
    if current_page<1:
        current_page=1

    total_pages = (total_records + page_size - 1) // page_size
    if current_page>total_pages: #如果总页数不够 设置为第一页
        current_page = 1  #那就第一页
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    if value == "":
        users=User().getPosition(w)
    else:
        users = User().getContainPosition(key, value, w)
    return render_template('admin_home.html', users=users, selectedText=key,userInput=value,active_page="v3", current_page=current_page, total_pages=total_pages)








@app.route('/user_management', methods=['GET', 'POST'])
def user_management():
    global    page_size# 每页显示的记录数
    total_records = User().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    current_page = int(request.args.get('current_page', 1))  # 如果没有，默认为 1
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f"LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    users = User().getPosition(w)
    return render_template('admin_home.html',users=users,active_page="v3",current_page=current_page,total_pages=total_pages)






@app.route('/all_issue_management', methods=['GET', 'POST'])
def all_issue_management():
    global    page_size# 每页显示的记录数
    total_records = Issue().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    current_page = int(request.args.get('current_page', 1))  # 如果没有，默认为 1
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f"LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getPosition(w)
    for item in data:    # 转换 datetime 对象为字符串格式，以便 JSON 序列化
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
    role=session["role"]
    return render_template(get_html(role),issues=data,active_page="v1",current_page=current_page,total_pages=total_pages)


# 进入参观者页面


@app.route('/helper_home', methods=['GET', 'POST'])
def helper_home():
    current_page = 1  # 你可以根据需要设置当前页码
    global page_size  # 每页显示的记录数
    total_records = Issue().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getPosition(w)
    for item in data:  # 转换 datetime 对象为字符串格式，以便 JSON 序列化
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user = User().get("user_id", item["user_id"])
        item["username"] = user["username"]
    return render_template('helper_home.html', issues=data, active_page="v1", current_page=current_page, total_pages=total_pages)


@app.route('/admin_home', methods=['GET', 'POST'])
def admin_home():
    current_page = 1  # 你可以根据需要设置当前页码
    global page_size  # 每页显示的记录数
    total_records = Issue().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getPosition(w)
    for item in data:  # 转换 datetime 对象为字符串格式，以便 JSON 序列化
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user=User().get("user_id",item["user_id"])
        item["username"]=user["username"]
    return render_template('admin_home.html', issues=data, active_page="v1", current_page=current_page,  total_pages=total_pages)

@app.route('/visitor_home', methods=['GET', 'POST'])
def visitor_home():
    current_page = 1  # 你可以根据需要设置当前页码
    global page_size  # 每页显示的记录数
    total_records = Issue().getCount(f"")[0]['COUNT(*)']
    total_pages = (total_records + page_size - 1) // page_size
    offset = (current_page - 1) * page_size  # 计算 OFFSET
    w = f" LIMIT {page_size} OFFSET {offset}"  # 使用 OFFSET 值来构建查询
    data = Issue().getPosition(w)
    for item in data:  # 转换 datetime 对象为字符串格式，以便 JSON 序列化
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user = User().get("user_id", item["user_id"])
        item["username"] = user["username"]
    return render_template('visitor_home.html', issues=data, active_page="v1", current_page=current_page,
                           total_pages=total_pages)


@app.route('/get_comment', methods=['GET', 'POST'])
def get_comment():
    data = request.get_json()
    issue_id = data.get('issue_id')  # 获取请求体中的 issue_id
    w=f"issue_id={issue_id}" #获取信息
    comments = Comment().getWhere(w) #获取所有评论
    for item in comments:    # 转换 datetime 对象为字符串格式，以便 JSON 序列化
        item['create_at'] = item['create_at'].isoformat()  # 转换为 ISO 格式字符串
        user_id = item['user_id']
        user = User().get("user_id", user_id)
        item["username"] = user["username"]
        item["role"] = user["role"]
        item["profile_image"] = user["profile_image"]
    print("成功")
    return jsonify({"message": "Success", "comments": comments}),200




@app.route('/')
def root():
    return redirect(user_home_url())


#密码验证原理
# b=flask_bcrypt.generate_password_hash("123456")
# h=flask_bcrypt.check_password_hash(b, "123456")
# stringData=b.decode("utf-8")
# by=flask_bcrypt._unicode_to_bytes(stringData)
#$2b$12$jS9PbF2P3pRCCF8bn0Xfveotf7n6ANNIZlJQsm.RnSOol.1qTATou  密码123456789a测试


@app.route('/login', methods=['GET', 'POST'])
def login():
    input="123456789a"#输入密码
    password_hash=flask_bcrypt.generate_password_hash(input) #二·进制密码
    h=flask_bcrypt.check_password_hash(password_hash, input) #密码匹配成功  匹配二进制
    sql=password_hash.decode("utf-8")  #转换字符串插入数据库
    # er = flask_bcrypt._unicode_to_bytes(sql) #数据转字符串
    # h1=flask_bcrypt.check_password_hash(password_hash, input) #密码匹配成功  匹配二进制
    # h1=flask_bcrypt.check_password_hash(password_hash, "456") #密码匹配成功  匹配二进制
    # by=flask_bcrypt._unicode_to_bytes(stringData)
    if 'loggedin' in session:
         return redirect(user_home_url())
    if request.method=='POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        user = User().get("username", request.form['username'])


        if user is not None:
            if user["status"] != "active":
                return render_template('login.html',
                                       username=username,
                                       password_invalid=True)


            password = request.form['password']  #输入的密码
            password_hash = user['password_hash']  #数据库密码
            password_hash=flask_bcrypt._unicode_to_bytes(password_hash)

            if flask_bcrypt.check_password_hash(password_hash, password):
                session['loggedin'] = True
                session['user_id'] = user['user_id']
                session['username'] = user['username']
                session['role'] = user['role']
                return redirect(user_home_url())
            else:
                return render_template('login.html',
                                       username=username,
                                       password_invalid=True)
        else:
            return render_template('login.html',
                                   username=username,
                                   username_invalid=True)
    return render_template('login.html')


@app.route('/check_username', methods=['POST'])
def check_username():
    data = request.get_json()  # 获取前端传来的 JSON 数据
    username = data.get('username')
    user=User().get("username", username)
    if user is None:
        return jsonify({}), 200 #不存在返回true
    return jsonify({}), 400 #存在返回false


@app.route('/register', methods=['GET', 'POST'])
def register():
        # 获取表单数据
        username = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirmPassword')
        firstname = request.form.get('firstname')
        lastname = request.form.get('lastname')
        location = request.form.get('location')
        password_hash=flask_bcrypt.generate_password_hash(password) #二·进制密码
        password_hash = password_hash.decode("utf-8")  # 转换字符串插入数据库
        value={
            'username': username,
            'email': email,
            'password_hash': password_hash,
            'first_name': firstname,
            'last_name': lastname,
            'location': location,
            'role':"visitor",
            'status':"active"
        }
        user = User().get("username", username)
        if user:
            return render_template('signup.html', message="The username already exists")
        User().insert(value)
        return render_template('signup.html',message="registered successfully!")

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    return render_template('signup.html')



@app.route('/logout', methods=['GET', 'POST'])
def logout():
    session.pop('loggedin', None)
    session.pop('user_id', None)
    session.pop('username', None)
    session.pop('role', None)
    return redirect(url_for('login'))