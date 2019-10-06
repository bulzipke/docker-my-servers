#!/usr/bin/python3
import os

TARGET_DIR = '/data'

print('start my servers')

for target in [name for name in os.listdir(TARGET_DIR) if os.path.isdir(os.path.join(TARGET_DIR, name))]:
    for file in os.listdir('{}/{}'.format(TARGET_DIR, target)):
        if file.endswith('.py'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}/{}; python3 -u {} >> /logs/{}.log &'.format(TARGET_DIR, target, file, target))
        elif file.endswith('.jar'):
            print('run {} in {}'.format(file, target))
            os.system('cd {}/{}; java -jar {} >> /logs/{}.log &'.format(TARGET_DIR, target, file, target))

print('complete')

