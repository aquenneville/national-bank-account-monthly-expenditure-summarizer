#national-bank-account-monthly-expenditure-summarizer

I was asked by my father to create a monthly Tax report on the deposit/debits of his <a href="https://en.wikipedia.org/wiki/National_Bank_of_Canada
">National Bank</a> business account. 

Features
---------------------------------------------------------
- Calculate the GST (Goods and services tax - Canada/TPS)
- Calculate the QST (Quebec sales tax - Quebec/TVQ)
- Sum/group lines with similar description 
- Use the Csv exported files from <a href="https://commercial.bnc.ca/auth/Login?GAURI=https%3A%2F%2Fcommercial.bnc.ca%2FSBIComWeb%2FLogonDispatch%3FfromPortail%3Dtrue%26lang%3Den&URI=https%3A%2F%2Fcommercial.bnc.ca%2FSBIComWeb%2FLogonDispatch%3FfromPortail%3Dtrue%26lang%3Den">National bank internet banking</a>.
  

Usage
---------------------------------------------------------
national-bank-account-monthly-expenditure-summarizer.sh -y 2014 -m 3 -f 2014033r3747437928.csv

