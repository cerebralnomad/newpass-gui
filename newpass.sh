#!/usr/bin/env python3

import string
import argparse
from secrets import choice

def main():
    
    parser = argparse.ArgumentParser(
            formatter_class = argparse.RawDescriptionHelpFormatter,
            description = 'Generate a random password of a specified length',
            prog = 'Password Generator',
            usage = 'newpass [option] [length]',
            epilog = ('''\
    examples:

        newpass - generates a 23 character alphanumeric password
        newpass 20 - generates a 20 character alphanumeric password
        newpass -s 25 - generates a 25 character password that can include all symbols
        newpass -l 15 - generates a 15 character password that can include symbols !@#$%&*

        If both -s and -l flags are used (-sl, -ls) the -s takes 
        precedence and the -l is ignored

        Passwords created always start with a letter, contain at least
        one capital and one lowercase letter and at least 3 digits and
        will not include a capital O to avoid confusion with zero
                    ''')
                    )
    parser.add_argument('length', type = int, nargs='?', default = 23, help = 'Desired password length. If not specified, default is 23')
    parser.add_argument('--symbol', '-s', help = 'Include all symbols in the password', action='store_true')
    parser.add_argument('--limit', '-l', default=False, help = "Limit symbols used to !@#$%%&*", action='store_true')
    args = parser.parse_args()

    punc = '!"#$%&\'()*+,-:;=?@[\]^_{}~'
    limit_punc = '!@#$%*&!@#$%&*'
    length = args.length
    alphabet = string.ascii_letters[0:40] + string.ascii_letters[41:] + string.digits
    with_symbols = alphabet + punc
    limit_symbols = alphabet + limit_punc

    if not args.symbol and not args.limit:
        while True:
            password = ''.join(choice(alphabet) for i in range(length))
            nums = sum(c.isdigit() for c in password)
            if (any(c.islower() for c in password)
                    and any(c.isupper() for c in password)
                    and nums >= 3
                    and password[0].isalpha()):
                break
        print(password)
        exit()

    if args.symbol:
        while True:
            password = ''.join(choice(with_symbols) for i in range(length))
            nums = sum(c.isdigit() for c in password)
            if (any(c.islower() for c in password)
                    and any(c.isupper() for c in password)
                    and nums >= 3
                    and password[0].isalpha()):
                break
        print(password)
        exit()

    if args.limit:
        while True:
            password = ''.join(choice(limit_symbols) for i in range(length))
            nums = sum(c.isdigit() for c in password)
            if (any(c.islower() for c in password)
                    and any(c.isupper() for c in password)
                    and nums >= 3
                    and password[0].isalpha()):
                break
        print(password)
        exit()

main()
