#!/usr/bin/python3
import os

CURRENT_DIR = '.'

print('start my servers')

for target in [name for name in os.listdir(CURRENT_DIR) if os.path.isdir(os.path.join(CURRENT_DIR, name))]:
    for file in os.listdir('./{}'.format(target)):
        if file.endswith('.py'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}; nohup python3 {} &'.format(target, file))
        elif file.endswith('.jar'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}; nohup java -jar {} &'.format(target, file))

if os.path.isfile('cron.conf'):
    print('cron.conf found')
    os.system('cat cron.conf >> /etc/crontabs/root')
    
print('complete')

