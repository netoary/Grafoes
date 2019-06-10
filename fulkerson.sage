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
    result = funcao(G)
    return result



def funcao(G):
    oldLabel = G.edges()
    mini = 10000
    stop = False
    cont = 0
    end = True

    while end:
        stop = False
        mini = 100000
        for i in oldLabel:
            if (i[2] < mini and i[2] != 0):
                mini = i[2]

        for i in matchings:
            for j in i:
                if (G.edge_label(j[0],j[1]) == mini):
                    for k in i:
                        G.set_edge_label(k[0], k[1], 0)
                    cont = cont + 1
                    stop = True
                    matchings.remove(i)
                    oldLabel = G.edges()
                    break
            if (stop == True):
                break
        #print G.edges(), cont
        end = stoped(G)

    if (cont > 5):
        return False
    return True


#G=graphs.RandomRegular(3,12)
file=open('graphs/graphs10.g6')
ruins = []
for x in file:
    G = Graph(x)
    result = edgesMatchings(G)
    if (result == False):
        ruins.append(x)

print ruins