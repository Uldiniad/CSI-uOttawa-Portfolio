pools([["Crestview",-75.73795670904249,45.344387632924054],["Bellevue Manor",-75.73886856878032,45.37223315413918],["Dutchie's Hole",-75.66809864107668,45.420784695340274],["Bingham",-75.69570714265845,45.43364510779131],["Alvin Heights",-75.65100870365318,45.45147956435529],["Balena",-75.64341396386098,45.40505998694386],["Bel Air",-75.76237762310991,45.35750853073128],["Raven",-75.74042790502267,45.376538041017916],["Britannia",-75.79935158132524,45.36063791083469],["Chaudiere",-75.71353870063207,45.40984992554796],["Parkdale",-75.73023035094172,45.40138661908912],["Alta Vista",-75.6663971454287,45.383081724040146],["Cecil Morrison",-75.64599611564647,45.417175891787146],["Heron",-75.67726553077785,45.37955540833377],["Brantwood",-75.67162178567759,45.406132203975446],["Lisa",-75.78888493568607,45.344203611634356],["McKellar",-75.7663355603181,45.383356299319395],["Overbrook",-75.65712102762836,45.42506341603979],["Owl",-75.66479650124089,45.35438810082107],["Pushman",-75.64825277394819,45.35958959542747],["Sandy Hill",-75.67679178631916,45.421628374955425],["Westboro",-75.75301290567192,45.38390614815524],["Windsor",-75.67593721799336,45.394532186176534],["Frank Ryan",-75.78913776510414,45.35618157210449],["Strathcona",-75.67270686637411,45.42814320884978],["Greenboro",-75.63644623282283,45.363297932669155],["Sylvia Holden",-75.68218644953257,45.40257049489391],["Kiwanis",-75.65314626399277,45.43665037776025],["Entrance",-75.81675609520583,45.32631894820216],["General Burns",-75.72068192228832,45.3517223372365],["Corkstown",-75.82733278768433,45.34609228122724],["Pauline Vanier",-75.676559014967,45.366710168887366],["St. Luke's",-75.68696475924723,45.41513265659813],["Canterbury",-75.62883265479898,45.389521642267944],["Alda Burt",-75.62566700143215,45.402733068354976],["Hawthorne",-75.615926705023,45.39368089918365],["Weston",-75.62613467769313,45.39596271646451],["Michèle",-75.8020190093133,45.3548865821927],["Parkway",-75.77593080375445,45.35631278392867],["Ruth Wildgen",-75.7957485439787,45.35143574971178],["Agincourt",-75.75360944568821,45.35959223124413],["Elizabeth Manley",-75.61936964815708,45.36999070895657],["Jules Morin",-75.68154277234615,45.433497486473115],["Kingsmere",-75.7625479468355,45.36492415895533],["Carleton Heights",-75.70254191613397,45.35963576001747],["Rideauview",-75.70673708550083,45.367907282835596],["Frank Licari",-75.65708630346525,45.36886086041407],["Optimiste",-75.66850786065743,45.442237661390195],["Glen Cairn",-75.88504321403646,45.29552398823589],["Bearbrook",-75.56367146417631,45.43415859594989],["Iona",-75.74247203669871,45.392425824249926],["Meadowvale",-75.72477696260978,45.37828145083384],["Reid",-75.72389983475932,45.39809949308152],["Hampton",-75.73836344415304,45.38742953063268],["St-Laurent",-75.64849014424264,45.436351255364265],["St. Paul's",-75.64813126103986,45.43004145660221],["Woodroffe",-75.77225704729584,45.37607987330218],["Lions",-75.75232047849263,45.39427770813794],["McNabb",-75.70274498043973,45.40897618041744],["Alexander",-75.73163858599659,45.380330193754176],["Champlain",-75.74496450985441,45.40431589991452],["Ev Tremblay",-75.71148292845268,45.39934611083154]]).

saveRoute(Route,File) :- findRoute(Route), open(File,write,Out), writeToFile(Route,Out), close(Out). %Finds a route Route and writes it to file File.

findRoute(Route) :- retractall(added(_)), retractall(edge(_,_)), retractall(visited(_)), retractall(route(_)), sortPools(Pools), first(Pools,Root), assertz(added(Root)), delete(Pools,Root,RootlessPools), leastDistant(Root, RootlessPools, Min), assertz(edge(Root,Min)), assertz(added(Min)), delete(RootlessPools,Min,LessPools), buildTree(LessPools), assertz(visited(Root)), assertz(route([])), preorder(Root), route(Partial), push(Root,Partial,Partial2), first(Root,Name), addDistances([[Name,0]],Partial2,_,0,Route). %Retracts and sets all dynamic predicates, sorts the pool list, sets the root node of the tree, adds an edge to the closest node in the pool list (excluding root), builds the tree, traverses the tree in preorder and sums the distance traveled at each node. Appends the distances to the corresponding node and returns this list (Route).

writeToFile([],_).
writeToFile([H|T],Out) :- first(H,Name), last(H,Distance), write(Out,Name), write(Out," "), write(Out,Distance), nl(Out), writeToFile(T,Out). %Opens file File in append mode with output stream Out and takes the Name and Distance of the first element in the route list and writes it to the file. Repeats the process recursively for each element in the list

sortPools(Sorted) :- pools(List), predsort(compareLongitude,List,Sorted). %Sorts the pools list using the predicate compareLatitude

compareLongitude(X,[_,Longitude1,_],[_,Longitude2,_]) :- compare(X,Longitude1,Longitude2). %Compares latitudes of two pools and returns the symbol equalling the result of the comparison (<, ==, >)

first([H|_], H). %Returns the head of a list

leastDistant(Node,List,Min) :- predsort(compareDistance(Node),List,Sorted), first(Sorted,Min). %Finds the least distant node (Min) in the List from Node by sorting the list using predicate compareDistance and taking the first element of the returned sorted list

compareDistance(Node,X,Node1,Node2) :- distance(Node,Node1,Distance1), distance(Node,Node2,Distance2), compare(X,Distance1,Distance2). %Compares the distance between Node and Node1 with the distance between Node and Node2 and returns the symbol equalling the result of the comparison (<, ==, >)

distance([_,Longitude1,Latitude1],[_,Longitude2,Latitude2],Distance) :- toRadians(Latitude1,Lat1), toRadians(Latitude2,Lat2), toRadians(Longitude1,Lon1), toRadians(Longitude2,Lon2), Distance is 6371*2*asin(sqrt(((sin((Lat1-Lat2)/2))^2)+cos(Lat1)*cos(Lat2)*((sin((Lon1-Lon2)/2))^2))). %Calculates the distance in kilometers between two geopgraphical coordinates

toRadians(Degrees, Degrees*(pi/180)). %Converts Degrees to Radians

buildTree([]).
buildTree([H|T]) :- setof(Nodes,added(Nodes),Tree), leastDistant(H,Tree,Min), assertz(edge(Min,H)), assertz(added(H)), buildTree(T). %Builds a tree by checking the nodes that are currently in the tree (added(_)), finding the node in the tree that is least distant (Min) from the current node (H) and creates an edge between the two. Repeats the process recursively until all nodes are added (list is empty)

preorder(_) :- setof(Nodes,added(Nodes),Added), setof(Nodes,visited(Nodes),Visited), Added == Visited.
preorder(Node) :- edge(Node,Child), assertz(visited(Child)), route(Partial), append(Partial,[Child],Route), retractall(route(_)), assertz(route(Route)), preorder(Child). %For each edge between Node and Child, visit Child, take the name, append the element to the cumulative route and update the cumulative route. Repeat the process recursively until all nodes have been visited

push(Element,List,[Element|List]). %Appends an Element to the front of the List

addDistances(Route,[_|[]],_,_,Route).
addDistances(Partial,[H|T],Acc,Sum,Route) :- first(T,B), distance(H,B,Distance), Sum1 is Sum+Distance, first(B,Name), append(Partial,[[Name,Sum1]],Acc), addDistances(Acc,T,_,Sum1,Route). %Calculates the distance between the next head and the current head and appends the distance to the current head. Repeat the process recursively until the next head is empty 