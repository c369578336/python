# Collatz
# 输入的数字n为奇数时 output=3*n+1；为偶数时 output=n/2
import logging
logging.basicConfig(filename='myProgramLog_Collatz.txt', level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(message)s')
logging.debug('Start of Collatz')
def Collatz(n):
    logging.debug(n)
    if (n != 1):
        if (n % 2 == 0):
            Collatz(int(n/2))
        else:
            Collatz(n*3+1)

n=input()
n=int(n)
Collatz(n)