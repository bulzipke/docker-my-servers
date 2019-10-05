#!/usr/bin/python3
import os

TARGET_DIR = '/data'

print('start my servers')

for target in [name for name in os.listdir(TARGET_DIR) if os.path.isdir(os.path.join(TARGET_DIR, name))]:
    for file in os.listdir('{}/{}'.format(TARGET_DIR, target)):
        if file.endswith('.py'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}/{}; nohup python3 -u {} &'.format(TARGET_DIR, target, file))
        elif file.endswith('.jar'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}/{}; nohup java -jar {} &'.format(TARGET_DIR, target, file))

print('complete')

