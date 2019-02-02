def no_ports(file_in,file_out,ip):
    line_num=1
    services = []
    is_service=True
    #blank = re.compile()
    for line in file_in:
        if not line.rstrip():
            file_out.write('Services: ' + str(services).replace('[','').replace(']','').replace("'",''))
            file_out.write('\n\n')
            line_num=0
            services = []
            is_service=True
        if line_num==1:
            first = line.split(',')
            file_out.write(str("System: "+ str(first[0])))
            file_out.write(str("\nPlatform: " + str(first[1])))
            if ip:
                file_out.write(str("\nIP address: "+  str(first[2])))
        elif line_num>1 and is_service:
            try:
                service = line.replace('/','').split(',')
                int(service[1])
                services.append(service[0])
            except Exception as e:
                #print("The integer data type exception thing is called a ", e)
                file_out.write("Administrators: " + line)
                is_service = False
        elif not is_service:
            file_out.write("Users: " + line)
        line_num+=1

def format(file_in,file_out,style:int):
    if style==1:
        no_ports(file_in,file_out,True)
    elif style==2:
        no_ports(file_in,file_out,False)
    elif style==3:
        pass
    return

def get_input()->None:
    while True:
        try:
            file_in = open((input("Enter a file containing the raw inventory name[inventory.txt]: ") or 'inventory.txt'), 'r')
            break
        except:
            print("\n ERROR-File not found\n")
    while True:
        try:
            file_out = open((input("Enter a file name to write the new dictionary to[inventory_formatted.txt]") or 'inventory_formatted.txt'), 'w')
            break
        except:
            print("\n ERROR-File not found\n")
    while True:
        try:
            style = int(input("Enter a style to format the inventory in\n"
            +"1. no ports with IPs\n"
            +"2. no ports without IPs\n"
            +"3. something  else\n\nformat:"))
            if style not in range(1,4):
                raise Exception
            break
        except:
            print("\nERROR-that is not a valid format\n")
            
    format(file_in,file_out,style)

if __name__ == '__main__':
    get_input()
    print("Complete")






