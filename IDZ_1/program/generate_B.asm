.include "macrolib.asm"

.globl fill_A_array, sort_A_array_and_save_in_B
	
.data
	print_get_number_for_fill_array: 	.asciz "Enter an integer: "
	print_sorted_B_array:			.asciz "Sorted B array: "
	min_index:      			.word   0      		# Хранение индекса минимального элемента
.text
	fill_A_array:
		print_string(print_get_number_for_fill_array)
		read_int(a0)
			
		sw	a0 (t1) 					# Запись числа по адресу в t0
		addi 	t1 t1 4						# Увеличим адрес на размер слова в байтах
		addi    t4 t4 -1					# Уменьшим количество оставшихся элементов на 1
		bnez    t4 fill_A_array					# Если осталось больше 0 запускаем повторно
	 		
	 	la 	t1, A_array					# После действий с адрессами, вернем адресс массива A в исходное положение
	 	jalr 	ra						# Возвращаемся по адрессу
	 		
	sort_A_array_and_save_in_B:
		li 	a3, 2147483647					# Инициализируем минимальное значение как MAX_INT
		la 	a5, min_index					# Адрес для хранения индекса минимума
		li 	a4, 0          					# Текущий индекс элемента
				
		find_min_element:					
			lw 	t6, (t1)				# "Выгружаем" элемент с "массива"	
			bge	t6, a3, next_element			# Если текущий элемент больше максимального переходим к next_element
			mv	a3, t6					# Если элемент меньше, то обновляем минимум
			sw	a4, (a5)				# Записываем текущий индекс элемента по адресу
			
		next_element:
			addi	t1, t1, 4				# Переход к следующему элементу массива
			addi 	a4, a4, 1				# Увеличение индекса
			blt 	a4, t3, find_min_element		# Если не все элементы проверены, продолжаем
		
		write_min_to_B:
			sw 	a3, (t2)				# Запись минимума в массив B
			addi 	t2, t2, 4				# Переход к следующей позиции в B
				
			la	t1, A_array 				# Восстановление адреса начала массива A
			lw	a2, (a5)				# Чтение индекса минимального элемента
			slli 	a2, a2, 2				# Умножение индекса на 4 (размер слова)
			add 	t1, t1, a2				# Получение адреса минимального элемента
			li	a0, 2147483647				# 2^32 - 1
			sw	a0, (t1)				# Замена минимального элемента на MAX_INT
				
			la	t1, A_array 				# Восстановление адреса начала массива A
			addi 	t4, t4, -1				# Уменьшение счетчика оставшихся элементов
			bnez 	t4, sort_A_array_and_save_in_B		# Если элементы остались, повторяем сортировку
				
			la	t2, B_array				# Возвращаю адресс в t2, так как мы его изменяли во время заполнения массива B
			print_string(print_sorted_B_array)		# Выводим строку: 
			print_array(t2, t3)				# Использую макрос для вывода элементоа массива (t2 - адресс, t3 - кол-во элементов в массиве)
			jalr	ra					# Возвращаемся в main
