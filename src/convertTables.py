def main():
    sizes = [10, 20, 30, 40, 50]
    probabilities = [0.05, 0.1, 0.2, 0.25, 0.33]
    probabilitiesStr = ['05', '1', '2', '25', '33']
    seeds=20

    prob=""
    
    for c in range(2):
        for i in sizes:
            with open("../data/code"+str(c+1)+"/size_"+str(i)+".out","r") as f:
                lines=f.readlines()
            with open("../data/code"+str(c+1)+"/size_"+str(i)+".out","w") as f:
                f.write("solution runtime prob\n")
                for line in lines:
                    if len(line.split(" "))==2:
                        prob=line.split(" ")[-1]
                    else:
                        f.write(line.strip("\n")+" "+prob)

    for c in range(2):
        for p in range(len(probabilities)):
            with open("../data/code"+str(c+1)+"/prob_"+probabilitiesStr[p]+".out","w") as fp:
                fp.write("solution runtime size\n")
                for i in sizes:
                    with open("../data/code"+str(c+1)+"/size_"+str(i)+".out","r") as f:
                        lines=f.readlines()
                        for j in range(seeds):
                            line=lines[p*seeds+1+j]
                            lineArr=line.split(" ")
                            lineArr[2]=str(i)
                            line=" ".join(lineArr[0:3])
                            fp.write(line+"\n")


	



# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/