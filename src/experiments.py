import math
import random
import subprocess


def gen_inputs(n,p,s,f):
    random.seed(s)
    fout = open(f, "w")
    M = []
    m = 0
    for i in range(1, n):
        for j in range(i + 1, n + 1):
            if random.random() < p:
                m = m + 1
                M.append([i, j])
    fout.write(str(n) + " " + str(m) + "\n")
    for i in M:
        fout.write(str(i[0]) + " " + str(i[1]) + "\n")
    fout.close()


def convert_tables():
    sizes = [10, 20, 30, 40, 50]
    probabilities = [0.05, 0.1, 0.2, 0.25, 0.33]
    probabilitiesStr = ['05', '1', '2', '25', '33']
    seeds = 20
    prob = ""
    for c in range(2):
        for i in sizes:
            with open("../data/code" + str(c + 1) + "/size_" + str(i) + ".out", "r") as f:
                lines = f.readlines()
            with open("../data/code" + str(c + 1) + "/size_" + str(i) + ".out", "w") as f:
                f.write("solution runtime prob\n")
                for line in lines:
                    if len(line.split(" ")) == 2:
                        prob = line.split(" ")[-1]
                    else:
                        f.write(line.strip("\n") + " " + prob)
    for c in range(2):
        for p in range(len(probabilities)):
            with open("../data/code" + str(c + 1) + "/prob_" + probabilitiesStr[p] + ".out", "w") as fp:
                fp.write("solution runtime size\n")
                for i in sizes:
                    with open("../data/code" + str(c + 1) + "/size_" + str(i) + ".out", "r") as f:
                        lines = f.readlines()
                        for j in range(seeds):
                            line = lines[p * seeds + 1 + j]
                            lineArr = line.split(" ")
                            lineArr[2] = str(i)
                            line = " ".join(lineArr[0:3])
                            fp.write(line + "\n")


if __name__ == '__main__':
    random.seed(4361776588)
    for i in range(10,60,10):
        for j in (0.05, 0.1, 0.2, 0.25, 0.33):
            gen_inputs(i,j,math.ceil(random.random()+1000),"../data/input/"+i+'-'+j+".in")
            subprocess.run(["ls", "-l", "/dev/null"], capture_output=True)
    convert_tables()
