.data
	n: 	.asciz 	"Max n before overflow: "
	ln: 	.asciz 	"\n"
	
	
.text	
	main:
		li	t0, 1 			# факториал
		li	t1, 1			# n
		li 	t2, 0			# прерыдущее значение для "отлавливания" переполнения
		
		la	a0, n			# выводим строку "Max n before overflow: "
		li 	a7, 4
		ecall
		
		jal	factorial		# считаем факториал
		
		li 	a7, 1			# выводим полученное значение (ничего не перемещаем, потому что значение уже лежит в a0)
		ecall
		
		j	end_program		# завершаем программу
	
	factorial:	
		mv	t2, t0
		
		addi	t1, t1, 1
		mul	t0, t0, t1
		
		div 	t6, t0, t1		# чтобы проверить переполнение умножения будем:
		beq	t6, t2, factorial	# делить полученный результат при умножении на n и сверять с предыдущим шагом
		
		addi 	t1, t1, -1		
		mv 	a0, t1	
	 	ret	
	
	end_program:
		li	a7, 10
		ecall