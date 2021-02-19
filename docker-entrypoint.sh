#!/bin/bash

set -euo pipefail

suffix=""
case "$1" in
    "janome" | "janome-lr" | "janome_lr")
        suffix="janome"
        ;;
    "janome-pp" | "janome_pp" | "pp")
        suffix="janome_pp"
        ;;
    "jpn" | "jpn-plain" | "jpn_plain" | "plain")
        suffix="jpn_plain"
        ;;
    "mecab")
        suffix="mecab"
        ;;
    "eng")
        suffix="mecab"
        ;;
    "eng-plain" | "eng_plain")
        suffix="eng_plain"
        ;;
    "nlpir")
        suffix="nlpir"
        ;;
    "tfidf")
        suffix="store:tfidf"
        ;;
    "lr")
        suffix="store:lr"
        ;;
    *)
        suffix="janome"
        ;;
esac
shift

workdir="$(mktemp -d -p "${PWD}")"
in_files=()
if [[ "$#" -gt 0 ]]; then
    for f in "$@"; do
        in_files+=("${f}")
    done
else
    in="/dev/stdin"
    in_file="${workdir}/in"

    dd if="${in}" of="${in_file}" >/dev/null 2>&1
    in_files+=("${in_file}")
fi

cd "${workdir}" && /usr/local/bin/termextract "${suffix}" "${in_files[@]}"
