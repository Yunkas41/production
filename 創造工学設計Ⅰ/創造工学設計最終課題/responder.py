import random
import re

class Responder(object):
    """ 応答クラスのスーパークラス
    """
    def __init__(self, name): # --------------------------①
        """ 応答クラスの名前をself.nameに格納する処理のみを行う。
        
        Parameters:
            name(str)       : 応答クラスの名前。
        """
        self.name = name

    def response(self, input): # -------------------------②
        """ オーバーライドを前提としたresponse()メソッド。
        
        Parameters:
            input(str)  : ユーザーが入力した文字列。
            
        Returns:
            str: 応答メッセージ（ただし空の文字列)。     
        """
        return ''

class RepeatResponder(Responder):
    """ オウム返しのためのサブクラス
    """
    
    def __init__(self, name): # --------------------------③
        """ スーパークラスの__init()__の呼び出しのみを行う。
        
        Parameters:
            name(str)       : 応答クラスの名前。
        """        
        super().__init__(name)
   
    def response(self, input): # -------------------------④
        """ response()をオーバーライド、オウム返しの返答をする。

        Parameters:
            input(str): ユーザーが入力した文字列。
            
        Returns:
            str: 応答メッセージ。    
        """
        # オウム返しの返答をする。
        return '{}ってなに？'.format(input)

class RandomResponder(Responder):
    """ ランダムな応答のためのサブクラス
    
    """
    def __init__(self, name, dic_random): # --------------⑤
        """ スーパークラスの__init__()にnameを渡し、
            ランダム応答用のリストをインスタンス変数に格納する。
        
        Parameters:
            name(str)       : 応答クラスの名前。
            dic_random(list): Dictionaryオブジェクトが保持するランダム応答用のリスト。
                                
        """
        super().__init__(name)
        self.random = dic_random

    def response(self, input): # --------------------------⑥
        """ response()をオーバーライド、ランダムな応答を返す。

        Parameters:
            input(str)  : ユーザーが入力した文字列。
            
        Returns:
            str: リストからランダムに抽出した応答メッセージ。
        """
        return random.choice(self.random)

class PatternResponder(Responder):
    """ パターンに反応するためのサブクラス
    """
    def __init__(self, name, dictionary): # ---------------⑦
        """ スーパークラスの__init__()にnameを渡し、
            Dictionaryオブジェクトをインスタンス変数に格納する。
        
        Parameters:
            name(str)   : Responderオブジェクトの名前。
            dictionary(dic): Dictionaryオブジェクト。
            
        """
        super().__init__(name)
        self.dictionary = dictionary

    def response(self, input):
        """ パターンにマッチした場合に応答文字列を作って返す。

        Parameters:
            input(str)   : ユーザーが入力した文字列。

        Returns:
            str: パターンにマッチした場合はパターンと対になっている応答メッセージを返す。
                 パターンマッチしない場合はランダム辞書の応答メッセージを返す。
            
        """
        # pattern['pattern']と['phrases']に対して反復処理。
        for ptn, prs in zip( # ---------------------------------------⑧
                # ptnに正規表現のパターンを代入する。
                self.dictionary.pattern['pattern'],
                # prsにパターンに対応する応答メッセージを代入する。
                self.dictionary.pattern['phrases']
            ):
            # インプットされた文字列に対してパターンマッチを行う。
            m = re.search(ptn, input) # ------------------------------⑨
            if m: # --------------------------------------------------⑩
                # インプットされた文字列がパターンにマッチしている場合は、
                # pｒｓの応答フレーズを'|'で切り分けてランダムに1文を取り出す。
                resp = random.choice(prs.split('|')) # ---------------⑪
                # 抽出した応答フレーズを返す。
                # 応答フレーズの中に%match%が埋め込まれている場合は
                # インプットされた文字列内のパターンマッチした文字列に置き換える。
                return re.sub('%match%', m.group(), resp) # ----------⑫
        # パターンマッチしない場合はランダム辞書から返す。
        return random.choice(self.dictionary.random) # ---------------⑬
