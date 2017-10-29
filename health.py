import os
import operator
import time

def check_drafts(directory):
    files = {}
    for filename in os.listdir(directory):
        if filename.endswith('.rst') or filename.endswith('.md'):
            statbuf = os.stat(directory+filename)
            files[filename] = statbuf.st_mtime
        else:
            continue

    for key, value in sorted(files.items(), key=operator.itemgetter(1)):
        days_since_last_edit = (time.time() - value)/86400
        s = ''
        if days_since_last_edit > 60:
            s += '\x1b[6;30;41m'
            #  print('\x1b[6;30;41m' + 'Success!' + '\x1b[0m')
        elif days_since_last_edit < 14:
            s += '\x1b[6;30;42m'
            #  print("{0}: {1:3.0f} days ago".format(key, (time.time() - value)/86400))
        s += "{0}: {1:3.0f} days ago".format(key, (time.time() - value)/86400) + '\x1b[0m'

        print(s)
if __name__ == '__main__':
    directory = 'content/drafts/'
    check_drafts(directory)
