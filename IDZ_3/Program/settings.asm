.globl	get_settings
.include "macro-syscalls.m"

.eqv 	SETTINGS_SIZE 16	# Размер буфера для конфигурации работы приложения

get_settings:
	get_settings_autotest:
		print_str("Autotest the program (Y/N): ")
		str_get(settings, SETTINGS_SIZE)
		
		la	a0	settings
		lbu	a1	(a0)
		li	a2	'Y'
		
		accept_if(s7, a1, a2)	
	
	get_settings_output:
		print_str("Output results to console (Y/N): ")
		str_get(settings, SETTINGS_SIZE)
		
		la	a0	settings
		lbu	a1	(a0)
		li	a2	'Y'
		
		accept_if(s8, a1, a2)
	
	ret

back:
	ret


