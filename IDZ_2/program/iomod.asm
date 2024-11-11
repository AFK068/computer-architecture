.include "macrolib.asm"
.globl 	request_for_test, get_x
	
.data
	tested_cases:		.asciz "Enter 0 if you want to run automatic tests, 1 for manual input: "
	get_x_string: 		.asciz "Enter value of x: " 

.text 
request_for_test:
	print_string(tested_cases)			# Выводим строку для запроса автотестов
	read_int(t3)					# В t1 запрашиваем для автотестов
	
	ret
get_x:
	print_string(get_x_string)			# Выводим строку для запроса x
	read_int(t0)					# Запрашиваем у пользователя значение 
	
	ret