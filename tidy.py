import sys
import re

# Main code for running just this file.
if __name__ == "__main__":
    # Get input file name.
    if len(sys.argv) > 1:
        in_filename = sys.argv[1]
    else:
        in_filename = 'ASP_results/results.txt'

    # Accept output filename as command line argument.
    # if len(sys.argv) >= 3:
    #     output_filename = sys.argv[2]

    groups = {}
    ins = []
    with open(in_filename, "rb") as infile:
        for line in infile:
            # If "Answer" is found on a line, scrap results from previous answer.
            if re.match('Answer', line):
                ins = []
                groups = {}
                continue

            if re.match('in(.*)', line):
                res = re.search('in(.*)', line)
                ins = re.split(" ", line[:-1])  # -1 to remove newline character
                for item in ins:
                    # Strip the "in(" from front and ")" from the back.
                    sliced = item[3:-1]
                    split_slice = sliced.split(",")
                    group_num = int(split_slice[1])
                    student = split_slice[0][1:-1]

                    # If this groups hasn't been seen yet, initialize it.
                    if group_num not in groups.keys():
                        groups[group_num] = []

                    groups[group_num].append(student)

    # We should now have the groups.
    for (group_num, groups_members) in groups.items():
        print("Group %s" % group_num)
        for member in groups_members:
            print(member)
        print("")
