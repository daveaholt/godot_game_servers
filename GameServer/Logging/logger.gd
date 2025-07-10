extends Node

var GlobalLoggingLevel = logLevels.ERROR

enum logLevels {
	DEBUG, #Diagnostic information. Not expected to be printed for normal run
	ERROR, #Somthing done broke, but we soldered on.
	FATAL, #Game over man!... Game over.
	INFO #Informational, normal behavior
}

var _loglevelNameLookup = {
	0: "DEBUG",
	1: "ERROR",
	2: "FATAL",
	3: "INFO"
}

func LogDebug(message: String):
	Log(message, logLevels.DEBUG)

func LogError(message: String):
	Log(message, logLevels.ERROR)

func LogFatal(message: String):
	Log(message, logLevels.FATAL)
	
func LogInfo(message: String):
	Log(message, logLevels.INFO)	

func Log(message: String, loglevel: logLevels = 1):
	var t = Thread.new()
	t.start(_log.bind(message, loglevel), t.PRIORITY_NORMAL)
	t.wait_to_finish()
		
func _log(message: String, loglevel: logLevels):
	if(GlobalLoggingLevel > loglevel):
		return
	
	var date_time = Time.get_datetime_string_from_system()
	var msg = "%s | %s | %s" %[_loglevelNameLookup[loglevel], date_time, message]
	print(msg)

	
