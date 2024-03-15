class Pityna:
    def __init__(self,name):
        self.name=name
        self.responder=Responder('Repeat')
    def dialogue(self,input):
        return self.responder.response(input)
    def get_responder_name(self):
        return self.responder.name
    def get_name(self):
        return self.name

class Responder:
    def __init__(self,name):
        self.name=name
    def response(self,input):
        return '{}ってなに？'.format(input)


def prompt(obj):
    return obj.get_name()+':'+obj.get_responder_name()+'>'

print('Pityna System prototype :pityna')
pityna=Pityna('Pityna')

while True:
    inputs=input(' > ')
    if not inputs:
        print('バイバイ')
        break
    else:
        response=pityna.dialogue(inputs)
        print(prompt(pityna),response)