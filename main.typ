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
          現在の主要なVR向けFBT（Full Body Tracking, フルトラッキング）では、腰や足などに物理トラッカーを装着する必要がある。近年、Webカメラの性能は年々向上しており、安価でも高性能なカメラを入手しやすくなった。そのため、Webカメラを用いた姿勢推定自体は一般的になってきたが、個人向けVR分野では、物理トラッカーのように広く普及したFBT手法にはなっていない。そこで本研究では、一般的なWebカメラのみで同等に近い身体トラッキングが実現できるかを検証し、普及していない要因を明らかにすることを目指した。
        ],
      )

      #v(7mm)

      #section(
        [目的],
        [
          本研究の目的は、Webカメラを用いてVRChatでフルトラッキング相当の体験を実現することである。専用トラッカーが不足している環境でも、フルトラッキングとして利用可能な身体動作入力を実現することを目指した。
        ],
      )

      #v(7mm)

      #section(
        [比較],
        [
          既存の物理トラッカー方式は高い安定性と回転情報を得られる一方で、装着コストや導入負担が大きい。これに対して本手法は安価かつ手軽に導入できるが、遅延や回転情報の不足といった課題がある。
        ],
      )
    ],
    [
      #section(
        [主張],
        [
          一般的なWebカメラのみでVRChatにおけるフルトラッキング相当の体験を実現できるかを検証し、その課題と活用可能性を明らかにする。
        ],
      )

      #v(7mm)

      #section(
        [手法],
        [
          まず、#link("https://github.com/isarandi/metrabs")[MeTRAbs] を用いて単眼カメラ映像から人体姿勢を推定し、立体空間上の身体位置データへ変換した。次に、そのデータをGodotへ送信し、最終的にVRChat OSCを通してFBT用のトラッキングデータとして送信した。
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [結果],
        [
          推定された位置の精度そのものは比較的良好であり、身体の大まかな動きを反映することができた。一方で、関節の回転軸データを直接取得できないことや、タイムラグが大きいこと、さらにVR側の既存トラッキングデータとの統合が難しいことが確認された。
        ],
      )

      #v(7mm)

      #section(
        [考察],
        [
          本手法は単独で完全な代替となるにはまだ課題があるものの、IMU式トラッカーのドリフト補正などを補助する用途には有効である可能性がある。特に精度面には一定の見込みがあるため、今後は低遅延化と回転情報の補完が重要な改善点になる。
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
