import sys
import csv

output_filename = "output/results.pl"


# Function for generating the output file.
# Uses globals output_filename, people, and preferences
def generate_preference_file(out_filename, students, student_preferences):
    with open(out_filename, "w+") as out_file:
        # Print Header comment.
        out_file.write('% pref(Student1, Student2, Preference) - High preference is better.\n')
        out_file.write('% Read "Student1 ranks Student2 with preference Preference,\n')
        out_file.write('%       where higher Preference is better."\n\n')

        # Print Student Preference Rules
        for ranking_student in student_preferences:
            prefs = student_preferences[ranking_student]
            for i in range(0,len(prefs)):
                ranked_student = students[i]
                pref = prefs[i]
                out_file.write('pref("%s", "%s", %s).\n' % (ranking_student, ranked_student, pref))




# Main code.
if __name__ == "__main__":
    # Get input file name.
    if len(sys.argv) == 1:
        print("ERROR: Please give input file name as commandline argument.")

    input_filename = sys.argv[1]

    # Open file and read input.
    rows = []
    with open(input_filename, 'rb') as csv_file:
        file_reader = csv.reader(csv_file)
        strings = []
        for row in file_reader:
            rows.append(row)

    # Reformat input for easy use.
    people = rows[0][1:len(rows[0]) - 1]
    preferences = {}
    for row in rows[1:len(rows[0]) - 1]:
        name = row[0]
        prefs = row[1:len(row) - 1]
        preferences[name] = prefs

    # Accept output filename as command line argument.
    if len(sys.argv) >= 3:
        output_filename = sys.argv[2]

    # Write result to lp file.
    generate_preference_file(output_filename, people, preferences)




