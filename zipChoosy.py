import os
import zipfile
def zipChoosy(path,type):
    folder=path
    zipName=os.path.basename(folder)
    zipPath=os.path.dirname(folder)
    zipFile=zipfile.ZipFile(folder+'.zip','w')
    for foldername, subfolders, filenames in os.walk(folder):
        print('Adding files in %s...' % (os.path.relpath(foldername, zipPath)))
    # Add all the files in this folder to the ZIP file.
        for filename in filenames:
            if filename.endswith(type):
                print(os.path.join(os.path.relpath(foldername, zipPath),filename))
                zipFile.write(os.path.join(foldername, filename),
                os.path.join(os.path.relpath(foldername, zipPath),filename))
        
    zipFile.close()
    print('Done.')

zipChoosy('D:\data\project\python','.py')