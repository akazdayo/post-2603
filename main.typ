#import "@preview/zebra:0.1.0": qrcode
#import "@preview/mmdr:0.2.1": mermaid

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

#let flow-arrow() = align(center + horizon)[
  #text(size: 28pt, weight: "bold", fill: border)[#sym.arrow.r]
]

#let demo-flow() = align(center)[
  #grid(
    columns: (1fr, auto, 1fr, auto, 1fr),
    column-gutter: 2.5mm,
    align: (center, center),
    [
      #image("assets/real-tracking-demo.png", width: 100%)
      #v(1.2mm)
      #mini-caption[実カメラ映像]
    ],
    [#flow-arrow()],
    [
      #image("assets/poses.png", width: 100%)
      #v(1.2mm)
      #mini-caption[姿勢推定結果]
    ],
    [#flow-arrow()],
    [
      #image("assets/vrchat-tracking-demo.png", width: 100%)
      #v(1.2mm)
      #mini-caption[VRChat 反映結果]
    ],
  )
]

#let qr-panel(url, label: "GitHub") = align(center + top)[
  #block(width: 64mm)[
    #align(center)[
      #qrcode(
        url,
        quiet-zone: true,
        background-fill: white,
        width: 46mm,
      )
    ]
    #v(2.5mm)
    #align(center)[
      #text(size: 14pt, fill: rgb("#555555"), font: "Noto Sans")[#label]
    ]
    #v(0.8mm)
    #align(center)[
      #text(
        size: 11.5pt,
        fill: rgb("#555555"),
        font: "Noto Sans",
      )[#url]
    ]
  ]
]

#let swatch(color, label) = [
  #align(center)[
    #circle(radius: 9mm, fill: color, stroke: none)
    #v(2.5mm)
    #text(size: 15pt)[#label]
  ]
]

#let main_py_flow = (
  "flowchart LR\n" +
  "  subgraph input[入力]\n" +
  "    cam[Webカメラ映像]\n" +
  "  end\n" +
  "  subgraph estimate[姿勢推定]\n" +
  "    metrabs[MeTRAbsで姿勢推定]\n" +
  "    pose3d[3次元の関節座標]\n" +
  "    select[腰と両足の座標を抽出]\n" +
  "  end\n" +
  "  subgraph output[VR送信]\n" +
  "    convert[VRChat用の座標系に変換]\n" +
  "    osc[OSCでトラッカー位置を送信]\n" +
  "    avatar[アバター動作に反映]\n" +
  "  end\n" +
  "  cam --> metrabs\n" +
  "  metrabs --> pose3d\n" +
  "  pose3d --> select\n" +
  "  select --> convert\n" +
  "  convert --> osc\n" +
  "  osc --> avatar\n" +
  "  avatar -. リアルタイムに繰り返し .-> cam\n"
)

#block(inset: 4mm)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 10mm,
    align: (left, top),
    [
      #text(
        size: 60pt,
        weight: "bold",
      )[単眼カメラを用いたVR向け仮想トラッカーの制作]
      #v(4mm)
      #text(size: 28pt)[著者: 野田蒼馬]
      #linebreak()
      #text(size: 22pt, fill: rgb("#555555"))[N高等学校]
    ],
    [
      #qr-panel("github.com/akazdayo/post-2603")
    ],
  )

  #v(8mm)
  #rule()
  #v(8mm)

  #grid(
    columns: (1fr, 1fr),
    column-gutter: 10mm,
    align: (left, top),
    [
      #section(
        [主張],
        [
          一般的なWebカメラのみでVRChatにおけるフルトラッキング相当の体験を実現できるかを検証し、その課題と活用可能性を明らかにする。
        ],
      )

      #v(7mm)

      #section(
        [背景],
        [
          現在、VR向けのFBT（Full Body Tracking, フルトラッキング）は、腰や足などに物理トラッカーを装着する方式が主流である。この方式は高い安定性と実用性を持つ一方で、機器の購入費用、装着の手間、センサの管理といった導入負担が大きく、誰でも気軽に利用できるとは言い難い。
          #parbreak()
          一方で、近年はWebカメラの性能向上と低価格化が進み、一般家庭でも高解像度かつ高フレームレートの映像を容易に取得できるようになった。これに伴い、単眼カメラを用いた人体姿勢推定技術も発展し、映像から身体の位置を推定すること自体は身近なものになりつつある。
          #parbreak()
          しかし、個人向けVR分野においては、Webカメラのみを用いた手法は物理トラッカーと同等の普及には至っていない。そこで本研究では、一般的なWebカメラだけでVRChatにおけるフルトラッキング相当の体験が実現可能かを検証し、その実用性と課題を明らかにすることを目的とした。
        ],
      )

      #v(7mm)

      #section(
        [目的],
        [
          本研究の目的は、一般的なWebカメラを用いて、VRChat上でフルトラッキング相当の身体表現を実現することである。特に、専用の物理トラッカーを十分に用意できない環境においても、実用的な身体トラッキング情報を生成し、アバター操作に利用できる仕組みの構築を目指した。
          #parbreak()
          単に姿勢を推定するだけでなく、推定結果をVR空間で扱えるトラッキング信号として整形し、実際のアプリケーションで利用可能な形で出力することを重視した。これにより、低コストかつ導入しやすい新たなFBT手法の可能性を検討した。
        ],
      )

      #v(7mm)

      #section(
        [手法],
        [
          本手法では、まず単眼Webカメラから取得した映像に対して、3次元人体姿勢推定モデルである #link("https://github.com/isarandi/metrabs")[MeTRAbs] を適用し、人物の関節位置を三次元座標として推定した。得られた推定結果は、そのままではVR用途に適した形式ではないため、VR空間で利用しやすい身体位置データへ変換・整形した。
          #parbreak()
          次に、整形後のデータをGodotへ送信し、アプリケーション側でトラッカー相当の位置情報として扱えるようにした。最終的には、VRChat OSCを通じて各部位のトラッキングデータを送信し、アバターの身体動作に反映させた。
          #parbreak()
          このように、本研究では「単眼映像の取得」「3D姿勢推定」「座標系の補正」「VR向け信号としての送信」を一連のリアルタイム処理パイプラインとして構成した。
          #v(3mm)
          #align(center)[
            #mermaid(main_py_flow)
          ]
          #v(1.5mm)
          #mini-caption[
            動作フロー図
          ]
          #v(3mm)
          #demo-flow()
          #v(1.5mm)
          #mini-caption[
            カメラ映像からVRまでの大まかな概要
          ]
        ],
        level: 2,
      )

      #v(7mm)

      #section(
        [比較],
        [
          既存の物理トラッカー方式は、各部位に専用センサを装着することで、安定した位置情報に加えて回転情報も高精度に取得できる。そのため、現在のVR環境では高い完成度を持つ実用的な方式として広く利用されている。一方で、機器の価格、装着の煩雑さ、台数の確保といった面で利用者の負担が大きい。
          #parbreak()
          これに対して本手法は、一般的なWebカメラのみで動作するため、導入コストを大きく抑えられ、設置や使用の手軽さに優れるという利点がある。しかしその反面、映像ベースの推定であるため遮蔽や処理遅延の影響を受けやすく、さらに関節の回転情報を直接得られないという構造的な課題を持つ。
          #parbreak()
          したがって、本手法は低コスト性と導入容易性に優れる一方で、安定性や情報量の面では既存方式に及ばない部分がある。
        ],
      )
    ],
    [
      #section(
        [結果],
        [
          実験の結果、推定された関節位置の精度そのものは比較的良好であり、身体の大まかな動きや重心移動をVR上のアバターに反映できることが確認された。特に、腰や脚の位置変化といった基本的な運動については、フルトラッキングらしい挙動を一定程度再現することができた。
          #parbreak()
          一方で、MeTRAbsからは関節の回転軸情報を直接取得できないため、VR側で求められるトラッカー情報としては不足が生じた。また、推定処理から送信までの過程で無視できないタイムラグが発生し、素早い動作では追従性の低下が見られた。推論時間を比較したところ、アイドル時の平均は 51.17 ms、ゲーム実行時の平均は 85.18 ms となり、実行負荷の増加に伴って遅延が拡大する傾向が確認された。
          #parbreak()
          さらに、既存のVR機器が出力するトラッキングデータとの整合を取ることが難しく、他方式との併用や統合には追加の工夫が必要であることが明らかになった。
          #v(3mm)
          #image(
            "assets/inference_center_n500_overlay_elapsed_avg.png",
            width: 100%,
          )
          #v(1.5mm)
          #mini-caption[
            推論時間の比較。アイドル時に対してゲーム実行時は平均遅延が増加し、追従性の低下が見られた。
          ]
        ],
      )

      #v(7mm)

      #section(
        [考察],
        [
          以上より、本手法は現時点で物理トラッカーを完全に代替する段階には至っていないものの、低コストに身体位置を推定し、VR向けの入力として利用できる可能性を示したといえる。特に、位置推定の精度には一定の見込みがあり、用途を限定すれば十分に有用であると考えられる。
          #parbreak()
          また、単独のトラッキング手法としてだけでなく、IMU式トラッカーのドリフト補正や位置補助など、他方式を支援する補助的手法として活用できる可能性も高い。今後は、処理の低遅延化、回転情報の補完、既存トラッキングシステムとの統合手法の検討が重要な課題となる。
          #parbreak()
          これらを改善することで、単眼カメラベースの仮想トラッカーは、VR向け身体トラッキングの選択肢の一つとして実用性を高められると考えられる。
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
