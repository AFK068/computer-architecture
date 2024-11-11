.include "macrolib.asm"

.globl	new_line

.data
	start_information: 	.asciz "Welcome. This work is done by Gobets Ivan group BPI-237. Option - 13"	
	new_line:		.asciz "\n"

.text
main:
	print_string(start_information)			# Выводим стартовую информацию
	print_string(new_line)				# Выводим новую строку
	
	# t3
	jal		request_for_test		# Запрашиваем у пользователя значение для автотестов
	beqz		t3, 	tests
	
	# t0
	jal		get_x				# Запрашиваем у пользователя значение x
	fcvt.d.w	ft0, 	t0			# Конвертим int в double
	
	# t0 - значение x
	jal		check_minus			# Делаем джамп в подпрограмму определения знака
	
	end_program()