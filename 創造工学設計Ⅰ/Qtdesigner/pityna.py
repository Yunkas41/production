import random
import responder
import dictionary

class Pityna(object):
    """ ピティナの本体クラス
    
    Attributes:
      name (str): Pitynaオブジェクトの名前を保持する。
      dictionary (obj:`Dictionary`): Dictionaryオブジェクトを保持する。
      res_repeat (obj:`RepeatResponder`): RepeatResponderオブジェクトを保持する。      
      res_random (obj:`RandomResponder`): RandomResponderオブジェクトを保持する。      
      res_pattern (obj:`PatternResponder`): PatternResponderオブジェクトを保持する。      

    """
    def __init__(self, name):
        """ Pitynaオブジェクトの名前をnameに格納。
            Responderオブジェクトを生成してresponderに格納。
            
        Parameters:
            name(str)   : Pitynaオブジェクトの名前。
        """
        # Pitynaオブジェクトの名前をインスタンス変数に代入。
        self.name = name
        # Dictionaryを生成
        self.dictionary = dictionary.Dictionary() # ----------------①
        # RepeatResponderを生成
        self.res_repeat = responder.RepeatResponder('Repeat?') # ---②
        # RandomResponderを生成
        self.res_random = responder.RandomResponder(
                'Random', self.dictionary.random
                ) # ------------------------------------------------③
        # PatternResponderを生成
        self.res_pattern = responder.PatternResponder(
                'Pattern', self.dictionary
                ) # ------------------------------------------------④

    def dialogue(self, input):
        """ 応答オブジェクトのresponse()を呼び出して応答文字列を取得する。

        Parameters:
            input(str)  :ユーザーによって入力された文字列。                
            Returns:
            str: 応答文字列。
        """
        # 1から100をランダムに生成
        x = random.randint(1, 100) # ------------------------------⑤
        # 60以下ならPatternResponderオブジェクトにする
        if x <= 60: # ----------------⑥
            self.responder = self.res_pattern
        # 61～90以下ならRandomResponderオブジェクトにする
        elif 61 <= x <= 90:
            self.responder = self.res_random
        # それ以外はRepeatResponderオブジェクトにする
        else:
            self.responder = self.res_repeat
        return self.responder.response(input) # -------------------⑦

    def get_responder_name(self):
        """ 応答に使用されたオブジェクト名を返す。
        
        Returns:
            str: 応答オブジェクトの名前。        
        """
        # responderに格納されているオブジェクト名を取得し戻り値にする。
        return self.responder.name

    def get_name(self):
        """ Pitynaオブジェクトの名前を返す。
               
        Returns:
            str: Pitynaクラスを示す文字列。        
        """
        # インスタンス変数nameの値を戻り値にする。 
        return self.name