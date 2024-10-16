.data
	array:	.space 48
	n:	.word 0
	
	ln:     .asciz "\n"
	
	get_n: .asciz "n = "
	len_less_0: .asciz "incorrect len array"
	overflow: .asciz "warning: overflow"
	summ: .asciz "Summ: "
	
	last_summ: "Last correct amount value: "
	count_summ_elements: "Number of summed elements: "
	
	count_even: "Number of even: "
	count_odd: "Number of odd: "
.text
	main:
		la 	a0, get_n
		li, 	a7, 4
		ecall
		
		li 	a7, 5			# Получаем n
		ecall
		
		mv	t3, a0
		la	t4 n			# Адрес n в t4
		sw	t3 (t4)			# Загрузка n в память на хранение
		

		jal	check_len_array		# Проверяем корректность длины массива
		
		la      t0, array        	# Указатель элемента массива	
		
	fill_array: # "Заполняем массив" элементами	
		li	a7, 5
		ecall
		
		jal 	summ_even_odd
		
		sw	a0 (t0) 		# Запись числа по адресу в t0
		addi 	t0 t0 4			# Увеличим адрес на размер слова в байтах
		addi    t3 t3 -1		# Уменьшим количество оставшихся элементов на 1
		bnez    t3 fill_array		# Если осталось больше 0 запускаем повторно
		
		j	reset
	
	reset:
		li 	t5, 0 			# Последнее корректное значение, если произошло переполнение
		li	t6, 0			# Сумма всех элементов
		li	a5, 0 			# Количество просуммированных
		lw	t1 n			# Количество элементов "массива"
		la      t0 array
		
		j sum_loop
		
	sum_loop:
		lw	t2, (t0)
		add     t6, t6, t2
		
		#Что-то не получилось через xor(
		#xor	t4, t6, t2			# Проверяем переполнение через смену знаков
		#xor	t1, t6, t2			# 
		#and	t4, t4, t1			#
		#bnez	t4, print_answer_overflow	# Если произошло переполнение выводим ответ
		
		blt	t3, zero, check_overflow_for_minus
		blt	t2, zero, no_overflow_check
		blt	t6, zero, print_answer_overflow		
		j 	no_overflow_check
	
		
	check_overflow_for_minus:
		bgt	t6, zero, print_answer_overflow
		
	no_overflow_check:
		mv	t5, t6			
		addi	t0, t0, 4		
		addi	a5, a5, 1		
		addi    t1, t1, -1		
        	bnez    t1, sum_loop		

        	j 	print_answer	
		
	print_answer:
		la 	a0, summ
		li, 	a7, 4
		ecall
		
		mv 	a0, t6
		li 	a7, 1
		ecall
		
		la 	a0, ln
		li	a7, 4
		ecall
		
		jal	print_even_odd
		
		j 	end_program
		
	
	print_answer_overflow:
		la 	a0, overflow
		li, 	a7, 4
		ecall
		
		la 	a0, ln
		li	a7, 4
		ecall
		
		la 	a0, last_summ
		li      a7, 4
		ecall
		
		mv	a0, t5
		li	a7, 1
		ecall
		
		la	a0, ln
		li 	a7, 4
		ecall 
	
	
		la 	a0, count_summ_elements
		li 	a7, 4
		ecall
		
		mv 	a0, a5
		li 	a7, 1
		ecall
		
		la 	a0, ln
		li	a7, 4
		ecall
		
		jal	print_even_odd
		
		j	end_program
		
	check_len_array:
		ble	t3, zero, end_program_incorrect_len_array
		
		li 	t2, 10
		bgt	t3, t2, end_program_incorrect_len_array
		
		li 	t2, 0
		
		jalr	ra
		
	print_even_odd:
		la 	a0, count_even
		li	a7, 4
		ecall
		
		mv	a0, a3
		li	a7, 1
		ecall
		
		la 	a0, ln
		li 	a7, 4
		ecall
		
		la 	a0, count_odd
		li	a7, 4
		ecall
		
		mv	a0, a4
		li 	a7, 1
		ecall
		
		jalr 	ra
		
	summ_even_odd:
		li	a6, 2
		rem     t2, a0, a6   
		
		beqz 	t2, plus_even
    		bnez 	t2, plus_odd
    		
    	plus_odd:
    		addi 	a4, a4, 1
    		jalr 	ra
    				
    	plus_even:
    		addi 	a3, a3, 1
		jalr	ra
  	
  	end_program_incorrect_len_array:
		la	a0, len_less_0
		li	a7, 4
		ecall
		
		j 	end_program
		   				
	end_program:
		li	a7, 10
		ecall
		   
		

	
