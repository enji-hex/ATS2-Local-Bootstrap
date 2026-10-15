# ATS2 Local Bootstrap

Builds ATS2 Postiats 0.4.2 in a local directory and runs a C interoperability
smoke test.

## Tested environment

- OS: Arch Linux
- Architecture: x86_64
- GCC: 16.2.1
- ATS2: Postiats 0.4.2

## Usage

./bootstrap.sh        # build and run smoke test
./bootstrap.sh --test # run smoke test using the local build

## Compatibility workaround

Removes the `bsearch` declaration from `prelude/CATS/array.cats`
before building ATS2.

## Test

Compiles an ATS array-summation function to C, links it with a C caller,
and checks the result via the process exit status.
