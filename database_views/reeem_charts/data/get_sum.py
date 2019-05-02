import os
import pandas as pd

files = [f for f in os.listdir('.') if os.path.isfile(f)]
input_files = []
output_files = []
io_files = []

for f in files:
    if '_input.csv' in f:
        input_files.append(f)
        io_files.append(f)
    if '_output.csv' in f:
        output_files.append(f)
        io_files.append(f)

print(input_files)
print(output_files)
print(io_files)

df_i = pd.DataFrame()
for file in input_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema']).sum()
    df.drop('id', axis=1, inplace=True)
    df_i = df_i.append(df)
    df_i = df_i.groupby(['schema']).sum()
df_i.to_csv('all_i.csv', encoding='utf-8')

df_o = pd.DataFrame()
for file in output_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema']).sum()
    df.drop('id', axis=1, inplace=True)
    df_o = df_o.append(df)
    df_o = df_o.groupby(['schema']).sum()
df_o.to_csv('all_o.csv', encoding='utf-8')


df_io = pd.DataFrame()
for file in io_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema']).sum()
    df.drop('id', axis=1, inplace=True)
    df_io = df_io.append(df)
    df_io = df_io.groupby(['schema']).sum()
df_io.to_csv('all_io.csv', encoding='utf-8')
