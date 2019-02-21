import json

data = json.load(open('wading-pools.json'))
txt_file = open('pools.txt', 'w')
prolog_file = open('findroute.pl', 'w')
i = 0
pl = 'pools(['
while i < len(data['features']):
    pool_name_data = data['features'][i]['properties']['NAME'].split()
    pool_name = ''
    j = 3
    while j < len(pool_name_data):
        pool_name += pool_name_data[j] + ' '
        j = j + 1
    pool_name = pool_name[:-1]
    pool_location = data['features'][i]['geometry']['coordinates']
    txt = pool_name + ' ' + str(pool_location[0]) + ' ' + str(
        pool_location[1])
    txt_file.write(txt + "\n")
    pl = pl + '["' + pool_name + '",' + str(
        pool_location[0]) + ',' + str(
        pool_location[1]) + '],'
    i = i + 1
pl = pl[:-1]
prolog_file.write(pl + ']).\n\n')
prolog_file.write(
    'saveRoute(Route,File) :- findRoute(Route), open(File,write,Out), writeToFile(Route,Out), close(Out). %Finds a '
    'route Route and writes it to file File.\n\n' +

    'findRoute(Route) :- retractall(added(_)), retractall(edge(_,_)), retractall(visited(_)), retractall(route(_)), '
    'sortPools(Pools), first(Pools,Root), assertz(added(Root)), delete(Pools,Root,RootlessPools), leastDistant(Root, '
    'RootlessPools, Min), assertz(edge(Root,Min)), assertz(added(Min)), delete(RootlessPools,Min,LessPools), '
    'buildTree(LessPools), assertz(visited(Root)), assertz(route([])), preorder(Root), route(Partial), push(Root,'
    'Partial,Partial2), first(Root,Name), addDistances([[Name,0]],Partial2,_,0,Route). %Retracts and sets all dynamic '
    'predicates, sorts the pool list, sets the root node of the tree, adds an edge to the closest node in the pool '
    'list (excluding root), builds the tree, traverses the tree in preorder and sums the distance traveled at each '
    'node. Appends the distances to the corresponding node and returns this list (Route).\n\n' +

    'writeToFile([],_).\n'
    'writeToFile([H|T],Out) :- first(H,Name), last(H,Distance), write(Out,Name), write(Out," "), write(Out,Distance), '
    'nl(Out), writeToFile(T,Out). %Opens file File in append mode with output stream Out and takes the Name and '
    'Distance of the first element in the route list and writes it to the file. Repeats the process recursively for '
    'each element in the list\n\n' +

    'sortPools(Sorted) :- pools(List), predsort(compareLongitude,List,Sorted). %Sorts the pools list using the '
    'predicate compareLatitude\n\n' +

    'compareLongitude(X,[_,Longitude1,_],[_,Longitude2,_]) :- compare(X,Longitude1,Longitude2). %Compares latitudes '
    'of two pools and returns the symbol equalling the result of the comparison (<, ==, >)\n\n' +

    'first([H|_], H). %Returns the head of a list\n\n'

    'leastDistant(Node,List,Min) :- predsort(compareDistance(Node),List,Sorted), first(Sorted,Min). %Finds the least '
    'distant node (Min) in the List from Node by sorting the list using predicate compareDistance and taking the '
    'first element of the returned sorted list\n\n' +

    'compareDistance(Node,X,Node1,Node2) :- distance(Node,Node1,Distance1), distance(Node,Node2,Distance2), '
    'compare(X,Distance1,Distance2). %Compares the distance between Node and Node1 with the distance between Node and '
    'Node2 and returns the symbol equalling the result of the comparison (<, ==, >)\n\n' +

    'distance([_,Longitude1,Latitude1],[_,Longitude2,Latitude2],Distance) :- toRadians(Latitude1,Lat1), toRadians('
    'Latitude2,Lat2), toRadians(Longitude1,Lon1), toRadians(Longitude2,Lon2), Distance is 6371*2*asin(sqrt(((sin(('
    'Lat1-Lat2)/2))^2)+cos(Lat1)*cos(Lat2)*((sin((Lon1-Lon2)/2))^2))). %Calculates the distance in kilometers between '
    'two geopgraphical coordinates\n\n' +

    'toRadians(Degrees, Degrees*(pi/180)). %Converts Degrees to Radians\n\n' +

    'buildTree([]).\n' +
    'buildTree([H|T]) :- setof(Nodes,added(Nodes),Tree), leastDistant(H,Tree,Min), assertz(edge(Min,H)), '
    'assertz(added(H)), buildTree(T). %Builds a tree by checking the nodes that are currently in the tree (added(_)), '
    'finding the node in the tree that is least distant (Min) from the current node (H) and creates an edge between '
    'the two. Repeats the process recursively until all nodes are added (list is empty)\n\n' +

    'preorder(_) :- setof(Nodes,added(Nodes),Added), setof(Nodes,visited(Nodes),Visited), Added == Visited.\n' +
    'preorder(Node) :- edge(Node,Child), assertz(visited(Child)), route(Partial), append(Partial,[Child],Route), '
    'retractall(route(_)), assertz(route(Route)), preorder(Child). %For each edge between Node and Child, '
    'visit Child, take the name, append the element to the cumulative route and update the cumulative route. Repeat '
    'the process recursively until all nodes have been visited\n\n' +

    'push(Element,List,[Element|List]). %Appends an Element to the front of the List\n\n' +

    'addDistances(Route,[_|[]],_,_,Route).\n' +
    'addDistances(Partial,[H|T],Acc,Sum,Route) :- first(T,B), distance(H,B,Distance), Sum1 is Sum+Distance, first(B,'
    'Name), append(Partial,[[Name,Sum1]],Acc), addDistances(Acc,T,_,Sum1,Route). %Calculates the distance between the '
    'next head and the current head and appends the distance to the current head. Repeat the process recursively '
    'until the next head is empty '
)
prolog_file.close()
txt_file.close()
