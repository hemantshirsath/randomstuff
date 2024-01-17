# 1 - Write a Python program to display first 5 rows from COVID-19 dataset. Also print the dataset information and check the missing


import pandas as pd

# Load the COVID-19 dataset (replace 'dataset.csv' with the actual file path)
file_path = '/content/covid_19_clean_complete.csv'
df = pd.read_csv(file_path)

# Display the first 5 rows
print("First 5 rows of the dataset:")
print(df.head())

# Print dataset information
print("\nDataset Information:")
print(df.info())

# Check for missing values
missing_values = df.isnull().sum()
print("\nMissing Values:")
print(missing_values)


# 2 - Write a Python program to get the latest number of confirmed, deaths, recovered and active cases of Novel Coronavirus (COVID-19) Country wise.

import pandas as pd
covid_data= pd.read_csv('/content/covid_19_clean_complete.csv')
covid_data['Active'] = covid_data['Confirmed'] - covid_data['Deaths'] - covid_data['Recovered']
result = covid_data.groupby('Country/Region')[['Confirmed', 'Deaths', 'Recovered',
'Active']].sum().reset_index()
print(result)

# 3- Write a Python program to get the latest number of confirmed deaths and recovered people of Novel Coronavirus (COVID-19) cases Country/Region - Province/State wise.


import pandas as pd
covid_data= pd.read_csv('/content/covid_19_clean_complete.csv')
data = covid_data.groupby(['Country/Region', 'Province/State'])[['Confirmed', 'Deaths',
'Recovered']].max()
pd.set_option('display.max_rows', None)
print(data)


# 4 Write a Python program to list countries with no cases of Novel Coronavirus (COVID-19) recovered.

import pandas as pd
covid_data= pd.read_csv('/content/covid_19_clean_complete.csv')
data = covid_data.groupby('Country/Region')[['Confirmed', 'Deaths', 'Recovered']].sum().reset_index()
result = data[data['Recovered']==0][['Country/Region', 'Confirmed', 'Deaths', 'Recovered']]
print(result)


# 5- Write a Python program to get the top 10 countries data (Last Update, Country/Region, Confirmed, Death s, Recovered) of Novel Coronavirus (COVID-19).

import pandas as pd
covid_data= pd.read_csv('/content/covid_19_clean_complete.csv', usecols = ['Province/State', 'Country/Region',
'Confirmed', 'Deaths', 'Recovered','Active','WHO Region'])
result = covid_data.groupby('Country/Region').max().sort_values(by='Confirmed',
ascending=False)[:10]
pd.set_option('display.max_column', None)
print(result)




# 6 Write a Python program to visualize Worldwide Confirmed Novel Coronavirus (COVID-19) cases over
# time.

import pandas as pd
import plotly.express as px
import plotly.io as pio

pio.templates.default = "plotly_dark"

# Read the dataset
covid_data = pd.read_csv('/content/dataset.csv')

# Convert 'Date' column to datetime format
covid_data['Date'] = pd.to_datetime(covid_data['Date'], format='%d-%m-%Y')

# Group by 'Date' and sum the 'Confirmed' and 'Deaths'
grouped = covid_data.groupby('Date')[['Date', 'Confirmed', 'Deaths']].sum().reset_index()

# Create the line plot
fig = px.line(grouped, x="Date", y="Confirmed",
              title="Worldwide Confirmed Novel Coronavirus(COVID-19) Cases Over Time")

# Show the plot
fig.show()
