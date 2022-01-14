import random
import os
import zipfile

capitals = {'Alabama': 'Montgomery', 'Alaska': 'Juneau', 'Arizona': 'Phoenix',
'Arkansas': 'Little Rock', 'California': 'Sacramento', 'Colorado': 'Denver',
'Connecticut': 'Hartford', 'Delaware': 'Dover', 'Florida': 'Tallahassee',
'Georgia': 'Atlanta', 'Hawaii': 'Honolulu', 'Idaho': 'Boise', 'Illinois':
'Springfield', 'Indiana': 'Indianapolis', 'Iowa': 'Des Moines', 'Kansas':
'Topeka', 'Kentucky': 'Frankfort', 'Louisiana': 'Baton Rouge', 'Maine':
'Augusta', 'Maryland': 'Annapolis', 'Massachusetts': 'Boston', 'Michigan':
'Lansing', 'Minnesota': 'Saint Paul', 'Mississippi': 'Jackson', 'Missouri':
'Jefferson City', 'Montana': 'Helena', 'Nebraska': 'Lincoln', 'Nevada':
'Carson City', 'New Hampshire': 'Concord', 'New Jersey': 'Trenton', 'NewMexico': 'Santa Fe', 'New York': 'Albany', 'North Carolina': 'Raleigh',
'North Dakota': 'Bismarck', 'Ohio': 'Columbus', 'Oklahoma': 'Oklahoma City',
'Oregon': 'Salem', 'Pennsylvania': 'Harrisburg', 'Rhode Island': 'Providence',
'South Carolina': 'Columbia', 'South Dakota': 'Pierre', 'Tennessee':
'Nashville', 'Texas': 'Austin', 'Utah': 'Salt Lake City', 'Vermont':
'Montpelier', 'Virginia': 'Richmond', 'Washington': 'Olympia', 'WestVirginia': 'Charleston', 'Wisconsin': 'Madison', 'Wyoming': 'Cheyenne'}
states=list(capitals.keys())#将州名转化为lists，从而能够随机排序
quizNum=10#需要制作的quiz份数
options=[0,1,2,3]#用于产生随机的选项
quizZipFile=zipfile.ZipFile('quizZipFile.zip','w')
anwersZipFile=zipfile.ZipFile('anwersZipFile.zip','w')
for i in range(quizNum):
    s=0#用于答案的换行
    quizFile = open('quiz'+str(i+1)+'.txt','w')#新建一个题目文件
    answerFile = open('answer'+str(i+1)+'.txt','w')#新建一个答案文件
    random.shuffle(states)#对states随机排序，并作为答案
    for j in range(states.__len__()):#遍历产生题目
        t=random.sample(states,3)#随机产生三个错误答案
        t.append(states[j])
        answers=dict(zip(range(4),t))#为了能跟方便的找到答案，dict比list更方便，为此将其转为dict
        random.shuffle(options)#打乱选项
        k=options.index(3)#找到答案在随机后的正确答案
        answerFile.write("%-10s"%(str(j+1)+'.'+chr(k+ord('A'))))#将答案写入answer文件
        s=s+1
        if (s %5 == 0):
            answerFile.write('\n')#每5个答案换行
        quizFile.write("What is the capital of "+states[j]+'?\n')#写下题目
        quizFile.write("%-20s%-20s%-20s%s\n"
        %('A:'+capitals[answers[options[0]]],
        'B:'+capitals[answers[options[1]]],
        'C:'+capitals[answers[options[2]]],
        'D:'+capitals[answers[options[3]]]))#写下题目的选项
        quizFile.write("\n")
    quizFile.close()
    answerFile.close()#关闭文件
    quizZipFile.write('quiz'+str(i+1)+'.txt',compress_type=zipfile.ZIP_DEFLATED)
    anwersZipFile.write('answer'+str(i+1)+'.txt',compress_type=zipfile.ZIP_DEFLATED)#将对应的文件打包压缩
    os.remove('quiz'+str(i+1)+'.txt')
    os.remove('answer'+str(i+1)+'.txt')#删除文件



