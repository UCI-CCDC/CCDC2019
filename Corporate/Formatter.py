
# make infile the name of the file you are reading from
infile = open("commons.txt", "r")
outfile = open("output.txt", "w")
output = []

global contains
global wordNumber
global wordNumbers

# only get a word from a line that contains this word: (ie Running to only get words from a line that contain the word Running)
contains = ""

# Only get this number word from each line in a file   (ie 0 to get the first word in each line)
wordNumber = 0

# Only get these number words from each line in a file (ie [2,3,4] to get the third fourth and fifth word in each line)
wordNumbers = []

for line in infile:
    if line.find(contains)>=0 or not contains:
        sp = line.split()
        count=0
        for word in sp:
            if count == wordNumber or count in wordNumbers:
                output.append(word)
            count += 1

print(output)

# Edit this to format how the new document is printed
for word in output:
    outfile.write(word + ",")

outfile.close()
infile.close()

'''If the program doesn't work or seems to write words that are not the words from the read file, 
    I recomend copying everything in the read file, then pasting it to a new txt document   '''