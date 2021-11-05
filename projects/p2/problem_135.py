def compress(s):
    table = dict((chr(i), i) for i in range(256))
    output = []
    c = s[0]
    index = 256
    for i in range(1, len(s)):
        cc = s[i]
        if c + cc in table.keys():
            c = c + cc
        else:
            output.append(table[c])
            table[c + cc] = index
            index += 1
            c = cc
    output.append(table[c])
    return output


def decompress(codes):
    table = {}
    for i in range(256):
        table[i] = chr(i)
    s = ""
    c = codes[0]
    s += table[c]
    index = 256
    x = ""
    for i in range(1, len(codes)):
        cc = codes[i]
        if cc not in table.keys():
            temp = table[c]
            temp = temp + x
        else:
            temp = table[cc]
        s += temp
        x = temp[0]
        table[index] = table[c] + x
        index += 1
        c = cc
    return s


if __name__ == "__main__":
    read = input("Please input a string to be compressed:")
    codes = compress(read)
    print("The compressed codes are: ")
    print(codes)
    string = decompress(codes)
    print("The decompressed string is:", string)
    if string == read:
        print("Success!")
