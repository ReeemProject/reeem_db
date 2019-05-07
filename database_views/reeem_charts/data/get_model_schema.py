import os
import numpy as np
import pandas as pd


files = [f for f in os.listdir('.') if os.path.isfile(f)]
input_files = []
output_files = []
io_files = []

blacklist = [
    'times_paneu_input.csv',
    'times_paneu_output.csv',
    'osembe_output.csv'
]

for f in files:
    if '_input.csv' in f:
        if f not in blacklist:
            input_files.append(f)
            io_files.append(f)
    if '_output.csv' in f:
        if f not in blacklist:
            output_files.append(f)
            io_files.append(f)

print(input_files)
print(output_files)
print(io_files)

df_i = pd.DataFrame()
for file in input_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema', 'model']).sum()
    df_i = df_i.append(df)
    df_i = df_i.groupby(['schema', 'model']).sum()
df_i.id = np.arange(0, len(df_i))
df_i.to_csv('model_schema_i.csv', encoding='utf-8')

df_o = pd.DataFrame()
for file in output_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema', 'model']).sum()
    df_o = df_o.append(df)
    df_o = df_o.groupby(['schema', 'model']).sum()
df_o.id = np.arange(0, len(df_o))
df_o.to_csv('model_schema_o.csv', encoding='utf-8')


df_io = pd.DataFrame()
for file in io_files:
    df = pd.read_csv(file, encoding='utf-8')
    df = df.groupby(['schema', 'model']).sum()
    df_io = df_io.append(df)
    df_io = df_io.groupby(['schema', 'model']).sum()
df_io.id = np.arange(0, len(df_io))
df_io.to_csv('model_schema_io.csv', encoding='utf-8')
