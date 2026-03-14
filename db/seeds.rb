puts "Seeding Fermi Questions..."

questions = [
  # === Easy (10問) ===
  {
    title: "日本にあるコンビニの数",
    prompt_text: "日本国内に現在あるコンビニエンスストアの店舗数を推定してください。大手チェーン（セブン-イレブン、ファミリーマート、ローソンなど）を含む全店舗数を推定してください。",
    category: "Retail/StoreCount",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "一般的な推定では約5万〜6万店程度が妥当なレンジ。日本の人口約1.2億人に対し、1店舗あたりの商圏人口を2,000〜2,500人程度と置くと概ね合う。都市部は密度が高く、地方は低いが、全国平均として考える。",
    ideal_approach_text: "【分解例】日本の人口（約1.2億人）÷ 1店舗あたり商圏人口（約2,000〜2,500人）= 約48,000〜60,000店。別アプローチとして、大手3社の店舗数（各15,000〜21,000店）を合算し中小を加えても同様のレンジになる。",
    evaluation_rubric: "人口ベースの分解が自然。商圏人口の設定根拠が示されているか。都市と地方の差への言及があるとなお良い。"
  },
  {
    title: "日本で1年間に売れるペットボトル飲料の本数",
    prompt_text: "日本国内で1年間に販売されるペットボトル飲料の本数を推定してください。お茶、水、ジュース、コーヒーなどすべてのペットボトル飲料を含みます。",
    category: "Consumption",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "年間約200億〜250億本程度が妥当なレンジ。1人あたり週2〜3本程度の消費を仮定すると、1.2億人×年間100〜150本で概ね合う。",
    ideal_approach_text: "【分解例】日本の人口1.2億人 × 1人あたり年間消費本数（週2〜3本 × 52週 ≒ 100〜150本）= 約120億〜180億本。自販機・コンビニ・スーパーなど販路別に積み上げるアプローチも有効。",
    evaluation_rubric: "1人あたり消費量の前提が妥当か。季節変動への言及は加点。販路別の積み上げも良いアプローチ。"
  },
  {
    title: "東京23区内のスターバックスの店舗数",
    prompt_text: "東京23区内にあるスターバックスコーヒーの店舗数を推定してください。",
    category: "Retail/StoreCount",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "約300〜400店程度が妥当なレンジ。全国約1,900店のうち、東京23区には人口・商業集積度を考慮して15〜20%程度が集中していると推定。",
    ideal_approach_text: "【分解例】23区の昼間人口約1,200万人 ÷ 1店舗あたり商圏人口3〜4万人 = 約300〜400店。または全国店舗数約1,900店 × 東京23区の集中度（約20%）= 約380店。",
    evaluation_rubric: "全国からの割り戻しでも、エリア人口からの積み上げでも良い。商圏人口の設定に根拠があるか。"
  },
  {
    title: "日本の年間引越し件数",
    prompt_text: "日本国内で1年間に行われる引越しの件数を推定してください。個人・法人の転居すべてを含みます。",
    category: "Population",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "年間約500万〜700万件程度が妥当なレンジ。世帯数約5,500万世帯のうち、年間で引越しする割合を10%前後と置く。",
    ideal_approach_text: "【分解例】日本の世帯数約5,500万 × 年間引越し率（約10〜12%）= 約550万〜660万件。新社会人・転勤・進学などのライフイベント別に積み上げるアプローチも有効。",
    evaluation_rubric: "世帯ベースで考えているか。引越し率の前提に根拠があるか。3〜4月の繁忙期への言及は加点。"
  },
  {
    title: "日本の小学校の数",
    prompt_text: "日本国内にある小学校の数を推定してください。公立・私立すべてを含みます。",
    category: "Population",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "約18,000〜22,000校程度が妥当なレンジ。小学生人口約600万人÷1校あたり平均300人前後で推定可能。",
    ideal_approach_text: "【分解例】小学生の人口（6学年 × 各学年約100万人 = 約600万人）÷ 1校あたりの平均児童数（約300人）= 約20,000校。市区町村数（約1,700）から1自治体あたり平均10〜12校と推定するアプローチも可。",
    evaluation_rubric: "小学生人口の推定が妥当か。1校あたりの規模感が合っているか。都市と地方の差への言及があるとなお良い。"
  },
  {
    title: "日本で1年間に消費されるティッシュ箱数",
    prompt_text: "日本国内で1年間に消費されるボックスティッシュ（箱ティッシュ）の箱数を推定してください。",
    category: "Consumption",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "年間約30億〜50億箱程度が妥当なレンジ。世帯あたり月3〜5箱程度の消費を仮定し、オフィス等の業務用も加味する。",
    ideal_approach_text: "【分解例】家庭用: 5,500万世帯 × 月4箱 × 12ヶ月 = 約26億箱。業務用: オフィス・施設等で家庭用の30〜50%程度 = 約8〜13億箱。合計約34億〜39億箱。",
    evaluation_rubric: "家庭用と業務用を分けて考えられているか。世帯あたりの消費量の前提が妥当か。"
  },
  {
    title: "日本国内の映画館の年間来場者数",
    prompt_text: "日本国内の映画館の年間延べ来場者数を推定してください。",
    category: "Media/Internet",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "年間約1.5億〜2億人程度が妥当なレンジ。映画を見る人口の割合と年間鑑賞回数から推定。",
    ideal_approach_text: "【分解例】映画館に行く人口（1.2億人 × 40% = 約4,800万人）× 年間平均鑑賞回数（3〜4回）= 約1.4億〜1.9億人。スクリーン数×稼働率×座席数からの積み上げも有効。",
    evaluation_rubric: "映画鑑賞人口と頻度の分解が自然か。映画離れや配信の影響への言及は加点。"
  },
  {
    title: "日本で1日に送られるLINEメッセージ数",
    prompt_text: "日本国内で1日に送受信されるLINEメッセージの総数を推定してください。テキスト、スタンプ、画像などすべてを含みます。",
    category: "Media/Internet",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "1日あたり数十億〜100億件程度が妥当なレンジ。LINEのアクティブユーザー数と1人あたりのメッセージ数から推定。",
    ideal_approach_text: "【分解例】日本のLINEアクティブユーザー約9,000万人 × 1日あたり平均送信数（30〜50件）= 約27億〜45億件。ヘビーユーザーとライトユーザーを分けるとより精度が上がる。",
    evaluation_rubric: "アクティブユーザー数の推定が妥当か。利用頻度をセグメント別に分けているか。"
  },
  {
    title: "東京駅の1日の乗降客数",
    prompt_text: "JR東京駅の1日の乗降客数（在来線・新幹線を含む）を推定してください。",
    category: "Mobility/Transport",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "1日あたり約40万〜50万人程度が妥当なレンジ。通勤・通学客を主体に、ビジネス客・観光客も含む。",
    ideal_approach_text: "【分解例】在来線利用者: 通勤客（周辺のオフィスワーカー数から推定）約30万人。新幹線: 各路線の本数×平均乗車率×定員から約10万人。合計約40万人。",
    evaluation_rubric: "在来線と新幹線を分けているか。通勤時間帯とそれ以外を意識しているか。"
  },
  {
    title: "日本の年間ラーメン店来店回数",
    prompt_text: "日本国内のラーメン店における年間の延べ来店回数を推定してください。",
    category: "Consumption",
    difficulty: "Easy",
    estimated_minutes: 5,
    reference_estimate_text: "年間約15億〜25億回程度が妥当なレンジ。ラーメンを外食で食べる人口と頻度から推定。",
    ideal_approach_text: "【分解例】ラーメンを外食で食べる人口（1.2億人 × 60% = 約7,200万人）× 年間来店回数（月1〜2回 × 12 = 12〜24回）= 約8.6億〜17億回。店舗数×1日あたり客数からのアプローチも有効。",
    evaluation_rubric: "需要側・供給側どちらからのアプローチでも良い。頻度の前提に根拠があるか。"
  },

  # === Medium (12問) ===
  {
    title: "東京23区の1日のタクシー乗車回数",
    prompt_text: "東京23区内で1日に利用されるタクシーの乗車回数を推定してください。個人利用・法人利用の両方を含みます。",
    category: "Mobility/Transport",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "1日あたり約30万〜50万回程度が妥当なレンジ。タクシー台数と回転数から推定するのが自然。",
    ideal_approach_text: "【分解例】23区内のタクシー台数（約3万〜4万台）× 1台あたり1日の乗車回数（10〜15回）= 約30万〜60万回。需要側からは、ビジネス利用・夜間利用・高齢者利用などセグメント別に積み上げ。",
    evaluation_rubric: "供給側（台数×回転数）と需要側の両面から検討しているか。時間帯による変動を意識しているか。"
  },
  {
    title: "全国の美容院の年間来店回数",
    prompt_text: "日本全国の美容院（美容室・ヘアサロン）における年間の延べ来店回数を推定してください。",
    category: "Retail/StoreCount",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "年間約3億〜5億回程度が妥当なレンジ。美容院利用者人口と来店頻度から推定。",
    ideal_approach_text: "【分解例】美容院利用者（1.2億人 × 70% = 約8,400万人）。女性: 約4,200万人 × 年4〜6回。男性: 約4,200万人 × 年3〜4回。合計約3.4億〜4.6億回。",
    evaluation_rubric: "男女で来店頻度を分けているか。美容院と理容院の区別を意識しているか。カラー・パーマ等のメニュー別言及は加点。"
  },
  {
    title: "東京都内の月間Uber Eats注文数",
    prompt_text: "東京都内で1ヶ月間に行われるUber Eatsの注文数を推定してください。",
    category: "Consumption",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "月間約500万〜1,000万件程度が妥当なレンジ。アクティブユーザー数と注文頻度から推定。",
    ideal_approach_text: "【分解例】東京都のUber Eatsアクティブユーザー（東京都人口1,400万人 × アプリ利用率15〜20% = 約210万〜280万人）× 月間注文回数（2〜4回）= 約420万〜1,120万件。配達員数や加盟店数からの供給側アプローチも有効。",
    evaluation_rubric: "ユーザーセグメント（ヘビー/ライト）の分解があるか。競合（出前館等）との関係を意識しているか。"
  },
  {
    title: "日本の法人向け名刺管理SaaS市場規模",
    prompt_text: "日本国内の法人向け名刺管理SaaS（Sansan、Eight等）の年間市場規模（売上ベース）を推定してください。",
    category: "B2BMarketSizing",
    difficulty: "Medium",
    estimated_minutes: 10,
    reference_estimate_text: "年間約200億〜400億円程度が妥当なレンジ。対象企業数と導入率、ARPA（1社あたり年間売上）から推定。",
    ideal_approach_text: "【分解例】対象企業: 日本の法人数約400万社のうち従業員50人以上の企業約10万社。導入率約10〜20% = 1万〜2万社。ARPA: 従業員数に応じて月額5万〜50万円 × 12ヶ月。中小企業セグメントも含めて合算。",
    evaluation_rubric: "企業規模別のセグメンテーションがあるか。SaaSのARPA設定に根拠があるか。"
  },
  {
    title: "日本で1年間に売れる傘の本数",
    prompt_text: "日本国内で1年間に販売される傘（折りたたみ傘・長傘・ビニール傘すべて含む）の本数を推定してください。",
    category: "Consumption",
    difficulty: "Medium",
    estimated_minutes: 7,
    reference_estimate_text: "年間約1億〜1.5億本程度が妥当なレンジ。1人あたり年間1本弱を購入する計算。ビニール傘の衝動買いが大きな割合を占める。",
    ideal_approach_text: "【分解例】計画購入（折りたたみ・長傘）: 1.2億人 × 購入率30% × 平均1本 = 約3,600万本。衝動購入（主にビニール傘）: 1.2億人 × 年間購入率50% × 平均1.5本 = 約9,000万本。合計約1.3億本。",
    evaluation_rubric: "計画購入と衝動買いを分けているか。季節性（梅雨・台風）への言及は加点。"
  },
  {
    title: "日本国内の年間宅配便取扱個数",
    prompt_text: "日本国内で1年間に取り扱われる宅配便の個数を推定してください。",
    category: "Consumption",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "年間約45億〜55億個程度が妥当なレンジ。EC化率の上昇に伴い増加傾向。",
    ideal_approach_text: "【分解例】EC由来: EC市場規模約20兆円 ÷ 平均購入単価約5,000円 = 約40億件。うち物流を伴うもの約80% = 約32億個。個人間・法人間を含めて約45〜50億個。",
    evaluation_rubric: "EC由来とそれ以外（個人間・法人間）を分けているか。EC化率の影響を意識しているか。"
  },
  {
    title: "日本で1年間に行われる結婚式の件数",
    prompt_text: "日本国内で1年間に行われる結婚式（挙式・披露宴）の件数を推定してください。",
    category: "Population",
    difficulty: "Medium",
    estimated_minutes: 7,
    reference_estimate_text: "年間約20万〜30万件程度が妥当なレンジ。婚姻届件数と挙式率から推定。",
    ideal_approach_text: "【分解例】年間婚姻届数（約50万件）× 挙式実施率（約50〜60%）= 約25万〜30万件。ナシ婚の増加トレンドを考慮すると、やや低めの推定もありうる。",
    evaluation_rubric: "婚姻届件数をベースにしているか。挙式率の低下トレンドに言及しているか。"
  },
  {
    title: "東京都内のコインパーキングの駐車枠数",
    prompt_text: "東京都内にあるコインパーキング（時間貸し駐車場）の総駐車枠数を推定してください。",
    category: "Retail/StoreCount",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "約20万〜40万枠程度が妥当なレンジ。面積あたりの駐車場密度から推定。",
    ideal_approach_text: "【分解例】東京都の市街地面積（約800km²）÷ 1パーキングあたりの平均商圏面積（約0.01km²程度として8万箇所だが、実際はもっと少ない）。別アプローチ: 東京都の登録自動車数約300万台 × 外出時の時間貸し利用率を仮定。",
    evaluation_rubric: "エリア特性（都心部と郊外の違い）を意識しているか。複数アプローチからの検証があるか。"
  },
  {
    title: "日本国内のフィットネスジム会員数",
    prompt_text: "日本国内のフィットネスジム・スポーツクラブの会員数（延べではなく実人数）を推定してください。",
    category: "Population",
    difficulty: "Medium",
    estimated_minutes: 7,
    reference_estimate_text: "約500万〜800万人程度が妥当なレンジ。人口に対するフィットネス参加率から推定。",
    ideal_approach_text: "【分解例】日本の成人人口約1億人 × フィットネス参加率（約5〜8%）= 約500万〜800万人。施設数（約6,000〜8,000施設）× 1施設あたり平均会員数（約800〜1,000人）からも推定可能。",
    evaluation_rubric: "人口ベースと施設ベースの両方からアプローチしているか。近年の24時間ジム増加への言及は加点。"
  },
  {
    title: "日本のクラウド会計ソフト市場規模",
    prompt_text: "日本国内のクラウド会計ソフト（freee、マネーフォワード等）の年間市場規模（売上ベース）を推定してください。",
    category: "B2BMarketSizing",
    difficulty: "Medium",
    estimated_minutes: 10,
    reference_estimate_text: "年間約500億〜800億円程度が妥当なレンジ。個人事業主と法人で分けて推定するのが自然。",
    ideal_approach_text: "【分解例】法人: 対象企業約360万社 × クラウド利用率20% = 72万社。ARPA月額1万〜5万円で年間約870億〜4,300億円（ただし中小が多いので平均は低め）。個人事業主: 約200万人 × 利用率15% × 月額2,000円 = 年間約72億円。",
    evaluation_rubric: "法人と個人事業主を分けているか。企業規模別のセグメンテーションがあるか。"
  },
  {
    title: "日本で年間に消費されるコーヒー豆の量",
    prompt_text: "日本国内で1年間に消費されるコーヒー豆の総量（トン）を推定してください。家庭用・業務用すべてを含みます。",
    category: "Consumption",
    difficulty: "Medium",
    estimated_minutes: 8,
    reference_estimate_text: "年間約40万〜50万トン程度が妥当なレンジ。1人あたりの消費杯数から逆算。",
    ideal_approach_text: "【分解例】コーヒーを飲む人口（1.2億人 × 70% = 約8,400万人）× 年間消費杯数（1日1〜2杯 × 365日 = 300〜600杯）× 1杯あたり豆使用量（約10g）= 約25万〜50万トン。",
    evaluation_rubric: "飲用人口と頻度の設定が妥当か。家庭用と業務用（カフェ・缶コーヒー含む）を分けているか。"
  },
  {
    title: "日本の年間自動車販売台数",
    prompt_text: "日本国内で1年間に販売される新車の台数を推定してください。乗用車・軽自動車を含みます。",
    category: "Mobility/Transport",
    difficulty: "Medium",
    estimated_minutes: 7,
    reference_estimate_text: "年間約400万〜500万台程度が妥当なレンジ。保有台数と買い替えサイクルから推定。",
    ideal_approach_text: "【分解例】日本の自動車保有台数約8,000万台 ÷ 平均買い替えサイクル（約13〜15年）= 年間約530万〜615万台。ただし新車のみの場合はここから中古車への流出を考慮して約400万〜500万台。",
    evaluation_rubric: "保有台数からの推定が妥当か。新車と中古車を区別しているか。軽自動車の割合への言及は加点。"
  },

  # === Hard (8問) ===
  {
    title: "日本の年間B2B SaaS市場規模",
    prompt_text: "日本国内のB2B SaaS（企業向けクラウドソフトウェア）の年間市場規模（売上ベース）を推定してください。CRM、ERP、HR、会計、マーケティングなど全カテゴリを含みます。",
    category: "B2BMarketSizing",
    difficulty: "Hard",
    estimated_minutes: 12,
    reference_estimate_text: "年間約1兆〜2兆円程度が妥当なレンジ。日本の企業IT支出全体からSaaS化率を適用する方法と、カテゴリ別積み上げの両方が有効。",
    ideal_approach_text: "【分解例】日本の企業IT支出約15兆円 × SaaS化率（約10〜15%）= 約1.5兆〜2.25兆円。カテゴリ別: CRM約3,000億、ERP約3,000億、HRTech約2,000億、会計約800億、その他で合計約1〜1.5兆円。",
    evaluation_rubric: "トップダウンとボトムアップの両方からアプローチしているか。カテゴリ別の解像度が高いか。グローバルとの比較感があるとなお良い。"
  },
  {
    title: "東京23区内で1日に発生するゴミの総量",
    prompt_text: "東京23区内で1日に発生するゴミ（一般廃棄物）の総量（トン）を推定してください。家庭ごみ・事業系ごみの両方を含みます。",
    category: "Consumption",
    difficulty: "Hard",
    estimated_minutes: 10,
    reference_estimate_text: "1日あたり約1万〜1.5万トン程度が妥当なレンジ。23区の人口と事業所密度から推定。",
    ideal_approach_text: "【分解例】家庭ごみ: 23区人口約960万人 × 1人1日約0.8kg = 約7,700トン。事業系ごみ: 事業所数×1事業所あたり排出量で約3,000〜5,000トン。合計約1万〜1.3万トン。",
    evaluation_rubric: "家庭ごみと事業系ごみを分けているか。1人あたり排出量の前提に根拠があるか。リサイクル率への言及は加点。"
  },
  {
    title: "日本全体の年間キャッシュレス決済金額",
    prompt_text: "日本国内の年間キャッシュレス決済総額（クレジットカード、電子マネー、QRコード決済、デビットカードの合計）を推定してください。",
    category: "Consumption",
    difficulty: "Hard",
    estimated_minutes: 12,
    reference_estimate_text: "年間約100兆〜130兆円程度が妥当なレンジ。民間最終消費支出に対するキャッシュレス比率から推定。",
    ideal_approach_text: "【分解例】日本の民間最終消費支出約300兆円 × キャッシュレス比率（約35〜40%）= 約105兆〜120兆円。内訳: クレカ約80兆、電子マネー約6兆、QR決済約10兆、デビット約5兆程度。",
    evaluation_rubric: "消費支出全体からのトップダウンが妥当か。決済手段別の内訳が合理的か。キャッシュレス比率のトレンドへの言及は加点。"
  },
  {
    title: "日本の年間医療費に占めるオンライン診療の市場規模",
    prompt_text: "日本国内のオンライン診療（遠隔診療）の年間市場規模（診療報酬ベース）を推定してください。",
    category: "B2BMarketSizing",
    difficulty: "Hard",
    estimated_minutes: 12,
    reference_estimate_text: "年間約500億〜2,000億円程度が妥当なレンジ。全体の医療費に対するオンライン診療の割合は まだ1%未満。",
    ideal_approach_text: "【分解例】日本の国民医療費約45兆円。外来医療費約15兆円のうちオンライン診療対応可能な診療科（内科・皮膚科等）が約60%で9兆円。このうちオンライン実施率約1〜2% = 約900億〜1,800億円。",
    evaluation_rubric: "国民医療費からの分解が論理的か。外来/入院の区別ができているか。コロナ後の規制緩和への言及は加点。"
  },
  {
    title: "日本国内のデータセンターの年間電力消費量",
    prompt_text: "日本国内にあるデータセンターの年間総電力消費量（kWh）を推定してください。",
    category: "B2BMarketSizing",
    difficulty: "Hard",
    estimated_minutes: 12,
    reference_estimate_text: "年間約100億〜200億kWh程度が妥当なレンジ。日本の総電力消費量に対する割合から推定可能。",
    ideal_approach_text: "【分解例】日本の年間電力消費量約8,500億kWh × データセンターの占有率（約1.5〜2.5%）= 約128億〜213億kWh。別アプローチ: 国内DC数（約200施設）× 平均消費電力（5〜20MW）× 稼働時間（8,760h）= 約88億〜350億kWh。",
    evaluation_rubric: "トップダウンとボトムアップの両方から検証しているか。PUE（電力使用効率）への言及は加点。"
  },
  {
    title: "日本の年間プログラミングスクール市場規模",
    prompt_text: "日本国内のプログラミングスクール（オンライン・オフライン含む）の年間市場規模を推定してください。",
    category: "B2BMarketSizing",
    difficulty: "Hard",
    estimated_minutes: 10,
    reference_estimate_text: "年間約300億〜600億円程度が妥当なレンジ。受講者数と平均受講料から推定。",
    ideal_approach_text: "【分解例】年間新規受講者数: IT人材不足で転職希望者約50万人 × プログラミングスクール受講率10% = 約5万人。平均受講料: 約30万〜60万円。5万人 × 45万円 = 約225億円。法人研修需要を加えて約300〜500億円。",
    evaluation_rubric: "個人向けと法人向けを分けているか。受講者数の推定に根拠があるか。無料スクールの影響への言及は加点。"
  },
  {
    title: "日本国内の年間食品ロス量",
    prompt_text: "日本国内で1年間に発生する食品ロス（まだ食べられるのに廃棄される食品）の量（トン）を推定してください。",
    category: "Consumption",
    difficulty: "Hard",
    estimated_minutes: 10,
    reference_estimate_text: "年間約500万〜700万トン程度が妥当なレンジ。家庭由来と事業系由来をそれぞれ推定。",
    ideal_approach_text: "【分解例】家庭由来: 5,500万世帯 × 1世帯あたり年間食品購入量約500kg × ロス率約5% = 約138万トン。事業系: 食品産業の出荷量×各段階のロス率で約350万トン。合計約500万トン前後。",
    evaluation_rubric: "家庭系と事業系を分けているか。フードサプライチェーンの各段階でのロスを意識しているか。"
  },
  {
    title: "首都圏の通勤電車の年間延べ乗車人数",
    prompt_text: "首都圏（東京・神奈川・埼玉・千葉）の通勤電車における年間延べ乗車人数を推定してください。",
    category: "Mobility/Transport",
    difficulty: "Hard",
    estimated_minutes: 10,
    reference_estimate_text: "年間約100億〜130億人程度が妥当なレンジ。首都圏の鉄道利用者数と平均乗り換え回数から推定。",
    ideal_approach_text: "【分解例】首都圏の通勤・通学者数約1,500万人 × 往復で1日2回乗車 × 平均乗り換え1.5回 = 1日あたり約4,500万回。年間営業日250日 × 4,500万 = 約113億回。休日利用も加味して約120億回。",
    evaluation_rubric: "通勤者数の推定が妥当か。乗り換え回数の考慮があるか。平日と休日を分けているか。"
  }
]

questions.each_with_index do |q, i|
  slug = "q-#{i + 1}-#{Digest::MD5.hexdigest(q[:title])[0..7]}"
  existing = FermiQuestion.find_by(slug: slug)
  unless existing
    FermiQuestion.create!(q.merge(slug: slug))
  end
end

puts "Created #{FermiQuestion.count} Fermi Questions."
