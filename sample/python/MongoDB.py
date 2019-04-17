# coding: utf-8
from pymongo import MongoClient
from datetime import datetime

class TestMongo(object):

     def __init__(self):
         self.clint = MongoClient()
         self.db = self.clint['test']

     def add_one(self):
        """データ挿入"""
        post = {
            'title': 'ハリネズミ',
            'content': 'ハリネズミ可愛い~',
            'created_at': datetime.now()
        }
        return self.db.test.insert_one(post)

def main():
    obj = TestMongo()
    rest = obj.add_one()
    print(rest)

if __name__ == '__main__':
    main()


'''
post=[
        {'title': 'カワウソ', 'content': 'カワウソ可愛い~', 'created_at': datetime.now()},
        {'title': 'ハムスター', 'content': 'ハムスター可愛い~', 'created_at': datetime.now()},
        {'title': 'チンチラ', 'content': 'チンチラ可愛い~', 'created_at': datetime.now()}
    ]
    return self.db.test.insert_many(post)
       

def get_one(self):
    return self.db.test.find_one()

def main():
    obj = TetsMongo()
    rest = obj.get_one()
    print(rest)

def get_from_oid(self,oid):
    return self.db.test.find_one({'_id':ObjectId(oid)})
def main():
    obj = TetsMongo()
                            """_idを渡す"""
    rest = obj.get_from_oid('5c456bf0736d313a7c0afb80')
    print(rest)

def update(self):
    rest = self.db.test.update_one({"title": "ハムスター"}, {"$set": {"content": "カワウソうるさい"}})
    return rest
def main():
    obj = TetsMongo()
    rest = obj.update()
    print(rest.matched_count)


def update(self):
    """複数修正"""
    rest = self.db.test.update_many({}, {'$set': {"created_at": datetime.now()}})
    return rest

def main():
    obj = TetsMongo()
    rest = obj.update()
    print(rest.matched_count)


def delete(self):
    """マッチした最初のデータを削除"""
    rest = self.db.test.delete_one({"title":"ハムスター"})
    return rest

def main():
    obj = TetsMongo()
    rest = obj.delete()

'''