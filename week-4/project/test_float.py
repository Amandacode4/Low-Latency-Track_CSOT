import re
with open('pipeline.cpp', 'r') as f:
    code = f.read()

# First restore to #2673 logic (which I need to do anyway)
# Let's write the #2673 logic first!
