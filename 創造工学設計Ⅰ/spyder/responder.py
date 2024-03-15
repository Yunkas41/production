import random
class Responder(object):
    def __init__(self,name):
        self.name=name
    def response(self,input):
        return ''
class RepeatResponder(Responder):
    def response(self, input):
        return '{}ってなに？'.format(input)
class RandomResponder(Responder):
    def __init__(self, name):
        super().__init__(name)
        self.responses=['いい天気だね','君はパリピ？','10円ひろった','君はだれ？','ぽけ～']
    def response(self, input):
        return (random.choice(self.responses))