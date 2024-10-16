.data    
    arg01:  .asciz "Input 1st number: "
    arg02:  .asciz "Input 2nd number: "
    ln:     .asciz "\n"
    error_div_by_0:  .asciz "You cant divine by 0"
    integer: .asciz "Integer: "
    remainder: .asciz "Remainder of division: "

.text
	main:
		la a0, arg01
		li a7, 4
		ecall
	
		li a7, 5
		ecall
		mv t1, a0
	
		la a0, arg02
		li a7, 4
		ecall
	
		li a7, 5
		ecall
		mv t2, a0
	
	if_div_by_0:
		beqz t2, finish_div_by_0
		
	disbandment:
		bgez, t1, if_first_number_plus
		bltz, t1, if_first_number_minus
		
	if_first_number_plus:
		blt t2, zero, if_second_minus
		
		if_second_plus:
			loop_plus_plus:
				blt t1, t2, print_answer
				addi t3, t3, 1
				sub t1, t1, t2
				j loop_plus_plus
				
		
		if_second_minus:
			loop_plus_minus:
				add t1, t1, t2
				bltz t1, end_plus_minus
				addi t3, t3, -1
				j loop_plus_minus
				
			end_plus_minus:
				sub t1, t1, t2
				j print_answer
			
	if_first_number_minus:
		ble t2, zero, if_second_minus_2
		
		if_second_plus_2:
			loop_minus_plus:
				add t1, t1, t2
				bgtz t1, end_minus_plus
				addi t3, t3, -1
				j loop_minus_plus
			end_minus_plus:
				sub t1, t1, t2
				j print_answer
			
		
		if_second_minus_2:
			loop_minus_minus:
				sub t1, t1, t2
				bgtz t1, end_minus_minus
				addi t3, t3, 1
				j loop_minus_minus
	
			end_minus_minus:
				add t1, t1, t2
				j print_answer
	
	
	finish_div_by_0:
		la a0, error_div_by_0
		li a7, 4
		ecall
		
		li a7, 10
		ecall
	
	
	print_answer:
		la a0, integer # Выаодим "Input 1st number"
		li a7, 4
		ecall
		
		mv a0, t3 # Перемещаем t3 а0 и выводим релутаа
		li a7, 1
		ecall
		
		la a0, ln # Выводим переход строки
		li a7, 4
		ecall
		
		la a0, remainder # Выводим "Input 2nd number"
		li a7, 4
		ecall
		
		mv a0, t1  # Выводим рультат
		li a7, 1
		ecall
		
		li a7, 10 # Звершаем программу
		ecall
		
	
	
	
