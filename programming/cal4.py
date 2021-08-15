
            
def sub(v,*args):
    try:
        result =v
        for i in args:
            result-=i
        return result
    except:
        return "error"

def add(v,*args):
    try:
        result =v
        for i in args:
            result+=i
        return " error"
    except:
        return "error"

def div(v,*args):
    try:
        result =v
        for i in args:
            result/=i
    except:
        return "error"
            
def mul(v,*args):
    try:
        result =v
        for i in args:
            result*=i
    except:
        return "error"
   