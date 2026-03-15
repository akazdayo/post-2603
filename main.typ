#set page(
  paper: "a0",
  margin: (x: 20mm, y: 18mm),
)

#set text(
  font: "Noto Sans CJK JP",
  size: 18pt,
)

#set par(justify: false, leading: 0.75em)
#set heading(numbering: none)

#let poster-title = [
  #align(center)[
    #text(size: 34pt, weight: "bold")[研究発表ポスターのタイトル]
    #v(6mm)
    #text(size: 18pt)[氏名1, 氏名2, 氏名3]
    #linebreak()
    #text(size: 16pt, fill: rgb("#444444"))[所属 / 研究室 / 学会名]
  ]
]

#let section(title, body) = block(
  width: 100%,
  inset: 10mm,
  radius: 4mm,
  stroke: 0.8pt + rgb("#d9d9d9"),
  fill: rgb("#fbfbfb"),
)[
  #text(size: 22pt, weight: "bold", fill: rgb("#17324d"))[#title]
  #v(4mm)
  #body
]

#let bullet(items) = list(..items.map(item => [#item]))

#poster-title

#v(10mm)

#grid(
  columns: (1fr, 1fr),
  gutter: 10mm,
  [
    #section(
      [1. 背景・目的],
      [
        #bullet((
          [研究背景を2〜3文で簡潔に書く],
          [先行研究や実務上の課題を整理する],
          [この研究で明らかにしたい目的を1文で示す],
        ))

        #v(5mm)
        #text(weight: "bold")[主張]
        #par()[本研究は、〇〇という課題に対して△△の観点から検討する。]
      ],
    )

    #v(8mm)

    #section(
      [2. 研究課題 / 仮説],
      [
        #bullet((
          [RQ1: 何を比較・検証するのか],
          [RQ2: どの条件で差が出ると予想するのか],
          [必要なら仮説 H1, H2 を短く置く],
        ))
      ],
    )

    #v(8mm)

    #section(
      [3. 方法],
      [
        #bullet((
          [対象: 実験参加者、データセット、資料など],
          [手順: 実験・調査・解析の流れ],
          [条件: 比較群、評価指標、使用ツール],
        ))

        #v(4mm)
        #rect(
          width: 100%,
          height: 45mm,
          stroke: 1pt + rgb("#b8c4d0"),
          fill: rgb("#eef4f8"),
        )
        #align(center)[#text(size: 14pt, fill: rgb("#4f6478"))[ここに手法フロー図]]
      ],
    )

    #v(8mm)

    #section(
      [4. 結果],
      [
        #text(weight: "bold", fill: rgb("#8a1c1c"))[最重要結果を先に書く]
        #par()[提案手法はベースラインより〇〇%高い性能を示した、など結論が伝わる1文を置く。]

        #v(4mm)
        #rect(
          width: 100%,
          height: 54mm,
          stroke: 1pt + rgb("#d2b5b5"),
          fill: rgb("#fbefef"),
        )
        #align(center)[#text(size: 14pt, fill: rgb("#8a4a4a"))[ここに主要グラフ]]

        #v(4mm)
        #bullet((
          [結果1: 指標Aの変化],
          [結果2: 条件間比較],
          [結果3: 補足的な観察],
        ))
      ],
    )

    #v(8mm)

    #section(
      [5. 考察],
      [
        #bullet((
          [結果から何が言えるか],
          [なぜその傾向になったか],
          [先行研究との一致 / 相違],
        ))
      ],
    )
  ],
  [
    #section(
      [6. 結論],
      [
        #bullet((
          [結論1: 最も重要な知見],
          [結論2: 学術的 / 実用的な意義],
          [結論3: 読者に持ち帰ってほしい点],
        ))
      ],
    )

    #v(8mm)

    #section(
      [7. 今後の課題],
      [
        #bullet((
          [サンプル数や条件設定の限界],
          [別データ / 別条件での検証],
          [応用や発展可能性],
        ))
      ],
    )

    #v(8mm)

    #section(
      [8. 参考文献・謝辞・連絡先],
      [
        #bullet((
          [参考文献は3〜5件程度に絞る],
          [謝辞を書く],
          [メールアドレスやQRコードを置く],
        ))
      ],
    )
  ],
)
