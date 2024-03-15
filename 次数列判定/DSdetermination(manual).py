import copy 

def prettyPrint(data,list,flag):
    if flag==True:
        print(list,'はグラフ的なので、\n',data,'もグラフ的である\n')
    elif flag==False:
        print(list,'はグラフ的でないので、\n',data,'もグラフ的でない\n')

def Os(list):    
    s=list.pop(0)
    print(s,list)
    for i in range(s):
        list[i]-=1
    list.sort(reverse=True)


def Hn(list):
    flag=False
    for i in range(len(list)):
        if list[i]<0:
            flag=True
            break
    return flag

def oP(list):
    flag=False
    if sum(list)%2==1:
        flag=True
    return flag

def il(list):
    flag=True
    if len(list)>list[0]:
        flag=False
        for i in list[1:list[0]]:
            if i==0:
                flag=True
                break
    return flag    

def cZ(list):
    flag=False
    if sum(list)==0:
        flag=True
    return flag

def jud(list):
    flag=None
    if il(list)or oP(list)or Hn(list):
        flag=False
        print('グラフ的でない')
    elif cZ(list):
        flag=True
        print('グラフ的である')
    return flag


li=list(map(int,input('>').split(',')))
li.sort(reverse=True)
print(li)    
flag=None
data=copy.copy(li)
flag=jud(li)
while flag is None:
    Os(li)
    print(' ',li)
    flag=jud(li)
prettyPrint(data,li,flag)