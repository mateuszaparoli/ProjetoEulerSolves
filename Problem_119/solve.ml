(* Função para calcular a soma dos dígitos de um número *)
fun somaDigitos n =
    let
        fun digitosRec 0 acc = acc
          | digitosRec n acc = digitosRec (n div 10) (acc + (n mod 10))
    in
        digitosRec n 0
    end

(* Função para calcular potência usando a função built-in *)
fun potencia (base, exp) = 
    Real.round (Math.pow (Real.fromInt base, Real.fromInt exp))

(* Função para gerar lista de números de 2 até n *)
fun range start stop =
    if start > stop then []
    else start :: range (start + 1) stop

(* Função para encontrar números digit-power *)
fun encontrarDigitPower () =
    let
        fun buscarCandidatos somaDeDigitos potencia acc =
            if somaDeDigitos > 199 then acc
            else if potencia > 29 then buscarCandidatos (somaDeDigitos + 1) 2 acc
            else
                let
                    val candidato = potencia (somaDeDigitos, potencia)
                in
                    if candidato < 10 then
                        buscarCandidatos somaDeDigitos (potencia + 1) acc
                    else if candidato > 1000000000000000 then (* 10^15 *)
                        buscarCandidatos (somaDeDigitos + 1) 2 acc
                    else if somaDigitos candidato = somaDeDigitos then
                        buscarCandidatos somaDeDigitos (potencia + 1) (candidato :: acc)
                    else
                        buscarCandidatos somaDeDigitos (potencia + 1) acc
                end
    in
        buscarCandidatos 2 2 []
    end

(* Função para ordenar lista *)
fun quicksort [] = []
  | quicksort (x::xs) =
    let
        val menores = List.filter (fn y => y < x) xs
        val maiores = List.filter (fn y => y >= x) xs
    in
        quicksort menores @ [x] @ quicksort maiores
    end

(* Função para encontrar a potência que gera o número *)
fun encontrarPotencia num somaDeDigitos =
    let
        fun tentarPotencia pot =
            if pot > 49 then ~1 (* Não encontrou *)
            else if potencia somaDeDigitos pot = num then pot
            else tentarPotencia (pot + 1)
    in
        tentarPotencia 2
    end

(* Função para pegar o n-ésimo elemento de uma lista *)
fun nth [] _ = NONE
  | nth (x::xs) 0 = SOME x
  | nth (x::xs) n = nth xs (n - 1)

(* Versão mais concisa usando List.tabulate e List.filter *)
fun encontrarDigitPowerConciso () =
    let
        val candidatos = 
            List.concat (
                List.tabulate (198, fn somaIdx =>
                    let val somaDeDigitos = somaIdx + 2 in
                        List.tabulate (28, fn potIdx =>
                            let 
                                val pot = potIdx + 2
                                val candidato = potencia (somaDeDigitos, pot)
                            in
                                if candidato >= 10 andalso 
                                   candidato <= 1000000000000000 andalso
                                   somaDigitos candidato = somaDeDigitos
                                then SOME candidato
                                else NONE
                            end)
                    end)
            )
        
        val numerosValidos = List.mapPartial (fn x => x) (List.concat candidatos)
        val numerosOrdenados = quicksort numerosValidos
    in
        case List.nth (numerosOrdenados, 29) of
            SOME num => print ("a_30 = " ^ Int.toString num ^ "\n")
          | NONE => print "Não foi possível encontrar a_30\n"
    end
