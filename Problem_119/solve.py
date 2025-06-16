def somaDigitos(n):
    return sum(int(digito) for digito in str(n))

numeroDigitPower = []

for somaDeDigitos in range(2, 200):
    for potencia in range(2, 30):
        candidato = somaDeDigitos ** potencia
        
        if candidato < 10:
            continue
        
        if candidato > 10**15:
            break
            
        if somaDigitos(candidato) == somaDeDigitos:
            numeroDigitPower.append(candidato)

numeroDigitPower.sort()

for i, num in enumerate(numeroDigitPower, 1):
    somaDeDigitos = somaDigitos(num)
    potencia = 2
    while somaDeDigitos ** potencia != num and potencia < 50:
        potencia += 1
    
    if i == 30:
        print(f"a_30 = {num}")
        break