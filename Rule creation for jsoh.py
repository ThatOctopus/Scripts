def test(i):
	f.write("access-list RAR extended permit udp any4 any4 eq %s log\n" % i)
	
z = 65000
f= open("test.txt","w+")
for i in range(z):
	test(i)
f.close()
print("Script Complete! Press Any Key To Finish")
input()	
