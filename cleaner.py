import re
import opencc
import argparse

def basic_cleaner(text):
    text = re.sub(r'\n\s+', '\n', text)
    text = re.sub(r'^\s+', '', text)
    text = re.sub(r'\s+$', '', text)
    return text

def s2t(text):
    return opencc.OpenCC('s2tw').convert(text)

def t2s(text):
    return opencc.OpenCC('t2s').convert(text)

def main(input_file, output_file, convert_t2s):
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    cleaned_content = basic_cleaner(content)

    if convert_t2s:
        cleaned_content = t2s(cleaned_content)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(cleaned_content)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Clean and convert the given text file.')
    parser.add_argument('input_file', type=str, help='Path to the input file.')
    parser.add_argument('output_file', type=str, help='Path to the output file.')
    parser.add_argument('--convert_t2s', action='store_true', help='Convert traditional Chinese to simplified Chinese.')
    
    args = parser.parse_args()
    main(args.input_file, args.output_file, args.convert_t2s)

