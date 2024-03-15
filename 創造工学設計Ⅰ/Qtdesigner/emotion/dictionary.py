import patternItem # ----------------------------------------新規追加

class Dictionary(object):
    """Dictionaryクラス
    
    ランダム辞書とパターン辞書を開き、データをインスタンス変数に格納する。

    Attributes:
      random (strのlist):
        ランダム辞書のすべてのフレーズを要素として格納。
        [フレーズ1, フレーズ2, フレーズ3, ...]
                     
      pattern (PatternItemのlist):
        [PatternItem1, PatternItem2, PatternItem3, ...]
                   
        PatternItem:
          "パターン辞書1行"の情報を持つ
          PatternItem.modify(int): 機嫌変動値。
          PatternItem.pattern(str): 正規表現パターン・
          PatternItem.phrases(dicのlist):
               リスト要素の辞書は"応答フレーズ1個"の情報を持つ。
               {'need': 必要機嫌値, 'phrase': '応答フレーズ1個'}
               これを1行の応答フレーズグループの数だけ持つ。
      
    """
    def __init__(self):
        """Dictionaryオブジェクトの初期化を行う。
        
        makeRandomList（）、makePatternDictionary()を実行して、
        ランダム応答用のリスト、パターン応答用の辞書オブジェクトを生成する。
        
        """
        # ピティナのランダム辞書を作成。
        self.random = self.makeRandomList()
        # ピティナのパターン辞書を作成。
        self.pattern = self.makePatternDictionary()
        
    def makeRandomList(self):
        """ランダム辞書ファイルのデータを読み込んでリストrandomに格納する。
        
        Returns:
            strのlist: 要素はランダム辞書1行あたりの応答フレーズ。
        """
        # ランダム辞書ファイルオープン
        rfile = open('dics/random.txt', 'r', encoding = 'utf_8')
        # 各行を要素としてリストに格納
        r_lines = rfile.readlines()
        rfile.close()
        # 末尾の改行と空白文字を取り除いてリストに格納
        randamList = []
        for line in r_lines:
            str = line.rstrip('\n')
            if (str!=''):
                randamList.append(str)
        return randamList

    def makePatternDictionary(self):
        """パターン辞書ファイルのデータを読み込んでリストpatternに格納する。
        
        Returns:
            PatternItemのlist: PatternItemはパターン辞書1行の応答フレーズ1個の情報を持つ。
          
        """        
        # パターン辞書オープン
        pfile = open('dics/pattern.txt', 'r', encoding = 'utf_8')
        # 各行を要素としてリストに格納
        p_lines = pfile.readlines()
        pfile.close()
        # 末尾の改行と空白文字を取り除いてリストに格納
        new_lines = []
        for line in p_lines:
            str = line.rstrip('\n')
            if (str!=''):
                new_lines.append(str)
             
        # パターン辞書の各行をタブで切り分けて以下の変数に格納。
        #
        # ptn パターン辞書1行の正規表現パターン。
        # prs パターン辞書1行の応答フレーズグループ。
        #
        # 引数をptn、prsにしてPatternItemオブジェクトを1個生成し、
        # patternItemList（リスト）に追加。パターン辞書の行の数だけ繰り返す。
        patternItemList = []
        for line in new_lines:
            ptn, prs = line.split('\t')
            patternItemList.append(
                patternItem.PatternItem(ptn, prs)) # ---patternItemを指定

        return patternItemList

    def study(self, input): # --------------------------------------------①
        """ ユーザーの発言を学習する。

        Parameters:
            input(str): ユーザーからのメッセージ。
            
        """
        # インプット文字列末尾の改行を取り除く。
        input = input.rstrip('\n') # -------------------------------------②
        # 発言がランダム辞書に存在しなければself.randomの末尾に追加
        if not input in self.random: # -----------------------------------③
            self.random.append(input)

    def save(self): # ----------------------------------------------------④
        """ self.randomの内容をまるごと辞書に書き込む。
        
        """
        # 各フレーズの末尾に改行を追加する。
        for index, element in enumerate(self.random):
            self.random[index] = element +'\n' # -------------------------⑤
        # ランダム辞書に書き込む。
        with open('dics/random.txt', 'w', encoding = 'utf_8') as f:
            f.writelines(self.random) # ----------------------------------⑥
