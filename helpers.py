import matplotlib.pyplot as plt
import pandas as pd



def connectpoints(x,y,p1,p2):
    x1, x2 = x[p1], x[p2]
    y1, y2 = y[p1], y[p2]
    plt.plot([x1,x2],[y1,y2],'k-')
    
def print_results(filename):
    colnames=['method','FM','AMI','Rand']
    results = pd.read_csv(filename, index_col=0).iloc[:,:4]
    results.columns = colnames
    print(results)
    
def print_best_g(filename):
    results = pd.DataFrame(pd.read_csv(filename, index_col=0).iloc[0,4:].transpose())
    results.insert(0,'Dla',['FM','AMI','Rand'])
    print(results)