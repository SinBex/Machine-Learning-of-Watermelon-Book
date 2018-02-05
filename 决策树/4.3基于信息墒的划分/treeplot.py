# -*- coding: utf-8 -*-
"""
Created on Sun Jan 15 10:19:20 2017

@author: icefire  &&SinBex reference
"""

import numpy as np
from matplotlib import pyplot as plt
'''
注释请看dtreeplot.py
'''
class treenode:
    def __init__(self,father,height,data):
        self.father=father
        self.children=[]
        self.data=data
        self.height=height
        self.pos=0;
        self.offset=0;
        
class treeplot:
    def __init__(self,link,minspace,r,lh):
        s=len(link)
        treenodelist=[]
        treelevel=[]

        for i in range(0,s):
            if link[i]==i:
                treenodelist.append(treenode(link[i],0,str(i)))
            else:
                treenodelist.append(treenode(link[i],treenodelist[link[i]].height+1,str(i)))
                treenodelist[link[i]].children.append(treenodelist[i]);
                treenodelist[i].father=treenodelist[link[i]];
        
            if len(treelevel)==treenodelist[i].height:
                treelevel.append([])
            treelevel[treenodelist[i].height].append(treenodelist[i])
            
        treelevel.reverse()  
        self.left=99999
        self.right=0
        self.__calpos(treelevel,minspace)          
        self.__drawtree(treenodelist[0] ,r,lh,0)
        plt.xlim(xmin=self.left,xmax=self.right+minspace)
        plt.ylim(ymin=len(treelevel)*lh+lh/2,ymax=lh/2)
        plt.show()

          
    def __calonebyone(self,nodes,l,r,start,minspace):
        for i in range(l,r):
                nodes[i].pos=max(nodes[i].pos,start)
                start=nodes[i].pos+minspace;
        return start;
    
    def __calpos(self,treelevel,minspace):
        
        for nodes in treelevel:
            noleaf=[]
            num=0;
            for node in nodes:
                if len(node.children)>0:
                    noleaf.append(num)
                    node.pos=(node.children[0].pos+node.children[-1].pos)/2
                num=num+1
                                        
            if(len(noleaf))==0:
                self.__calonebyone(nodes,0,len(nodes),0,minspace)
            else:
                start=nodes[noleaf[0]].pos-noleaf[0]*minspace
                self.left=min(self.left,start-minspace)
                start=self.__calonebyone(nodes,0,noleaf[0],start,minspace)
                for i in range(0,len(noleaf)):
                    nodes[noleaf[i]].offset=max(nodes[noleaf[i]].pos,start)-nodes[noleaf[i]].pos
                    nodes[noleaf[i]].pos=max(nodes[noleaf[i]].pos,start)
                    

                    if(i<len(noleaf)-1):
                            dis=(nodes[noleaf[i+1]].pos-nodes[noleaf[i]].pos)/(noleaf[i+1]-noleaf[i])
                            start=nodes[noleaf[i]].pos+max(minspace,dis)
                            start=self.__calonebyone(nodes,noleaf[i]+1,noleaf[i+1],start,max(minspace,dis))
                    else:
                         start=nodes[noleaf[i]].pos+minspace
                         start=self.__calonebyone(nodes,noleaf[i]+1,len(nodes),start,minspace)
                         

 
    def __drawtree(self,treenode,r,lh,curoffset):
         treenode.pos=treenode.pos+curoffset
         if(treenode.pos>self.right):
             self.right=treenode.pos
         drawcircle(treenode.pos,(treenode.height+1)*lh,r)
         plt.text(treenode.pos, (treenode.height+1)*lh, treenode.data, color=(1,0,0),ha='center', va='center')
         for node in treenode.children:
             self.__drawtree(node,r,lh,curoffset+treenode.offset)
             
             off=np.array([treenode.pos-node.pos,-lh])
             off=off*r/np.linalg.norm(off)
             plt.plot([treenode.pos-off[0],node.pos+off[0]],[(treenode.height+1)*lh-off[1],(node.height+1)*lh+off[1]],color=(0,0,0))

         
def drawcircle(x,y,r):
     theta = np.arange(0, 2 * np.pi, 2 * np.pi / 1000)
     theta = np.append(theta, [2 * np.pi])
     x1=[]
     y1=[]
     for tha in theta:
         x1.append(x + r * np.cos(tha))
         y1.append(y + r * np.sin(tha))
     plt.plot(x1, y1,color=(0,0,0))
 
#link=[0,0,1,2,2,2,2,1,1,0,9,9,9,12,12,12,12] 
#link=[0,0,0,2,2,2,5,5,5,5,9,9,9,9,9] 
#link=[0,0,1,1,1,0,5,5,0,8,8,10,8]     
#link=[0,0,1,1,3,3,0,6,0,8,9,8,8]
link=[0,0,1,1,0,4,4,0]
#link=[0,0,1,1,3,3,5,6,6,5,9,9,0,12,12,14,14,16,16,18,18,0,21,22,22]
treeplot(link,6,1,-6)