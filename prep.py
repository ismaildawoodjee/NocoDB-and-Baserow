import pandas as pd

df = pd.read_csv("./source-data/flights.csv")
old_df = df.iloc[5:10,[1,4,5,7]]  # columns to sample types from numeric, string, date, another string
new_df = df.iloc[10:15,[1,4,5,7]]

old_df.to_csv("old_flights.csv", index=False)
new_df.to_csv("new_flights.csv", index=False)
