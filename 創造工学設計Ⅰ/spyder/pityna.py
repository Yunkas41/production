import responder
class Pityna(object):
    def __init__(self,name):
        self.name=name
        self.responder=responder.RepeatResponder('Repeat')
    def dialogue(self,input):
        return self.responder.response(input)
    def get_responder_name(self):
        return self.responder.name
    def get_name(self):
        return self.name