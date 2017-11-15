import sys

if __name__ == "__main__":
    # Get input file name.
    if len(sys.argv) == 1:
        print("ERROR: Please give input file name as commandline argument.")

    filename = sys.argv[1]

    # Open file.
    # Read input.
    # Write result to lp file.