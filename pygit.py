import git
import logging
import time
import os
import re
# 帮助快速上传 并按后缀上传到不同的仓库中

logging.basicConfig(filename='myProgramLog_pygit.txt', level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(message)s')


def commitGit(file_address,origin_url):
    startTime=time.time()
    logging.debug('0')
    if (file_address.isspace()):#当不输入任何地址时 则在当前路径进行上传
        file_address = '.'
    os.chdir(file_address)#修改工作路径到上传的文件所在的文件夹

    try:
        repo = git.Repo(path=file_address)
    except:
        repo = git.Repo.init(path=file_address)#建立本地库
        logging.debug('Establish git sucess!')
    else:
        logging.debug('Open git sucess!')

    try:
        remote = repo.create_remote(name='origin', url=origin_url)
    except:
        repo.delete_remote('origin')
        remote = repo.create_remote(name='origin', url=origin_url)
        logging.debug('Get remote sucess!')
    else:
        logging.debug('Get remote sucess!')
    pyRegex = re.compile('.*\.py$')
    pys=[]
    for folderName, subfolders, filenames in os.walk(r'D:\data\project\test'):
    #   mo=fileRegex.search(filenames)
        for filename in filenames:
            mo=pyRegex.search(filename)
            if (mo!=None):
                pys=pys+[folderName+'\\'+filename]
    #filesname=
    os.system(r'git pull origin main:master')
    for address in pys:
        repo.index.add(address)
    t = time.localtime()
    repo.index.commit('time:'+time.asctime(t)+' author:Chan_Leo')

    os.system(r'git push origin master:main')

commitGit(r'D:\data\project\test',r'git@github.com:c369578336/test.git')
"""
rarRegex = re.compile('.*\.rar$')
rars=[]
for folderName, subfolders, filenames in os.walk('D:\data\project\sundry'):
#    mo=fileRegex.search(filenames)
    for filename in filenames:
        mo=rarRegex.search(filename)
        if (mo!=None):
            rars=rars+[folderName+'\\'+filename]
print(rars)

pyRegex = re.compile('.*\.py$')
pys=[]
for folderName, subfolders, filenames in os.walk(r'D:\data\project\test'):
#    mo=fileRegex.search(filenames)
    for filename in filenames:
        mo=pyRegex.search(filename)
        if (mo!=None):
            pys=pys+[folderName+'\\'+filename]
print(pys)
"""