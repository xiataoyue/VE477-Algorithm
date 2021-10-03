phonebook = dict()

while True:
	args = input().split()
	if args[0] == "add":
		phonebook[args[1]] = int(args[2])
	elif args[0] == "edit":
		if args[1] in phonebook.keys():
			phonebook[args[1]] = int(args[2])
	elif args[0] == "remove":
		if args[1] in phonebook.keys():
			phonebook.pop(args[1])
	elif args[0] == "quit":
		break
	else:
		continue

	print(phonebook)
