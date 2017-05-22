#! /bin/sh

set -e

rm -i words*
for x in $(seq 1 1000); do
  cat /usr/share/dict/words >> words.txt
done

paste -d' ' - - < words.txt > words_by_2.txt
paste -d' ' - - - - < words.txt > words_by_4.txt
paste -d' ' - - - - - - - - < words.txt > words_by_8.txt
paste -d' ' - - - - - - - - - - - - - - - - < words.txt > words_by_16.txt
