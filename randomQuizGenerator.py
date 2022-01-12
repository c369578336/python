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
    quizFile = open('quiz'+str(i+1)+'.txt','w')
    answerFile = open('answer'+str(i+1)+'.txt','w')
    random.shuffle(states)
    for j in range(states.__len__()):
        t=random.sample(states,3)
        t.append(states[j])
        answers=dict(zip(range(4),t))
        random.shuffle(options)
        k=options.index(3)
        answerFile.write("%-10s"%(str(j+1)+'.'+chr(k+ord('A'))))
        s=s+1
        if (s %5 == 0):
            answerFile.write('\n')
        quizFile.write("What is the capital of "+states[j]+'?\n')
        quizFile.write("%-20s%-20s%-20s%s\n"%('A:'+capitals[answers[options[0]]],'B:'+capitals[answers[options[1]]],'C:'+capitals[answers[options[2]]],'D:'+capitals[answers[options[3]]]))
        quizFile.write("\n")
    quizFile.close()
    answerFile.close()
    quizZipFile.write('quiz'+str(i+1)+'.txt',compress_type=zipfile.ZIP_DEFLATED)
    anwersZipFile.write('answer'+str(i+1)+'.txt',compress_type=zipfile.ZIP_DEFLATED)
    os.remove('quiz'+str(i+1)+'.txt')
    os.remove('answer'+str(i+1)+'.txt')



