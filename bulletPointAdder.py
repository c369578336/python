import pyperclip
text = pyperclip.paste()

lines=text.split('\n')
newText=''
for i in lines:
    i='* '+i
    newText=newText+i+'\n'

print(newText)
pyperclip.copy(newText)
