.include "macrolib.asm"
.globl A_array, B_array
.globl new_line, print_space

.data
	A_array: 				.space 40		# Выделяем 40 байт под массив A 
	B_array: 				.space 40		# Выделяем 40 байт под массив B 
	n:	 				.word	0 		# Переменная для хранения количества элементов массива
	
	start_information: 			.asciz "Welcome. This work is done by Gobets Ivan group BPI-237. Option - 21"
	new_line:				.asciz "\n"
	print_space:				.asciz " "
	
.text
main:
	print_string(start_information)
	print_string(new_line)
	
	la	t0, 	n						# Загружаем адресс на n в t0
	la 	t1, 	A_array       			 		# Загружаем адрес массива A в t1

	# Регистр a0: используется для хранения ввода пользователя (get_and_save_n)
	# Регистр t3: хранит корректное значение n
	jal  	get_and_save_n				 		# Сохраняем введенное количество элементов в переменной n
	
									
	mv	t4,	t3						# Скопирию n в t4, чтобы во время заполнения не изменять исходное значение n
	# Регистр t1: адрес массива A
   	# Регистр t4: количество элементов n
	jal 	fill_A_array						# "Заполняю массив" элементами, введеными пользователем
	
	mv	t4,	t3						# Скопирию n в t4, чтобы во время сортировки не изменять исходное значение n
	la 	t2, 	B_array       			 		# Загружаем адрес массива A в t2
	
	# Регистр t1: адрес массива A
   	# Регистр t2: адрес массива B
    	# Регистр t3: количество элементов n
	jal     sort_A_array_and_save_in_B
    	
    	# Завершаем программу
	end_program	
