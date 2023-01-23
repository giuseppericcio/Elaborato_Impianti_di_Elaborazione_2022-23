def average_from_file(file_path, output_file):
    with open(file_path, 'r') as file:
        numbers = []
        averages = []
        for line in file:
            if line.strip() != "":
                numbers.append(int(line))
            if len(numbers)==5:
                averages.append(sum(numbers) / len(numbers))
                numbers = []
        with open(output_file, "w") as output:
            for average in averages:
                output.write(str(average) + "\n")

print(average_from_file("Desktop/results1000000.txt", "Desktop/medie1000000.txt"))