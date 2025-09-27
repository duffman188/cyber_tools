#!/bin/bash

# Simple Base64 decoder
# Usage: run_base64_decode.sh <base64_string> OR pipe into it

if [[ -z "$1" && -t 0 ]]; then
    echo "Usage:"
    echo "  $0 <base64_string>"
    echo "  echo <string> | $0"
    exit 1
fi

if [[ -t 0 ]]; then
    # Input passed as argument
    echo "$1" | base64 --decode
else
    # Input piped via stdin
    base64 --decode
fi

