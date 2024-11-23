.eqv	SIZE 100
.data
	first_buffer:		.space	SIZE
	second_buffer: 		.space 	SIZE 


	double_new_line:	.asciz	"\n\n"
	new_line:		.asciz	"\n"
	
	empty_test_str: 	.asciz ""   			# Пустая тестовая строка
	short_test_str: 	.asciz "Hello!"     		# Короткая тестовая строка
	long_test_str:  	.asciz "I am long for BUF_SIZE" # Длинная тестовая строка
	
	string: 		.asciz "String: "
	copy_string:		.asciz "Copy string: "

# Макрос для вывода строки
.macro print_string(%x)			# Определение макроса print_string, принимающего метку %x (адрес строки).
	la, a0, %x			# Загружаем адрес строки (метки) %x в регистр a0.
	li, a7, 4			# Загружаем код системного вызова 4 (print_string) в регистр a7 для вывода строки.
	ecall				# Выполняем системный вызов.				# Выполняем системный вызов.
.end_macro

# Макрос для завершения программы
.macro end_program			# Определение макроса end_program без параметров.
	li, a7, 10			# Загружаем код системного вызова 10 (exit) в регистр a7 для завершения программы.
	ecall				# Выполняем системный вызов.
.end_macro

# Макрос для копирования строки
.macro strncpy(%str1, %str2)
	la 	a0	%str1
	la	a1	%str2
	jal	strncpy_loop
.end_macro

# Макрос для считывания строки
.macro read_string(%str1, %bufsize)
	la	a0	%str1
	li	a1	%bufsize
	li	a7	8
	ecall
.end_macro

.text
main:
	# Heandle input
	print_string(string)
	read_string(first_buffer, SIZE)
	
	print_string(copy_string)
	
	strncpy(first_buffer, second_buffer)
	print_string(first_buffer)
	print_string(new_line)
	

	######## Auto tests

	print_string(string)
	print_string(empty_test_str)
	
	print_string(new_line)
	print_string(copy_string)
	
	strncpy(empty_test_str, first_buffer)
	print_string(first_buffer)
	print_string(double_new_line)
	
	########
	
	print_string(string)
	print_string(short_test_str)
	
	print_string(new_line)
	print_string(copy_string)
	
	strncpy(short_test_str, first_buffer)
	print_string(first_buffer)
	print_string(double_new_line)
	
	########
	
	print_string(string)
	print_string(long_test_str)
	
	print_string(new_line)
	print_string(copy_string)
	
	strncpy(long_test_str, first_buffer)
	print_string(first_buffer)
	print_string(double_new_line)
	
	end_program()