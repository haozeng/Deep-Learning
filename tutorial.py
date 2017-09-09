from urllib import urlopen
from parse import *

'''
Returns a tuple (Sector, Indistry)
Usage: GFinSectorIndustry('IBM')
'''
def GFinSectorIndustry(name):
  tree = parse(urlopen('http://www.google.com/finance?&q='+name), '')
  return tree.xpath("//a[@id='sector']")[0].text, tree.xpath("//a[@id='sector']")[0].getnext().text


print GFinSectorIndustry('ANGI')
