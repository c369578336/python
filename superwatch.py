import logging
import time
logging.basicConfig(filename='myProgramLog.txt', level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
#日志信息将被保存到myProgramLog.txt
print('Press ENTER to begin. Afterwards, press ENTER to "click" the stopwatch.Press Ctrl-C to quit.')
input() # press Enter to begin
print('Started.')
startTime = time.time() # get the first lap's start time
lastTime = startTime#用于计算每一圈经过的时间
lapNum = 1#计数器
try:
    while True:
        logging.debug('waiting for enter')
        input()#其实输入任何字符都能运行
        lapTime = round(time.time() - lastTime, 2)#round 四舍五入
        logging.debug(lapTime)#logging  生成日志文件
        totalTime = round(time.time() - startTime, 2)
        print('Lap #%s: %s (%s)' % (lapNum, totalTime, lapTime), end='')
        lapNum += 1
        lastTime = time.time() # reset the last lap time
except KeyboardInterrupt:
# Handle the Ctrl-C exception to keep its error message from displaying.
    print('\nDone.')