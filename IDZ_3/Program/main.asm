.globl	main file_name er_name_mes er_read_mes settings

.include "macro-syscalls.m"

.eqv    TEXT_SIZE 512		# Размер буфера для текста
.eqv    NAME_SIZE 256		# Размер буфера для имени файла
.eqv 	SETTINGS_SIZE 16	# Размер буфера для конфигурации работы приложения

.data
# Buffers
string_buf:	.space	TEXT_SIZE

file_name:	.space	NAME_SIZE
settings:	.space 	SETTINGS_SIZE

# Strings
er_name_mes:    .asciz "An error occurred - the file name is incorrect\n"
er_read_mes:	.asciz "An error occurred during the read operation\n"

.text
main:
	# return s7, s8 - flags
	jal	get_settings
	jal	state_machine
	
	exit()
	
state_machine:
	push(ra)
	bne	s7	zero	autotest
	
	read_data:
		print_str("Enter the path to the file: ")
		str_get(file_name, NAME_SIZE)
		jal	read_file
	
	refactor_data:
		jal	string_refactor
		
	output_data:
		jal	output
		print_str("\n")
		
	save_data:
		print_str("Enter name of file: ")
		str_get(file_name, NAME_SIZE)
		jal 	save_in_file

	return:
		pop(ra)
		ret
		
		
  
