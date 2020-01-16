import random

z = 20 #Edit this for OUs
y = 10000 #Edit for Users
x = 500 #Edit for Groups
list1 = []

def addOU(i):
	f.write("dn: OU=OU%s,OU=Domain Users,DC=scalecorp,DC=local \n" % i) 
	f.write("changetype: add\n")
	f.write("objectClass: top\n")
	f.write("objectClass: organizationalUnit\n")
	f.write("ou: OU%s\n" % i)
	f.write("distinguishedName: OU=OU%s,OU=Domain Users,DC=scalecorp,DC=local\n" % i)
	f.write("name: OU%s\n" % i)
	f.write("objectCategory: CN=Organizational-Unit,CN=Schema,CN=Configuration,DC=scalecorp,DC=local\n")
	f.write("\n")
	return

def adduser(i):
	ran = z-1
	ran1 = random.randint(0,ran)
	user = "CN=User"+ str(i) +",OU=OU"+str(ran1)+",OU=Domain Users,DC=scalecorp,DC=local"
	list1.append(user)
	f.write("dn: %s\n" % user)
	f.write("changetype: add\n")
	f.write("objectClass: top\n")
	f.write("objectClass: person\n")
	f.write("objectClass: organizationalPerson\n")
	f.write("objectClass: user\n")
	f.write("cn: User%s\n" % i)
	f.write("givenName: User%s\n" % i)
	f.write("distinguishedName: %s\n" % user)
	f.write("name: User%s\n" % i)
	f.write("sAMAccountName: User%s\n" % i)
	f.write("userPrincipalName: User%s@scalecorp.local\n" % i)
	f.write("userAccountControl: 66048\n")
	f.write("\n")	
	return
	
def addgroup(i):
	ran = y-1
	ran1 = random.randint(0,10)
	f.write("dn: CN=TestGroup%s,OU=Domain Groups,DC=scalecorp,DC=local\n" % i) 
	f.write("changetype: add\n")
	f.write("objectClass: top\n")
	f.write("objectClass: group\n")
	f.write("cn: TestGroup%s\n" % i)
	f.write("distinguishedName: CN=TestGroup%s,OU=Domain Groups,DC=scalecorp,DC=local\n" % i)
	f.write("name: TestGroup%s\n" % i)
	f.write("sAMAccountName: TestGroup%s\n" % i)
	f.write("objectCategory: CN=Group,CN=Schema,CN=Configuration,DC=scalecorp,DC=local\n")
	f.write("\n")
	return
	
def addgroupmaxmin():
		f.write("dn: CN=TestGroupmax,OU=Domain Groups,DC=scalecorp,DC=local\nchangetype: add\nobjectClass: top\nobjectClass: group\ncn: TestGroupmax\ndistinguishedName: CN=TestGroupmax,OU=Domain Groups,DC=scalecorp,DC=local\nname: TestGroupmax\sAMAccountName: TestGroupmax\nobjectCategory: CN=Group,CN=Schema,CN=Configuration,DC=scalecorp,DC=local\n\ndn: CN=TestGroupmin,OU=Domain Groups,DC=scalecorp,DC=local\nchangetype: add\nobjectClass: top\nobjectClass: group\ncn: TestGroupmin\ndistinguishedName: CN=TestGroupmin,OU=Domain Groups,DC=scalecorp,DC=local\nname: TestGroupmin\nsAMAccountName: TestGroupmin\nobjectCategory: CN=Group,CN=Schema,CN=Configuration,DC=scalecorp,DC=local\n\n")
	
def addgroupmod(i):
	ran = y-1
	ran1 = random.randint(1,ran)
	list2 =[]
	for a in range(ran1):
		ran2 = random.randint(0,ran)
		mem = list1[ran2]
		list2.append(mem)
		if list2.count(mem) == 1:
			f.write("dn: CN=TestGroup%s,OU=Domain Groups,DC=scalecorp,DC=local\n" % i) 
			f.write("changetype: modify\n")
			f.write("add: member\n")
			f.write("member: %s\n" % mem)
			f.write("-")
			f.write("\n\n")
	return

def addgroupminmax():
	user = list1[1]
	f= open("Groupmodmin.ldf","w+")
	f.write("dn: CN=TestGroupmin,OU=Domain Groups,DC=scalecorp,DC=local\n") 
	f.write("changetype: modify\n")
	f.write("add: member\n")
	f.write("member: %s\n" %user )
	f.write("-")
	f.write("\n\n")
	f.close()
	f= open("Groupmodmax.ldf","w+")
	for i in range(y):
		user=list1[i]
		f.write("dn: CN=TestGroupmax,OU=Domain Groups,DC=scalecorp,DC=local\n") 
		f.write("changetype: modify\n")
		f.write("add: member\n")
		f.write("member: %s\n" % user)
		f.write("-")
		f.write("\n\n")
	f.close()
	
f= open("OU.ldf","w+")
for i in range(z):
	addOU(i)
f.close()
f= open("Users.ldf","w+")
for i in range(y):
	adduser(i)
f.close()
f= open("Groups.ldf","w+")
for i in range(x):
	addgroup(i)
addgroupmaxmin()
f.close()
f= open("Groupmod.ldf","w+")
for i in range(x):
	addgroupmod(i)
f.close()
addgroupminmax()


print("Script Complete! Press Any Key To Finish")
input()	
