#!/bin/bash -xv
exec 2> /tmp/log

PATH=/usr/local/bin:$PATH
htmlfile=/Users/ueda/cgi-bin/com.html
tmp=/tmp/$$

######実行可能コマンドリスト######
cat << FIN > $tmp-list
cat /etc/hosts
top -l 1
echo test_test _
FIN

######コマンドの実行######
#番号受け取り
NUM=$(echo "$QUERY_STRING" | tr -dc '0-9')
#指定された行を取得
COM=$(awk -v n="$NUM" 'NR==n' $tmp-list)
#COMが空なら : を入れておく
[ -z "$COM" ] && COM=":"
#実行
$COM > $tmp-result

######HTML出力######
echo "Content-type: text/html"
echo 
#エスケープ処理
sed 's/_/\\_/g' $tmp-list	|
tr ' ' '_'			|
#行番号をつける
awk '{print NR,$1}'		|
#出力 >>> 1:行番号 2:コマンド
mojihame -lCOMLIST $htmlfile -	|
#コマンド実行結果をはめ込み
filehame -lRESULT - $tmp-result

rm -f $tmp-*
exit 0
