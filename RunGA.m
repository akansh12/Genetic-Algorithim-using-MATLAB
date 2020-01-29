function out = RunGA(problem,params)

% Problem 
CostFunction = problem.CostFunction;
nVar = problem.nVar;



% Params
 MaxIt = params.MaxIt;
 nPop = params.nPop;
 pC = params.pC;
 nC = round(pC*nPop/2)*2;
 mu = params.mu;
 mat = [512,256,128,64,32,16,8,4,2,0];
 
 empty_individual.Position = [];
 empty_individual.Cost = [];
 
 % elitism 
 bestsol.Cost = inf;

 %Initialization 
 pop = repmat(empty_individual,nPop, 1);
 
 for i = 1: nPop
     pop(i).Position = randi([0,1],1,nVar);
     pop(i).Cost = CostFunction(pop(i).Position);
     
     %Elitism
     if pop(i).Cost < bestsol.Cost
         bestsol = pop(i);
     
     end
     
     
 end
 
     bestcost = nan(MaxIt,1);

 
 % Main Loop
     for it = 1:MaxIt
         
         %initializing Offspring
         popc = repmat(empty_individual,nC/2,2);
         
        for k = 1:nC/2
            q = randperm(nPop);
            p1 = pop(q(1));
            p2 = pop(q(2));
            [popc(k,1).Position,popc(k,2).Position] = SinglePointCrossover(p1.Position,p2.Position);
        end
        
        %convert popc to Single-coloumn matrix
        popc = popc(:);
        
        %mutation
        for l = 1:nC
            
            
            popc(l).Position = Mutate(popc(1).Position,mu);
            
            popc(l).Cost = CostFunction(popc(1).Position);
            
     %Elitism
     if popc(l).Cost < bestsol.Cost
         bestsol = popc(l);
     
     end
            
            
            
        end
      
      %update Best Cost oof iteration
      
      bestcost(it) = bestsol.Cost;
      
      %Merging and sorting
      pop = [pop;popc];
      pop = SortPopulation(pop);
      
      
      %Remove extra
       pop = pop(1:nPop);
       disp(['Iteration' num2str(it) 'Best Cost = '  num2str(bestcost(it))]);
       
      
      
      
      
         
         
         
     end
     
 
    out.pop = pop;
    out.bestsol = bestsol;
    out.bestcost = bestcost;
    out.variable = [sum(out.bestsol.Position(1:10).*mat)*(6-0)./(2^10 -1),sum(out.bestsol.Position(11:20).*mat)*(6-0)./(2^10 -1)];
    plot(1:params.MaxIt,bestcost)
    
    



end