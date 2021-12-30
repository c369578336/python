def printBoard(board):
    print(board['low-L'] + '|' + board['low-M'] + '|' + board['low-R'])
    print('-+-+-')
    print(board['mid-L'] + '|' + board['mid-M'] + '|' + board['mid-R'])
    print('-+-+-')
    print(board['top-L'] + '|' + board['top-M'] + '|' + board['top-R'])

def checkwin(board,chess,thekey):
    # 判断所给的棋子是否获胜
    # 参数为棋盘上的棋子（列表）和棋子符号
    # 以下是所有可能胜利的情况，共8种
    return ((board[thekey[7-1]] == chess and board[thekey[8-1]] == chess and board[thekey[9-1]] == chess) or 
    (board[thekey[4-1]] == chess and board[thekey[5-1]] == chess and board[thekey[6-1]] == chess) or 
    (board[thekey[1-1]] == chess and board[thekey[2-1]] == chess and board[thekey[3-1]] == chess) or 
    (board[thekey[7-1]] == chess and board[thekey[4-1]] == chess and board[thekey[1-1]] == chess) or 
    (board[thekey[8-1]] == chess and board[thekey[5-1]] == chess and board[thekey[2-1]] == chess) or 
    (board[thekey[9-1]] == chess and board[thekey[6-1]] == chess and board[thekey[3-1]] == chess) or
    (board[thekey[7-1]] == chess and board[thekey[5-1]] == chess and board[thekey[3-1]] == chess) or
    (board[thekey[9-1]] == chess and board[thekey[5-1]] == chess and board[thekey[1-1]] == chess)) 

theBoard = {'top-L': ' ', 'top-M': ' ', 'top-R': ' ',
'mid-L': ' ', 'mid-M': ' ', 'mid-R': ' ',
'low-L': ' ', 'low-M': ' ', 'low-R': ' '}
thekey=['top-L', 'top-M', 'top-R',
'mid-L', 'mid-M', 'mid-R',
'low-L', 'low-M', 'low-R']
chess=['x','o']
i=0
while i <9:
    print("it's "+chess[i%2]+" turn!")
    m=input()
    try:
        m=int(m)
    except ValueError:
        print("The location is error!")
        i=i-1
    if (m<=9 and m>=1):
        if theBoard[thekey[m-1]]==' ':
            theBoard[thekey[m-1]]=chess[i%2]
        else:
            print("There has been a chess!")
            i=i-1
    else:
        print("The location is error!")
        i=i-1
    printBoard(theBoard)
    if (checkwin(theBoard,chess[i%2],thekey)):
        print("You are win!")
        break
    print(' ')
    i=i+1