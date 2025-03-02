
import glob
from app import app
alist=glob.glob('static/*')
#设置允许的文件格式
# If run.py was actually executed (run), not just imported into another script,
# then start our Flask app on a local development server. To learn more about
# how we check for this, refer to https://realpython.com/if-name-main-python/.
if __name__ == "__main__":
    # app.run(host="127.0.0.1",debug=True)
    app.run(host="0.0.0.0",debug=True)