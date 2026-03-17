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
      #text(size: 60pt, weight: "bold")[単眼カメラを用いたVR向け仮想トラッカーの制作]
      #v(4mm)
      #text(size: 28pt)[著者: 野田蒼馬]
      #linebreak()
      #text(size: 22pt, fill: rgb("#555555"))[N高等学校]
    ],
    [
      #image("qr.png", width: 46mm)
      #v(2mm)
      #align(center)[#text(size: 14pt, fill: rgb("#555555"))[GitHub]]
      #align(center)[#text(size: 14pt, fill: rgb("#555555"))[github.com/akazdayo]]
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
        [背景],
        [
          現状の主要VR向けトラッカーは物理装置を装着する必要があるが、Webカメラでも同レベルのことができるのではないかと気になった。
          そこで、単眼カメラだけでどこまでVR向けの仮想トラッカーとして使えるかを確かめた。
        ],
      )

      #v(7mm)

      #section(
        [目的],
        [
          VRChatでフルトラッキング相当のことができればオッケー、という実用上の目標を置いて検証した。
        ],
      )

      #v(7mm)

      #section(
        [比較],
        [
          実装時点では、以下の観点を中心に挙動を比較した。

          #v(7mm)

          #grid(
            columns: (1fr, 1fr),
            column-gutter: 8mm,
            [
              #text(size: 20pt, weight: "bold")[観察したポイント]
              #v(4mm)
              #image-box([姿勢推定の安定性], height: 72mm, fill: rgb("#f6e8d6"))
              #mini-caption([カメラ入力に対して姿勢がどれだけ安定するか])
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[タイムラグの体感]
              #image-box([レイテンシ], height: 72mm, fill: rgb("#ede4f5"))
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[VR側との合わせやすさ]
              #image-box([トラッキング統合], height: 72mm, fill: rgb("#eadff0"))
            ],
            [
              #text(size: 20pt, weight: "bold")[現状]
              #v(4mm)
              #image-box([比較用の図・表は今後追加], height: 72mm, fill: rgb("#f2ead7"))
              #mini-caption([今回は文章ベースで評価])
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[回転軸の不足]
              #image-box([追加工夫が必要], height: 72mm, fill: rgb("#ece6d5"))
              #v(3mm)
              #align(center)[#text(size: 30pt, fill: border)[↓]]
              #text(size: 17pt)[精度とラグの両立]
              #image-box([今後の改善対象], height: 72mm, fill: rgb("#efe5c8"))
            ],
          )
        ],
      )
    ],
    [
      #section(
        [主張],
        [
          現状の主要VR向けトラッカーは物理装置を装着する必要があるが、Webカメラでも同レベルのことができるのではないかと思ったので実験をしてみる。
        ],
      )

      #v(7mm)

      #section(
        [手法],
        [
          #grid(
            columns: (0.62fr, 0.38fr),
            column-gutter: 5mm,
            [
              ・#link("https://github.com/isarandi/metrabs")[metrabs] を使って立体空間上にカメラからの姿勢データをマッピング
              #parbreak()
              ・マッピングされたデータを Godot に送る
              #parbreak()
              ・Godot から VRChat OSC で FBT データを送信
            ],
            [
              #image-box([処理フロー], height: 64mm, fill: rgb("#f6f0f0"))
            ],
          )
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [結果],
        [
          回転軸データが取れないので、多少工夫が必要だった。
          #parbreak()
          タイムラグが大きめで、実運用では気になる場面があった。
          #parbreak()
          ただし精度自体は悪くなく、姿勢推定そのものには可能性があった。
          #parbreak()
          VR自体のトラッキングデータと合わせるのが結構難しかった。
        ],
      )

      #v(7mm)

      #section(
        [考察],
        [
          IMU式トラッカーのドリフト対策とかには使える気がする。
          #parbreak()
          現状のラグだと微妙だが、精度は悪くないため改良の余地はある。
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [参考文献],
        [
          [1] isarandi, metrabs, GitHub Repository.
          #linebreak()
          [2] https://github.com/isarandi/metrabs
          #linebreak()
          [3] https://github.com/akazdayo
        ],
      )
    ],
  )
]
