src = "/usr/share/wordlists/rockyou.txt"

vowel_replc = {
	'A':'@',
	'a':'@',
	'E' : '#',
	'e' : '#',
	'O' : '0',
	'o' : '0',
	'I' : '!',
	'i' : '!'
}

	
prev_line = ""
with open(src, "r", encoding='utf-8') as original:
	with open("/home/nexxsys/rockyou2.txt", 'w', encoding='utf-8') as revised:
		content = original.readlines()
		for line in content:
			line = line.strip()
			orig_val = line
				
			if line.isnumeric(): 				
				if line != prev_line:
					#print(f'Is Numeric {line}')
					revised.write(line + "\n") # right the revised
					prev_line = line
			else:
				# Write out original value
				# Write out Original value capitalized
				revised.write(orig_val + "\n") # right the revised
				revised.write(orig_val.upper() + "\n")
				for i in range(10):
					revised.write(orig_val + str(i) + "\n")					
					revised.write(orig_val.upper() + str(i) + "\n")
				
				for i in range(len(line)):
					char = line[i]
					if vowel_replc.get(char) != None:
						new_line = line.replace(char, vowel_replc[char])
						revised.write(new_line + "\n") # right the revised
						revised.write(new_line.upper() + "\n")
						revised.write(new_line + "!" + "\n")
						for i in range(10):
							revised.write(new_line + str(i) + "\n") # right the revised
							revised.write(new_line.upper() + str(i) + "\n")
