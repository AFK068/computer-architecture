.include "macrolib.asm"
.globl tests

.data
	tested_A_array:				.asciz 			"Tested array: "
	SingleElementArray: 			.word 7                	# Массив с одним элементом
	IdenticalElementsArray: 		.word 3, 3, 3, 3, 3 	# Массив с одинаковыми элементами
        MixedElementsArray: 			.word 3, 7, 3, 2, 9     # Массив с одинаковыми и разными элементами
    	AlreadySortedArray: 			.word 1, 2, 3, 4, 5     # Уже отсортированный массив
    	ReverseOrderArray: 			.word 9, 8, 7, 6, 5     # Массив в обратном порядке
    	NegativeElementsArray: 			.word -5, -9, -1, -3, -10 # Массив с отрицательными элементами
    	MixedPositiveNegativeArray: 		.word -3, 5, -7, 2, 0 	# Массив с положительными и отрицательными элементами
    	
.text
	tests:								# Тестовые случаи сортировки разных массивов
		test_1:							# Тест на массиве с одним элементом
			la t1, SingleElementArray 			# Загрузить адрес массива с одним элементом в t1
   			li t4, 1					# Установить длину массива
   			# t1 - adress array, t4 - len
    			jal copy_array_to_A_array			# Вызов подпрограммы для копирования массива в A_array
    		
    			la t1, SingleElementArray 			# Снова загрузить адрес массива в t1 (для вывода)
    			li t4, 1					# Заново устанавливаем длину массива (t4), так как мы ее изменяли во время копирования
    			li t3, 1					# Заново устанавливаем длину массива (t4), так как мы ее изменяли во время копирования
    		
    			# t1 - adress array, t4, t3 - len
    			jal run_test_case				# Запуск теста с этим массивом
    			
    		test_2:							# Массив с одинаковыми элементами
			la t1, IdenticalElementsArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, IdenticalElementsArray 
	    		li t4, 5
	    		li t3, 5
	    		
	    		# t1 -adress array, t4, t3 - len
	    		jal run_test_case
	    		
	    	test_3:							# Массив с одинаковыми и разными элементами
	  		la t1, MixedElementsArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, MixedElementsArray 
	    		li t4, 5
	    		li t3, 5
	    		
    			# t1 - adress array, t4, t3 - len	    		
	    		jal run_test_case
	    		
	    	test_4:							# Массив с одинаковыми и разными элементами
	  		la t1, AlreadySortedArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, AlreadySortedArray 
	    		li t4, 5
	    		li t3, 5
	    		
    			# t1 - adress array, t4, t3 - len	    		
	    		jal run_test_case
	    		
	    	test_5:							# Уже отсортированный массив
	   		la t1, ReverseOrderArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, ReverseOrderArray 
	    		li t4, 5
	    		li t3, 5
	    		
    			# t1 - adress array, t4, t3 - len	    		
	    		jal run_test_case
	    		
	    	test_6:							# Массив в обратном порядке
	   		la t1, NegativeElementsArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, NegativeElementsArray 
	    		li t4, 5
	    		li t3, 5
	    		
    			# t1 - adress array, t4, t3 - len	    		
	    		jal run_test_case
	    			
	    	test_7:							# Массив с положительными и отрицательными элементами
			la t1, MixedPositiveNegativeArray 
	   		li t4, 5
	   		# t1 - adress array, t4 - len
	    		jal copy_array_to_A_array
	    		
	    		la t1, MixedPositiveNegativeArray 
	    		li t4, 5
	    		li t3, 5
	    		
    			# t1 - adress array, t4, t3 - len	    		
	    		jal run_test_case
    		
    		end_program()
			
	copy_array_to_A_array:						# Подпрограмма для копирования массива в A_array
		la t2, A_array           				# Загрузить адрес A_array в t2
				
		copy_loop:
			beqz t4, end_copy				# Если длина массива (t4) равна 0, выйти из цикла
			lw t6, (t1)					# Загрузить текущий элемент из исходного массива в t6
			sw t6, (t2)					# Сохранить элемент в A_array
			addi t1, t1, 4					# Перейти к следующему элементу в исходном массиве
			addi t2, t2, 4					# Перейти к следующему элементу в A_array
			addi t4, t4, -1 				# Уменьшить счетчик длины массива
			j copy_loop					# Повторить цикл
		end_copy:
			ret						# Возврат из подпрограммы
	
	run_test_case:							# Подпрограмма для выполнения теста
		print_string(new_line)					# Печать новой строки для разделения выводов
		print_string(new_line)					# Печать новой строки для разделения выводов
		
		la t2, B_array						# Загрузить адрес массива B_array
		
		print_string(tested_A_array)				# Вывести текст "Tested array: "
		print_array(t1, t3)					# Вывести содержимое тестируемого массива
		print_string(new_line)  				# Печать новой строки
		    
		j sort_A_array_and_save_in_B				# Вызов сортировки массива A и сохранения результата в B_array