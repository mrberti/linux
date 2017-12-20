import re

file_name = 'test.csv'

search_for_path = 1
text = '';
with open(file_name,'r') as f:
    for line in f:
        if search_for_path == 1:
            str = re.findall(r'^path.*$',line)
            if len(str) > 0:
                search_for_path = 0
                vars = re.split(r',',str[0])
                new_line = str[0]
                for x in vars:
                    temp = re.split(r'/',x)
                    if len(temp) < 2:
                        continue
                    y = temp[-1]
                    new_line = new_line.replace(x,y)
                text = text + new_line
        else:
            text = text + line

print(text)