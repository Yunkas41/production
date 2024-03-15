class Dictionary(object):
    """Dictionaryクラス
    
    辞書用の2ファイルを開き、応答データをリストと辞書オブジェクトにそれぞれ格納する。

    Attributes:
      random (list): ランダム辞書のフレーズを格納したリストを保持する。
      pattern (dic):  パターン辞書のパターンと応答フレーズを格納した辞書オブジェクト。
      
    """
    def __init__(self):
        """Dictionaryオブジェクトの初期化を行う。
        
        makeRandomList（）、makePatternDictionary()を実行して、
        ランダム応答用のリスト、パターン応答用の辞書オブジェクトを生成する。
        
        """        
        # ピティナのランダム辞書を作成。
        self.random =  self.makeRandomList() # -----------------------①        
        # ピティナのパターン辞書を作成。
        self.pattern = self.makePatternDictionary()  # ---------------②

    def makeRandomList(self):
        """ランダム辞書ファイルのデータを読み込んでリストrandomに格納する。
        
            Returns:
                list: ランダム辞書のフレーズを格納したリスト。
                
        """
        # ランダム辞書ファイルオープン
        rfile = open('dics/random.txt', 'r', encoding = 'utf_8') # ---③
        # 各行を要素としてリストに格納
        r_lines = rfile.readlines()
        rfile.close()
        
        randomList = []
        # 末尾の改行と空白文字を取り除いて
        # インスタンス変数（リスト）に格納
        for line in r_lines:
            str = line.rstrip('\n')
            if (str!=''):
                randomList.append(str)
        return randomList

    def makePatternDictionary(self):
        """パターン辞書ファイルのデータを読み込んで辞書オブジェクトpatternに格納する。
        
        Returns:
            dict: パターン辞書のパターンと応答フレーズを格納したdicオブジェクト。                

        ・辞書オブジェクトpatternの構造
          {
            'pattern' : [パターンのリスト]
            'phrases' : [パターンに対応する応答フレーズのリスト]
          }
        """        
        # パターン辞書オープン
        pfile = open('dics/pattern.txt', 'r', encoding = 'utf_8') # ---④
        # 各行を要素としてリストに格納
        p_lines = pfile.readlines() # ---------------------------------⑤
        pfile.close()
        # 末尾の改行と空白文字を取り除いて
        # インスタンス変数（リスト）に格納
        new_lines = []
        for line in p_lines:
            str = line.rstrip('\n') # ---------------------------------⑥
            if (str!=''):
                new_lines.append(str) # -------------------------------⑦

        patternDictionary = {}
        # 1行をタブで切り分けて辞書オブジェクトに格納
        # 'pattern'キー：正規表現のパターン
        # 'phrases'キー：応答例
        for line in new_lines:
            ptn, prs = line.split('\t') # -----------------------------⑧
            patternDictionary.setdefault('pattern', []).append(ptn)
            patternDictionary.setdefault('phrases', []).append(prs)
        return patternDictionary
            
