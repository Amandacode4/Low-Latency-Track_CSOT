import re
with open('pipeline.cpp', 'r') as f:
    code = f.read()

# I will write the delta logic directly using write_to_file and compile it.
