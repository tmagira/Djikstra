import java.util.PriorityQueue;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;


int nKota = 9 , radius = 18 , source = 0 , dest = 4, tanggal;
Vertex[] cities;
Djikstra akuPeta; 
List<Vertex> path;
float totalJarak = 0;


void setup() {
  size(800, 1000);
    cities = new Vertex[nKota];
     akuPeta = new Djikstra();
    cities[0] = new Vertex("UNPAR" , 400 , 300 ,0, 255, 4) ;
    cities[1] = new Vertex("Lembang" , 450 , 106 ,120, 235, 255) ;
    cities[2] = new Vertex("Dago" ,  462 , 320 ,255, 92, 103) ;
    cities[3] = new Vertex("Setiabudhi" ,  320 , 320 ,227, 141, 227) ;
    cities[4] = new Vertex("Sukajadi" ,  202 , 330 ,251, 255, 0) ;
    cities[5] = new Vertex("Cihampelas" ,  220 , 412 ,196, 131, 96) ;
    cities[6] = new Vertex("Gedung Sate" ,  462 , 478 ,250, 142, 0) ;
    cities[7] = new Vertex("Alun-alun" ,  300 , 550 ,187, 201, 54) ;
    cities[8] = new Vertex("Antapani" ,  700 , 330 ,227, 89, 255) ;
   
    cities[0].adjacencies = new Edge[]{ new Edge(cities[1], 9.7),
                            new Edge(cities[2], 3.1),
                            new Edge(cities[5], 2.5),
                            new Edge(cities[6], 5.0),
                            new Edge(cities[3], 4.0)};
                               
    cities[1].adjacencies = new Edge[]{ new Edge(cities[0], 9.7),
                            new Edge(cities[2], 10),
                            new Edge(cities[3], 12)};
    
    cities[2].adjacencies = new Edge[]{ new Edge(cities[0], 3.1),   
                            new Edge(cities[1], 10), 
                            new Edge(cities[6], 3.3),
                            new Edge(cities[8], 9.3),
                            new Edge(cities[5], 2.5) };
    
    cities[3].adjacencies = new Edge[]{ new Edge(cities[0], 4.0),
                            new Edge(cities[1], 12),
                            new Edge(cities[5], 1.8),
                            new Edge(cities[4], 5.9)};
     
    cities[4].adjacencies = new Edge[]{ new Edge(cities[3], 5.9),
                            new Edge(cities[5], 4.1)};
                            
    cities[5].adjacencies = new Edge[]{ new Edge(cities[0], 2.5),
                            new Edge(cities[3], 1.8),
                            new Edge(cities[2], 2.5),
                            new Edge(cities[7], 4.8),
                            new Edge(cities[4], 4.1)};
                            
    cities[6].adjacencies = new Edge[]{ new Edge(cities[0], 5.0),
                            new Edge(cities[2], 3.3),
                            new Edge(cities[8], 6.4),
                            new Edge(cities[7], 3.2)};
                                                     
    cities[7].adjacencies = new Edge[]{ new Edge(cities[6], 3.2),
                            new Edge(cities[5], 4.8),
                            new Edge(cities[8], 7.8)};
              
    cities[8].adjacencies = new Edge[]{ new Edge(cities[2], 9.3),
                            new Edge(cities[6], 6.4),
                            new Edge(cities[7], 7.8)};
    
   
      
   akuPeta.computePaths(cities[source]); //awal
   
   tanggal = int(random(32));
      path = akuPeta.getShortestPathTo(cities[dest]);
}

void draw() {
  background(000);
  ellipse(50, 50, 30, 30);
  text("Cheap Way - Djikstra Visualization" ,70, 52);
 
  fill(255);
   text(" Tanggal Hari ini : " + tanggal , 20,600);
  text(" Total Jarak:" + nf(cities[dest].minDistance,0,2) , 20,620);
  if(tanggal%2==0){
    text(" Total Ongkos Grabcar:" + cities[dest].minDistance * 3000 , 20,640);
    text(" Total Ongkos Go-Car:" + cities[dest].minDistance * 7000 , 20,660);
  }
  else{
    text(" Total Ongkos Grabcar:" + cities[dest].minDistance * 7000 , 20,640);
  text(" Total Ongkos Go-Car:" + cities[dest].minDistance * 4000 , 20,660);
  }
  
  
  for (int i = 0; i < cities.length; i++) {
    fill(cities[i].red , cities[i].green , cities[i].blue);
    text(cities[i].name , cities[i].x , cities[i].y-10);
    ellipse(cities[i].x, cities[i].y, radius, radius);
  }
  
    stroke(255);
    strokeWeight(1);
    fill(255);
    for(int j = 0 ; j<cities.length ; j++){
        for (int i = 0; i < cities[j].adjacencies.length; i++) {
           text(nf(cities[j].adjacencies[i].weight,0,2) + "" , (cities[j].x + cities[j].adjacencies[i].target.x)/2   ,(cities[j].y + cities[j].adjacencies[i].target.y)/2 );
          line(cities[j].x , cities[j].y , cities[j].adjacencies[i].target.x ,cities[j].adjacencies[i].target.y );
        }
    }
      stroke(255 , 0 ,255);
          strokeWeight(1);
          noFill();
           for(int i = 0 ; i<path.size()-1 ; i++){
             
             Vertex source = this.path.get(i);
              Vertex dest = this.path.get(i+1);
               line(source.x , source.y , dest.x,dest.y);
             
           }
   
    
   
  
}

class Vertex implements Comparable<Vertex>
{
  
    float x , y ,red ,green,blue ;
    public final String name;
    public Edge[] adjacencies;
    public float minDistance = Float.POSITIVE_INFINITY;
   
    public Vertex previous;
    public Vertex(String argName , float x , float y , float r , float g , float b ) 
    { 
        name = argName; 
        this.x = x ;
        this.y = y ;
        this.red = r;
        this.green = g ;
        this.blue = b;

    }
    public String toString() { return name; }
    public int compareTo(Vertex other)
    {
        return Double.compare(minDistance, other.minDistance);
    }
}

class Edge
{
    public final Vertex target;
    public final float weight;
    public Edge(Vertex argTarget, float argWeight)
    { target = argTarget; weight = argWeight; }
}

class Djikstra{
   public  void computePaths(Vertex source)
    {
        source.minDistance = 0.;
        PriorityQueue<Vertex> vertexQueue = new PriorityQueue<Vertex>();
      vertexQueue.add(source);

       while (!vertexQueue.isEmpty()) {
           Vertex u = vertexQueue.poll();

            // Visit each edge exiting u
            for (Edge e : u.adjacencies)
            {
                Vertex v = e.target;
                float weight = e.weight;
                float distanceThroughU = u.minDistance + weight;
              if (distanceThroughU < v.minDistance) {
                  vertexQueue.remove(v);
                  v.minDistance = distanceThroughU ;
                  v.previous = u;
                  vertexQueue.add(v);
              }
            }
        }
    }
    
    public  List<Vertex> getShortestPathTo(Vertex target)
    {
        List<Vertex> path = new ArrayList<Vertex>();
        for (Vertex vertex = target; vertex != null; vertex = vertex.previous)
            path.add(vertex);
        Collections.reverse(path);
        return path;
        //gapaham disini gaiss kok jadi salah :)
    }
  
}
void mouseClicked() {
  //System.out.println(mouseX);\
  
  for(int i =0; i<cities.length;i++){ 
    Vertex v = cities[i];
     if(dist(v.x , v.y , mouseX , mouseY) < radius){
           dest = i;
           path = akuPeta.getShortestPathTo(cities[dest]); 
           System.out.print(path);

     }

  }
}
