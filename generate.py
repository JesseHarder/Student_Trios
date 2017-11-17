import sys
import csv


def generate(input_filename, output_filename="preferences/results.lp"):
    # Open file and read input.
    rows = []
    with open(input_filename, 'rb') as csv_file:
        file_reader = csv.reader(csv_file)
        strings = []
        for row in file_reader:
            rows.append(row)

    # Reformat input for easy use.
    people = rows[0][1:len(rows[0])]
    preferences = {}
    for row in rows[1:len(rows[0])]:
        name = row[0]
        prefs = row[1:len(row)]
        preferences[name] = prefs

    # Write result to lp file.
    write_preference_file(output_filename, people, preferences)


# Function for creating and writing to the output file.
# Uses globals output_filename, people, and preferences
def write_preference_file(out_filename, students, student_preferences):
    with open(out_filename, "w+") as out_file:
        # Print Header comment.
        out_file.write('% pref(Student1, Student2, Preference) - High preference is better.\n')
        out_file.write('% Read "Student1 ranks Student2 with preference Preference,\n')
        out_file.write('%       where higher Preference is better."\n\n')

        # Print Student Preference Facts
        vetos = []
        for ranking_student in student_preferences:
            prefs = student_preferences[ranking_student]
            for i in range(0, len(prefs)):
                ranked_student = students[i]
                # Students don't have preferences for working with themselves.
                if ranking_student == ranked_student:
                    continue

                pref = prefs[i]
                # Vetos recorded for later printing.
                if str.upper(pref) == "X":
                    vetos.append({"vetoer": ranking_student, "vetoee": ranked_student})
                    continue

                out_file.write('pref("%s", "%s", %s).\n' % (ranking_student, ranked_student, pref))
            out_file.write("\n")
        # Print Veto Facts
        if len(vetos) > 0:
            out_file.write('% Vetos(Student1, Student2) below read as '
                           '"Student1 refuses to be grouped with Student2"\n')
            for veto in vetos:
                out_file.write('vetos("%s", "%s").\n' % (veto['vetoer'], veto['vetoee']))


# Main code for running just this file.
if __name__ == "__main__":
    # Get input file name.
    if len(sys.argv) == 1:
        print("ERROR: Please give input file name as commandline argument.")

    in_filename = sys.argv[1]

    # Accept output filename as command line argument.
    if len(sys.argv) >= 3:
        generate(in_filename, sys.argv[2])
    else:
        generate(in_filename)





