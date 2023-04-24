import numpy as np
from pypinyin import lazy_pinyin
import csv

class IdiomPinyinMeaning(object):
    def __init__(self,idiom,pinyin,meaning,start,end):
        self.idiom = idiom
        self.pinyin = pinyin
        self.meaning = meaning
        self.start = start
        self.end = end
    
    def __str__(self):
        return self.idiom+self.pinyin+self.meaning
    
    def __hash__(self):
        return hash(self.idiom)+hash(self.meaning) + hash(self.pinyin)
    
    def __eq__(self, other):
        if isinstance(other,self.__class__):
            return False
        else:
            return self.idiom == other.idiom 

if __name__ == "__main__":
    #test
    f = r"C:\Users\xiaoshuyui\Downloads\ids.txt"
    
    fil = open(f,'r',encoding='gbk',errors='ignore')
    lis = fil.readlines()
    ll = set()

    print(len(lis))

    for i in lis:
        if i.strip() == "":
            pass
        else:
            # i = i.decode("gbk","ignore")
            # s = i.replace(" ","")
            # word = i[0:5]
            # print(i.encode("utf-8").decode("utf-8"))
            # print(i)
            tmp = i.split("拼音：")
            # print(tmp)
            if len(tmp)==2:
                ttmp = tmp[1]
                tttmp = ttmp.split("释义：")

                ii = lazy_pinyin(tmp[0].strip())
                start = ii[0]
                end = ii[-1]


                aa = IdiomPinyinMeaning(tmp[0],tttmp[0],tttmp[1],start,end)
                ll.add(aa)

    # print(len(list(ll)))
        
    
    # print(list(ll))
    # for i in list(ll):
    #     print(i)

    with open("practice.csv","w",encoding="utf-8") as f:
        writer = csv.writer(f)

        for i in list(ll):
            if i.idiom != "":
                writer.writerow([i.idiom,i.pinyin,i.meaning])

    # ar = np.array(list(ll))

    # np.save("D:\\testALg\\WebBrowser-python-pyqt5-14\\ChineseIdiomQuiz\\static\\idioms.npy",ar)