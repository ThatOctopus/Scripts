from jira import JIRA
import re
import mysql.connector
import time
from datetime import datetime
from datetime import timedelta

con = mysql.connector.connect(user='testuser', password='password', host='localhost', database='testdb')
c = con.cursor()
c.execute('SELECT E_Jira_Number FROM T_Jira')
result_set = c.fetchall()
x = 1
while x < 5:
	options = {
	    'server': 'https://twukcore14.uk.titania.com:8443','verify': False}
	jira = JIRA(options, basic_auth=('jirawatcher' , 'WH8F5Nxwu6Z9XA2M'), validate=True)
	for row in result_set:
		issue = jira.issue(row , fields='summary, status, updated')
		summary = issue.fields.summary
		status = issue.fields.status
		update = issue.fields.updated
		update = update[:-9]
		update = datetime.strptime(update, '%Y-%m-%dT%H:%M:%S')
		update = datetime.strftime(update, '%H:%M %d-%m-%Y')
		summary = summary.replace("'", "")
		sql = "UPDATE T_Jira SET E_Ticket_Title = '" + str(summary) + "', E_Updated = '" + str(update) + "' , E_Status = '" + str(status) + "' WHERE E_Jira_Number = '" + str(issue) + "';"	
       		c.execute(sql)
        	con.commit()
	time.sleep(6) 
	x = x+1
print("Script Finished")
