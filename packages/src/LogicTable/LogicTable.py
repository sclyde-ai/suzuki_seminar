import pandas as pd
import itertools
import string
from sympy import sympify

class LogicTable():
    def __init__(self, n:int):
        self.columns = list(string.ascii_uppercase)[:n]
        self.bools = [True, False]
        self.df = pd.DataFrame(list(itertools.product(self.bools, repeat=n)), columns=self.columns)
        
    @property
    def df_01(self):
        return self.df.astype(int)

    def add(self, prop):
        prop = str(sympify(prop))
        self.df[prop] = self.df.eval(prop)
        return self

    def re_add(self, prop):
        prop = sympify(prop)
        if not prop.args:
            return
        
        for arg in prop.args:
            self.re_add(arg)
        
        col_name = str(prop)
        
        if col_name not in self.df.columns:
            self.df[col_name] = self.df.eval(col_name)