import os
import sys

class TextAnalysis:

    def __init__(self):
        print("Starting text analysis")
        self.fileObj = None
        self.frequency_table = {}

    def load_text_file(self, inputFilename):
        if not  os.path.exists(inputFilename):
            print('The file %s does not exist. Quitting...' % inputFilename)
            sys.exit()
        else:
            self.fileObj = open(inputFilename)
            content = self.fileObj.read()
            self.fileObj.close()
            return content

    def calculate_character_frequency(self, lines):
        for line in lines:
            line = line.lower()
            for char in line:
                if char in self.frequency_table.keys():
                    self.frequency_table[char] = self.frequency_table.get(char) + 1
                else:
                    self.frequency_table[char] = 1
        print(self.frequency_table)


if __name__ == '__main__':
    text = TextAnalysis()
    test = text.load_text_file("cryptograms/plain_text/text1.txt")

    if input is not None:
        print(test)
        print(type(test))
        print(len(test))

        lines = test.split('\n')
        print(lines[0])
        print(type(lines[0]))
        print(len(lines[0]))

        text.calculate_character_frequency(lines)

