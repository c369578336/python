import sys
import pyperclip

password = {
    'QQ': "ilovey",
    'wechat': "4everuntil",
    'admin': "myQ"
}

account=input()
try:
    pyperclip.copy(password[account])
    print('Password for ' + account + ' copied to clipboard.')
except:
    print('There is no account named ' + account)

password[account]=input()
try:
    pyperclip.copy(password[account])
    print('Password for ' + account + ' copied to clipboard.')
except:
    print('There is no account named ' + account)
