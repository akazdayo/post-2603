#set page(
  paper: "a0",
  margin: (x: 8mm, y: 8mm),
)

#set text(
  font: "IPAGothic",
  size: 22pt,
  fill: rgb("#222222"),
)

#set par(justify: false, leading: 0.84em)
#set heading(numbering: none)

#let border = rgb("#444444")
#let light = rgb("#f7f7f7")

#let rule() = line(length: 100%, stroke: 0.8pt + border)

#let heading-prefix(level) = if level == 1 {
  [#sym.hash]
} else {
  [#sym.hash#sym.hash]
}

#let section(title, body, level: 1) = block(
  width: 100%,
  inset: (x: 4mm, y: 4mm),
)[
  #text(
    size: if level == 1 { 32pt } else { 26pt },
    weight: "bold",
  )[
    #heading-prefix(level) #h(1.2mm) #title
  ]
  #v(if level == 1 { 3mm } else { 2.2mm })
  #if level == 1 {
    rule()
  }
  #v(if level == 1 { 4.5mm } else { 3mm })
  #body
]

#let image-box(label, height: 42mm, fill: rgb("#f1f1f1")) = rect(
  width: 100%,
  height: height,
  radius: 1.5mm,
  stroke: 0.6pt + rgb("#cfcfcf"),
  fill: fill,
  inset: 0pt,
)[
  #align(center + horizon)[
    #text(size: 17pt, fill: rgb("#666666"))[#label]
  ]
]

#let mini-caption(text-body) = align(center)[
  #text(size: 16pt, fill: rgb("#444444"))[#text-body]
]

#let swatch(color, label) = [
  #align(center)[
    #circle(radius: 9mm, fill: color, stroke: none)
    #v(2.5mm)
    #text(size: 15pt)[#label]
  ]
]

#block(inset: 4mm)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 10mm,
    align: (left, top),
    [
      #text(size: 60pt, weight: "bold")[研究発表ポスターのタイトル]
      #v(4mm)
      #text(size: 28pt)[著者: 氏名1, 氏名2]
      #linebreak()
      #text(size: 22pt, fill: rgb("#555555"))[所属 / 研究室 / 学会名]
    ],
    [
      #rect(
        width: 46mm,
        height: 46mm,
        stroke: 0.8pt + border,
        fill: white,
      )
      #v(-40mm)
      #align(center + horizon)[#text(size: 17pt)[QR]]
      #v(35mm)
      #align(center)[#text(size: 14pt, fill: rgb("#555555"))[Web / GitHub]]
    ],
  )

  #v(8mm)
  #rule()
  #v(8mm)

  #grid(
    columns: (1.18fr, 0.82fr),
    column-gutter: 10mm,
    align: (left, top),
    [
      #section(
        [はじめに],
        [
          本研究では、アルゴリズム処理を組み合わせてドット絵風の画像を生成する流れを示す。
          先行手法では色数の制御、輪郭の残し方、描画の粗さの調整が個別に扱われることが多い。
          そこで本研究では、色空間変換・クラスタリング・輪郭抽出を組み合わせた処理系として整理する。
        ],
      )

      #v(7mm)

      #section(
        [研究の目的、難しいトット絵を描くには？],
        [
          研究目的は、写真やイラストから「ドット絵らしさ」を保ったまま簡潔な表現へ落とし込むことである。
          本ポスターでは、色のまとめ方と輪郭の残し方がどのように見た目へ影響するかを示す。
        ],
      )

      #v(7mm)

      #section(
        [比較してみる],
        [
          代表的な処理系列を左右に並べ、元画像からどのようにドット絵らしい表現へ変化するかを比較する。

          #v(7mm)

          #grid(
            columns: (1fr, 1fr),
            column-gutter: 8mm,
            [
              #text(size: 20pt, weight: "bold")[総合絵ドットイラスト変換]
              #v(4mm)
              #image-box([元画像], height: 72mm, fill: rgb("#f6e8d6"))
              #mini-caption([元画像(モザイク)])
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[1. K-Means and Apply]
              #image-box([中間画像], height: 72mm, fill: rgb("#ede4f5"))
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[2. DoG (+ Morphology)]
              #image-box([出力画像], height: 72mm, fill: rgb("#eadff0"))
            ],
            [
              #text(size: 20pt, weight: "bold")[絵の輪郭ドット大変換]
              #v(4mm)
              #image-box([元画像], height: 72mm, fill: rgb("#f2ead7"))
              #mini-caption([元画像])
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[1. 元画像(モザイク)]
              #image-box([中間画像], height: 72mm, fill: rgb("#ece6d5"))
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[2. K-Means and Apply]
              #image-box([出力画像], height: 72mm, fill: rgb("#efe5c8"))
            ],
          )
        ],
      )
    ],
    [
      #section(
        [技術説明],
        [
          本研究で採用するドット絵生成アルゴリズムは、主に3つの重要な技術要素から構成されている。
          色表現の整理、代表色への集約、輪郭情報の保持をそれぞれ独立に扱い、最後に組み合わせる。
        ],
      )

      #v(7mm)

      #section(
        [Lab色空間とは？],
        [
          Lab色空間は知覚的に均一な色差を扱いやすく、RGBよりも「似た色」をまとめやすい。
          そのため量子化前の前処理として相性がよい。

          #v(4mm)
          #grid(
            columns: (1fr, 1fr, 1fr),
            column-gutter: 5mm,
            [#swatch(rgb("#c32121"), [L 53.2])],
            [#swatch(rgb("#e75b5b"), [a 79.1])],
            [#swatch(rgb("#f5b3b3"), [b 18.4])],
          )
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [K-Meansとは？],
        [
          K-Means は画素群を代表色へ集約するクラスタリング手法である。
          色数を固定しやすく、ドット絵らしい簡潔な色面を作りやすい。

          #v(4mm)
          #grid(
            columns: (0.62fr, 0.38fr),
            column-gutter: 5mm,
            [
              処理前後で使用色数を管理しやすく、比較対象を揃えた実験にも向いている。
            ],
            [
              #image-box([クラスタ分布図], height: 64mm, fill: rgb("#f6f0f0"))
            ],
          )
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [エッジ検出について],
        [
          DoG や Sobel を用いて輪郭候補を抽出し、必要に応じてモルフォロジー処理で線を整える。
          色数削減だけでは失われる境界情報を補うことで、ドット絵らしい視認性を確保する。
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [結果],
        [
          画像の簡略化と輪郭保持のバランスを比較したところ、輪郭抽出を併用した条件で「読み取りやすさ」が向上した。
          一方で、細部の多い画像ではクラスタ数の設定により印象が大きく変化した。

          #v(5mm)
          #grid(
            columns: (1fr, 1fr, 1fr),
            column-gutter: 5mm,
            [
              #image-box([結果1], height: 58mm, fill: rgb("#d5edf4"))
            ],
            [
              #image-box([結果2], height: 58mm, fill: rgb("#e9ddb2"))
            ],
            [
              #image-box([結果3], height: 58mm, fill: rgb("#cde1f9"))
            ],
          )
        ],
      )

      #v(7mm)

      #section(
        [参考文献],
        [
          [1] 著者名, 論文タイトル, 学会名, 20XX.
          #linebreak()
          [2] 著者名, 書籍タイトル, 出版社, 20XX.
          #linebreak()
          [3] URL やデータセット情報をここに置く。
        ],
      )
    ],
  )
]
