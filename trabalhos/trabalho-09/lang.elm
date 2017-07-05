import Html exposing (text)

type Exp = Add Exp Exp
         | Num Int
         | Var String
         | Logic Int Int
        
         
type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog   
          | While Exp Prog Prog
      
         
type alias Env = (String -> Int)
zero : Env
zero = \ask -> 0

evalLogic : Int -> Int -> Int
evalLogic n1 n2 = if(n1 > n2) then 1 else 0

evalExp : Exp -> Env -> Int
evalExp exp env =   
    case exp of
        Add exp1 exp2  -> (evalExp exp1 env) + (evalExp exp2 env)
        Num v          -> v
        Var var        -> (env var)    
        Logic n1 n2    -> evalLogic n1 n2

        
        
evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2 ->
            (evalProg s2 (evalProg s1 env))
        Attr var exp ->
            let
                val = (evalExp exp env)
            in
                \ask -> if ask==var then val else (env ask)  
        If exp caseTrue caseFalse ->
            (evalProg(if (evalExp exp env /= 0) then caseTrue else caseFalse) env)
            
        While exp continueProg stopProg ->
            let
               x = evalExp exp env
            in
             
            if (evalLogic x 100 == 0) then                 
                evalProg (While exp continueProg stopProg) (evalProg continueProg env) 
            else evalProg stopProg env            
            
            
lang : Prog -> Int
lang p = ((evalProg p zero) "ret")   

--p1 : Prog
--p1 = If (Logic 3 2) (Attr "ret" (Num 11)) (Attr "ret" (Add (Num 5) (Num 9)))

p4 : Prog
p4 = Seq 
        (Attr "y" (Num 0))
        (While (Var "y")(Attr "y" (Add (Var "y") (Num 5))) (Attr "ret" (Var "y")))


main = text (toString (lang p4))