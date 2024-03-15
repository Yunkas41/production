import random
import re

class Responder(object):
    """ 応答クラスのスーパークラス
    
    Attributes:
      name (str): 応答クラスの名前を保持する。     

    """
    def __init__(self, name):
        """ 応答クラスの名前をself.nameに格納する処理のみを行う。
        
        Parameters:
            name(str)       : 応答クラスの名前。
            
        """
        self.name = name

    def response(self, input, mood):
        """ オーバーライドを前提としたresponse()メソッド。
        
        Parameters:
            input(str): ユーザーが入力したメッセージ。
            mood(int): ピティナの機嫌値
        Returns:
            str: 応答メッセージ（ただし空の文字列)。    
    
        """
        return ''

class RepeatResponder(Responder):
    """ オウム返しのためのサブクラス

    """   
    def __init__(self, name):
        """ スーパークラスの__init()__の呼び出しのみを行う。
        
        Parameters:
            name(str)       : 応答クラスの名前。
        """        
        super().__init__(name)
   
    def response(self, input, mood):
        """ response()をオーバーライド、オウム返しの返答をする。

        Parameters:
            input(str): ユーザーが入力したメッセージ。
            mood(int): ピティナの機嫌値
            
        Returns:
            str: 応答メッセージ。    
        """
        # オウム返しの返答をする。
        return '{}ってなに？'.format(input)

class RandomResponder(Responder):
    """ ランダムな応答のためのサブクラス

     Attributes:
       random (strのlist): ランダム辞書の応答フレーズのリスト。      
   
    """
    def __init__(self, name, dic_random):
        """ スーパークラスの__init()__にnameを渡し、
            ランダム応答用のリストをインスタンス変数に格納する。
        
        Parameters:
            name(str)       : 応答クラスの名前。
            dic_random(list): Dictionaryオブジェクトが保持するランダム応答用のリスト。
                                
        """
        super().__init__(name)
        self.random = dic_random

    def response(self, input, mood):
        """ response()をオーバーライド、ランダムな応答を返す。

        Parameters:
            input(str): ユーザーが入力したメッセージ。
            mood(int): ピティナの機嫌値
            
        Returns:
            str: リストからランダムに抽出した応答メッセージ。
            
        """
        return random.choice(self.random)

class PatternResponder(Responder):
    """ パターンに反応するためのサブクラス

     Attributes:
       dictionary (Dictionaryオブジェクト):
           Dictionaryオブジェクトが保持するPatternItemオブジェクトのリスト。      

    """
    def __init__(self, name, dictionary):
        """ スーパークラスの__init()__にnameを渡し、
            Dictionaryオブジェクトをインスタンス変数に格納する。
        
        Parameters:
            name(str): Responderオブジェクトの名前。
            dictionary(Dictionaryオブジェクト)
            
        """
        super().__init__(name)
        self.dictionary = dictionary

    def response(self, input, mood):
        """ パターンにマッチした場合に応答文字列を作って返す。

            input(str): ユーザーが入力したメッセージ。
            mood(int): ピティナの機嫌値。

        Returns:
            str: パターンにマッチした場合はパターンと対になっている応答メッセージを返す。
                 パターンマッチしない場合はランダム辞書の応答メッセージを返す。
            
        """
        resp = None
        # patternリストのPatternItemオブジェクトに対して反復処理を行う。
        for ptn_item in self.dictionary.pattern:
            # パターン辞書1行の正規表現がユーザーのメッセージにマッチするか試みる。
            # マッチしたらMatchオブジェクト、そうでなければNoneが返ってくる。
            m = ptn_item.match(input)
            # マッチした場合は機嫌値moodを引数にしてchoice()を実行。
            # 現在の機嫌値に見合う応答フレーズを取得する。
            if m:
                resp = ptn_item.choice(mood)
            # choice()の戻り値がNoneでない場合は
            # 応答例の中の%match%をインプットされた文字列内の
            # マッチした文字列に置き換える
            if resp != None:
                return re.sub('%match%', m.group(), resp)
        # パターンマッチしない場合はランダム辞書から返す
        return random.choice(self.dictionary.random)
