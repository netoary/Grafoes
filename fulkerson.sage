##http://www.openproblemgarden.org/op/the_berge_fulkerson_conjecture

def stoped(graph):
    edges = graph.edges()
    stop = False
    for i in edges:
        if (i[2] != 0):
            stop = True
    return stop

def edgesMatchings(G):
    matchings = []
    match = G.perfect_matchings()

    for i in G.edges():
        G.set_edge_label(i[0], i[1], 0)

    for i in match:
        matchings.append(i)
        for j in i:
            x = G.edge_label(j[0], j[1])
            G.set_edge_label(j[0], j[1], x+1)
    #result = funcao(G)
    H = Graph()
    cont = 0
    result = treeSearchALT(G, H, matchings, cont)
    return result




def treeSearch(G, h, m, cont):
    if (cont>5):
        #print cont
        return False, None
    if(G == h):
        #print cont
        #G.show()
        return True, h
    arestas = G.edges()
    (x,y,p) = min(arestas, key=lambda x:x[2])
    menor_aresta = (x,y)
    for matching in m:
        if (menor_aresta in matching):
            for edge in matching:
                G.set_edge_label(edge[0], edge[1], oo)
                h.add_edge(edge[0], edge[1], oo)
            cont += 1
            check, grafo = treeSearch(G,h,m, cont)
            if(check):
                return True, grafo
            cont = cont - 1
    return False, None

def treeSearchALT(G, h, m, cont, M=[]):
    if (cont>5):
        #print cont
        return False, None, []
    if(G == h):
        #print cont
        #G.show()
        return True, h, []
    arestas = G.edges()
    (x,y,p) = min(arestas, key=lambda x:x[2])
    menor_aresta = (x,y)
    for matching in m:
        if (menor_aresta in matching):
            for edge in matching:
                G.set_edge_label(edge[0], edge[1], oo)
                h.add_edge(edge[0], edge[1], oo)
            cont += 1
            check, grafo, M = treeSearchALT(G,h,m, cont)
            if(check):
                M.append(matching)
                return True, grafo, M
            cont = cont - 1
    return False, None, []


#G=graphs.RandomRegular(3,12)
file=open('graphs/graphs16.g6')
ruins = []
for x in file:
    G = Graph(x)
    M = []
    if (G.bridges() == [] and G.is_connected()):
        #print x
        result, H, M = edgesMatchings(G)
        #G.show()
        K = Graph()
        for i in M:
            K.add_edges(i)
        #print(K.edges())
        #K.show()
        #print (K==G, K==H, H.degree(), result)
        #H.show()
        #G.show()
        #a = input()

        '''if (not(H==G)):
            H.show()
            G.show()
            a = input()
        '''
        if (result == False):
            ruins.append(x)

print ruins