import os
import sys
import getpass
import logging
import time
import datetime
import pandas as pd
import numpy as np
from reeem_io import *
from sqlalchemy import *
    
## inputs
model = 'UCL'
pathway = 'Test_data'       # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data', 'Pilot'
version = 'V1'              # 'V2', 'V3'
    
writer = pd.ExcelWriter('test_header.xlsx') # define excel file

today = datetime.date.today()
header_data = [pathway,version,today.isoformat()]
header_columns = ['pathway','version','date']
df_header = pd.DataFrame(data=header_data).T
df_header.columns = header_columns
print(df_header.T)

# df_header.to_excel(writer,'data',index = False)
# writer.save() # write to excel