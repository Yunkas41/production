import responder
import dictionary

class Pityna(object):
    def __init__(self, name):

        self.name = name
        self.dictionary = dictionary.Dictionary()
        self.res_repeat = responder.RepeatResponder('Repeat?')
        self.res_random = responder.RandomResponder(
                'Random', self.dictionary.random
                )
        self.res_pattern = responder.PatternResponder(
                'Pattern', self.dictionary
                )

    def dialogue(self, input):
        self.responder = self.res_pattern
        return self.responder.response(input)

    def get_responder_name(self):
        return self.responder.name

    def get_name(self):
        return self.name