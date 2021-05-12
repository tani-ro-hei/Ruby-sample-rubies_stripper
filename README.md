# Ruby-sample-rubies_stripper

## Name

rubies_stripper - Sample code to explain text processing

## Description

スクリプト言語によるテキスト処理を解説するために書いたサンプルコードです。

`stripper.rb` を実行すると、`Luke_orig.txt` (青空文庫形式でルビが振られた大正改譯聖書『ルカ傳福音書』) を読込み、数値文字参照を置換した上でルビを除きます。裸のテキストは `Luke_strip.txt` に、除いたルビの情報は `saving.dat` に、それぞれ出力されます。

次に `Luke_strip.txt` に対して何らかの変換を施しますが、この変換は文字数を変えないと仮定されています (例えば新仮名遣いにする<sup>1</sup>、などを想定)。変換済みテキストを `processed.txt` という名前で同じ場所に置きます。

最後に `unstripper.rb` を実行すると、`processed.txt` 及び `saving.dat` から青空文庫形式のルビが復元され、`Luke_unstrip.txt` に出力されます。

<sup>1</sup> 実際には けふ→きょう などの文字数を変える変換があるので、この試みは成功しませんが……。

## License

Choose [NYSL-0.9982](http://www.kmonos.net/nysl) or [WTFPL-2](http://www.wtfpl.net/txt/copying), as you wish.
