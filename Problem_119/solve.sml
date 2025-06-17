fun somaDigitosIntInf n =
    let
        fun aux n acc = 
            if IntInf.compare (n, IntInf.fromInt 0) = EQUAL then acc
            else aux (IntInf.div (n, IntInf.fromInt 10)) 
                     (IntInf.+ (acc, IntInf.mod (n, IntInf.fromInt 10)))
    in
        aux n (IntInf.fromInt 0)
    end

fun powIntInf (base, 0) = IntInf.fromInt 1
  | powIntInf (base, exp) = IntInf.* (IntInf.fromInt base, powIntInf (base, exp - 1))

val numeroDigitPower : IntInf.int list ref = ref []

fun loopSomaDeDigitos somaDeDigitos =
    let
        fun loopPotencia potencia =
            if potencia > 50 then ()
            else
            let
                val candidato = powIntInf (somaDeDigitos, potencia)
                val dezIntInf = IntInf.fromInt 10
            in
                if IntInf.< (candidato, dezIntInf) then
                    loopPotencia (potencia + 1)
                else
                    (if IntInf.compare (somaDigitosIntInf candidato, IntInf.fromInt somaDeDigitos) = EQUAL then
                        numeroDigitPower := candidato :: (!numeroDigitPower)
                     else ();
                     loopPotencia (potencia + 1))
            end
    in
        loopPotencia 1
    end

val _ = List.app loopSomaDeDigitos (List.tabulate (200, fn i => i + 1))

fun quickSort [] = []
  | quickSort (x::xs) =
    let
        val menores = List.filter (fn y => IntInf.< (y, x)) xs
        val maiores = List.filter (fn y => IntInf.>= (y, x)) xs
    in
        quickSort menores @ [x] @ quickSort maiores
    end

val numeroDigitPowerSorted = quickSort (!numeroDigitPower)

fun imprimirElemento ([], indiceAtual, indiceDesejado) = ()
  | imprimirElemento (x::xs, indiceAtual, indiceDesejado) =
        if indiceAtual = indiceDesejado then
            print ("a_30 = " ^ IntInf.toString x ^ "\n")
        else
            imprimirElemento (xs, indiceAtual + 1, indiceDesejado)

val _ = imprimirElemento (numeroDigitPowerSorted, 1, 30)