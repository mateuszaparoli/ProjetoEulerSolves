def sum_of_digits(n):
    return sum(int(digit) for digit in str(n))

digit_power_numbers = []

for digit_sum in range(2, 200):
    for power in range(2, 30):
        candidate = digit_sum ** power
        
        if candidate < 10:
            continue
        
        if candidate > 10**15:
            break
            
        if sum_of_digits(candidate) == digit_sum:
            digit_power_numbers.append(candidate)

digit_power_numbers.sort()

for i, num in enumerate(digit_power_numbers, 1):
    digit_sum = sum_of_digits(num)
    power = 2
    while digit_sum ** power != num and power < 50:
        power += 1
    
    if i == 30:
        print(f"a_30 = {num}")
        break