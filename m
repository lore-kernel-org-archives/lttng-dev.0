From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust] JUL: use root logger to
	capture events
Date: Thu, 26 Jun 2014 19:03:42 +0000 (UTC)
Message-ID: <140630844.5091.1403809422219.JavaMail.zimbra__35393.1795260452$1403809500$gmane$org@efficios.com>
References: <1403114904-25164-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X0ExY-0001SL-0J
 for lttng-dev@lists.lttng.org; Thu, 26 Jun 2014 15:03:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EDCFF340222
 for <lttng-dev@lists.lttng.org>; Thu, 26 Jun 2014 19:03:47 +0000 (UTC)
In-Reply-To: <1403114904-25164-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Great simplification to the code !!

Merged into stable-2.4 and master, thanks!

Mathieu

----- Original Message -----
> From: "David Goulet" <dgoulet@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "David Goulet" <dgoulet@efficios.com>
> Sent: Wednesday, June 18, 2014 2:08:24 PM
> Subject: [PATCH v2 lttng-ust] JUL: use root logger to capture events
> 
> The JUL agent now uses the root logger ("") to capture all events. This
> allows us to remove the Timer thread and cleanup a huge portion of the
> code base. It simplifies a great deal the internal structure of the
> agent since we don't have to monitor the Logger object anymore.
> 
> Since tracepoint filtering is done in UST, we just the LTTng handler to
> the root logger and send everything to UST.
> 
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  .../org/lttng/ust/jul/LTTngLogHandler.java         |  98 +------------
>  .../org/lttng/ust/jul/LTTngSessiondCmd2_4.java     | 162
>  ++++++---------------
>  .../org/lttng/ust/jul/LTTngTCPSessiondClient.java  | 114 +--------------
>  3 files changed, 49 insertions(+), 325 deletions(-)
> 
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> index 8c79512..4c617fb 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> @@ -29,40 +29,16 @@ import java.util.Map;
>  
>  import org.lttng.ust.jul.LTTngUst;
>  
> -class LTTngLogger {
> -	/*
> -	 * The log handler is attached to the logger when the reference count is
> -	 * nonzero. Each event referring to a logger holds a reference to that
> -	 * logger. If down to 0, this object is removed from the handler.
> -	 */
> -	public int refcount;
> -	public String name;
> -	Logger logger;
> -
> -	public LTTngLogger(String name, Logger logger) {
> -		this.name = name;
> -		this.refcount = 0;
> -		this.logger = logger;
> -	}
> -
> -	public void attach(LTTngLogHandler handler) {
> -		this.logger.addHandler(handler);
> -	}
> -
> -	public void detach(LTTngLogHandler handler) {
> -		this.logger.removeHandler(handler);
> -	}
> -}
> -
>  public class LTTngLogHandler extends Handler {
>  	/* Am I a root Log Handler. */
>  	public int is_root = 0;
> +	public int refcount = 0;
>  
>  	public LogManager logManager;
>  
>  	/* Logger object attached to this handler that can trigger a tracepoint. */
> -	private Map<String, LTTngLogger> loggerMap =
> -		Collections.synchronizedMap(new HashMap<String, LTTngLogger>());
> +	public Map<String, LTTngEvent> enabledEvents =
> +		Collections.synchronizedMap(new HashMap<String, LTTngEvent>());
>  
>  	/* Constructor */
>  	public LTTngLogHandler(LogManager logManager) {
> @@ -75,68 +51,10 @@ public class LTTngLogHandler extends Handler {
>  	}
>  
>  	/*
> -	 * Return true if the logger is enabled and attached. Else, if not found,
> -	 * return false.
> -	 */
> -	public boolean exists(String name) {
> -		if (loggerMap.get(name) != null) {
> -			return true;
> -		} else {
> -			return false;
> -		}
> -	}
> -
> -	/*
> -	 * Attach an event to this handler. If no logger object exists, one is
> -	 * created else the refcount is incremented.
> -	 */
> -	public void attachEvent(LTTngEvent event) {
> -		Logger logger;
> -		LTTngLogger lttngLogger;
> -
> -		/* Does the logger actually exist. */
> -		logger = this.logManager.getLogger(event.name);
> -		if (logger == null) {
> -			/* Stop attach right now. */
> -			return;
> -		}
> -
> -		lttngLogger = loggerMap.get(event.name);
> -		if (lttngLogger == null) {
> -			lttngLogger = new LTTngLogger(event.name, logger);
> -
> -			/* Attach the handler to the logger and add is to the map. */
> -			lttngLogger.attach(this);
> -			lttngLogger.refcount = 1;
> -			loggerMap.put(lttngLogger.name, lttngLogger);
> -		} else {
> -			lttngLogger.refcount += 1;
> -		}
> -	}
> -
> -	/*
> -	 * Dettach an event from this handler. If the refcount goes down to 0, the
> -	 * logger object is removed thus not attached anymore.
> -	 */
> -	public void detachEvent(LTTngEvent event) {
> -		LTTngLogger logger;
> -
> -		logger = loggerMap.get(event.name);
> -		if (logger != null) {
> -			logger.refcount -= 1;
> -			if (logger.refcount == 0) {
> -				/* Dettach from handler since no more event is associated. */
> -				logger.detach(this);
> -				loggerMap.remove(logger);
> -			}
> -		}
> -	}
> -
> -	/*
>  	 * Cleanup this handler state meaning put it back to a vanilla state.
>  	 */
>  	public void clear() {
> -		this.loggerMap.clear();
> +		this.enabledEvents.clear();
>  	}
>  
>  	@Override
> @@ -147,14 +65,6 @@ public class LTTngLogHandler extends Handler {
>  
>  	@Override
>  	public void publish(LogRecord record) {
> -		LTTngLogger logger;
> -
> -		logger = loggerMap.get(record.getLoggerName());
> -		if (logger == null) {
> -			/* Ignore and don't fire TP. */
> -			return;
> -		}
> -
>  		/*
>  		 * Specific tracepoing designed for JUL events. The source class of the
>  		 * caller is used for the event name, the raw message is taken, the
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> index 6808326..1a65f13 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> @@ -23,10 +23,7 @@ import java.nio.ByteOrder;
>  import java.lang.Object;
>  import java.util.logging.Logger;
>  import java.util.ArrayList;
> -import java.util.HashMap;
> -import java.util.Map;
>  import java.util.List;
> -import java.util.Set;
>  import java.util.Enumeration;
>  
>  public interface LTTngSessiondCmd2_4 {
> @@ -133,7 +130,7 @@ public interface LTTngSessiondCmd2_4 {
>  			buf.order(ByteOrder.LITTLE_ENDIAN);
>  			lttngLogLevel = buf.getInt();
>  			lttngLogLevelType = buf.getInt();
> -			name = new String(data, data_offset, data.length - data_offset);
> +			name = new String(data, data_offset, data.length - data_offset).trim();
>  		}
>  
>  		@Override
> @@ -152,74 +149,33 @@ public interface LTTngSessiondCmd2_4 {
>  		 * @return Event name as a string if the event is NOT found thus was
>  		 * not enabled.
>  		 */
> -		public void execute(LTTngLogHandler handler,
> -				Map<String, ArrayList<LTTngEvent>> eventMap, Set wildCardSet) {
> -			ArrayList<LTTngEvent> bucket;
> +		public void execute(LTTngLogHandler handler) {
>  			LTTngEvent event;
>  
> -			if (name == null) {
> +			if (this.name == null) {
>  				this.code = lttng_jul_ret_code.CODE_INVALID_CMD;
>  				return;
>  			}
>  
> -			/* Wild card to enable ALL logger. */
> -			if (name.trim().equals("*")) {
> -				String loggerName;
> -				Enumeration loggers = handler.logManager.getLoggerNames();
> -
> -				/* Add event to the wildcard set. */
> -				wildCardSet.add(new LTTngEvent(name.trim(), lttngLogLevel,
> -							lttngLogLevelType));
> -
> -				/*
> -				 * Create an event for each logger found and attach it to the
> -				 * handler.
> -				 */
> -				while (loggers.hasMoreElements()) {
> -					loggerName = loggers.nextElement().toString();
> -					/* Somehow there is always an empty string at the end. */
> -					if (loggerName == "") {
> -						continue;
> -					}
> -
> -					event = new LTTngEvent(loggerName, lttngLogLevel,
> -							lttngLogLevelType);
> -					/* Attach event to Log handler to it can be traced. */
> -					handler.attachEvent(event);
> -
> -					/*
> -					 * The agent timer call this function with eventMap set to
> -					 * null because it already has a reference to an existing
> -					 * event so is should not try to add a new one here.
> -					 */
> -					if (eventMap != null) {
> -						bucket = eventMap.get(loggerName);
> -						if (bucket == null) {
> -							bucket = new ArrayList<LTTngEvent>();
> -							eventMap.put(loggerName, bucket);
> -						}
> -						bucket.add(event);
> -					}
> -				}
> -			} else {
> -				event = new LTTngEvent(name.trim(), lttngLogLevel,
> -						lttngLogLevelType);
> -				/* Attach event to Log handler to it can be traced. */
> -				handler.attachEvent(event);
> -
> -				/*
> -				 * The agent timer call this function with eventMap set to
> -				 * null because it already has a reference to an existing
> -				 * event so is should not try to add a new one here.
> -				 */
> -				if (eventMap != null) {
> -					bucket = eventMap.get(name.trim());
> -					if (bucket == null) {
> -						bucket = new ArrayList<LTTngEvent>();
> -						eventMap.put(name.trim(), bucket);
> -					}
> -					bucket.add(event);
> -				}
> +			/* Add event to the enabled events hash map. */
> +			event = handler.enabledEvents.put(this.name,
> +					new LTTngEvent(this.name, 0, 0));
> +			if (event != null) {
> +				/* The event exists so skip updating the refcount. */
> +				this.code = lttng_jul_ret_code.CODE_SUCCESS_CMD;
> +				return;
> +			}
> +
> +			/*
> +			 * Get the root logger and attach to it if it's the first enable
> +			 * seen by the handler.
> +			 */
> +			Logger rootLogger = handler.logManager.getLogger("");
> +
> +			handler.refcount++;
> +			if (handler.refcount == 1) {
> +				/* Add handler only if it's the first enable. */
> +				rootLogger.addHandler(handler);
>  			}
>  
>  			this.code = lttng_jul_ret_code.CODE_SUCCESS_CMD;
> @@ -238,13 +194,9 @@ public interface LTTngSessiondCmd2_4 {
>  
>  		@Override
>  		public void populate(byte[] data) {
> -			int data_offset = INT_SIZE * 2;
> -
>  			ByteBuffer buf = ByteBuffer.wrap(data);
>  			buf.order(ByteOrder.LITTLE_ENDIAN);
> -			lttngLogLevel = buf.getInt();
> -			lttngLogLevelType = buf.getInt();
> -			name = new String(data, data_offset, data.length - data_offset);
> +			name = new String(data).trim();
>  		}
>  
>  		@Override
> @@ -260,62 +212,34 @@ public interface LTTngSessiondCmd2_4 {
>  		 * Execute disable handler action which is to disable the given handler
>  		 * to the received name.
>  		 */
> -		public void execute(LTTngLogHandler handler,
> -				Map<String, ArrayList<LTTngEvent>> eventMap, Set wildCardSet) {
> -			ArrayList<LTTngEvent> bucket;
> +		public void execute(LTTngLogHandler handler) {
>  			LTTngEvent event;
>  
> -			if (name == null) {
> +			if (this.name == null) {
>  				this.code = lttng_jul_ret_code.CODE_INVALID_CMD;
>  				return;
>  			}
>  
> -			/* Wild card to disable ALL logger. */
> -			if (name.trim().equals("*")) {
> -				String loggerName;
> -				Enumeration loggers = handler.logManager.getLoggerNames();
> -
> -				/* Remove event from the wildcard set. */
> -				wildCardSet.remove(new LTTngEvent(name.trim(), lttngLogLevel,
> -							lttngLogLevelType));
> -
> -				while (loggers.hasMoreElements()) {
> -					loggerName = loggers.nextElement().toString();
> -					/* Somehow there is always an empty string at the end. */
> -					if (loggerName == "") {
> -						continue;
> -					}
> -
> -					event = new LTTngEvent(loggerName, lttngLogLevel,
> -							lttngLogLevelType);
> -
> -					bucket = eventMap.get(loggerName);
> -					if (bucket != null) {
> -						handler.detachEvent(event);
> -						bucket.remove(event);
> -						if (bucket.isEmpty() == true) {
> -							eventMap.remove(bucket);
> -						}
> -					}
> -				}
> -				this.code = lttng_jul_ret_code.CODE_SUCCESS_CMD;
> -			} else {
> -				event = new LTTngEvent(this.name, lttngLogLevel,
> -						lttngLogLevelType);
> -
> -				bucket = eventMap.get(this.name);
> -				if (bucket != null) {
> -					handler.detachEvent(event);
> -					bucket.remove(event);
> -					if (bucket.isEmpty() == true) {
> -						eventMap.remove(bucket);
> -					}
> -					this.code = lttng_jul_ret_code.CODE_SUCCESS_CMD;
> -				} else {
> -					this.code = lttng_jul_ret_code.CODE_UNK_LOGGER_NAME;
> -				}
> +			/*
> +			 * Try to remove the logger name from the events map and if we
> +			 * can't, just skip the refcount update since the event was never
> +			 * enabled.
> +			 */
> +			event = handler.enabledEvents.remove(this.name);
> +			if (event == null) {
> +				/* The event didn't exists so skip updating the refcount. */
> +				this.code = lttng_jul_ret_code.CODE_INVALID_CMD;
> +				return;
>  			}
>  
> +			Logger rootLogger = handler.logManager.getLogger("");
> +
> +			handler.refcount--;
> +			if (handler.refcount == 0) {
> +				rootLogger.removeHandler(handler);
> +			}
> +
> +			this.code = lttng_jul_ret_code.CODE_SUCCESS_CMD;
>  			return;
>  		}
>  	}
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> index a2d12fc..861c734 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> @@ -31,18 +31,7 @@ import java.io.FileReader;
>  import java.io.FileNotFoundException;
>  import java.net.*;
>  import java.lang.management.ManagementFactory;
> -import java.util.ArrayList;
> -import java.util.HashMap;
> -import java.util.HashSet;
> -import java.util.Map;
> -import java.util.Iterator;
> -import java.util.List;
> -import java.util.Enumeration;
> -import java.util.Set;
> -import java.util.Timer;
> -import java.util.TimerTask;
>  import java.util.logging.Logger;
> -import java.util.Collections;
>  
>  class USTRegisterMsg {
>  	public static int pid;
> @@ -64,23 +53,6 @@ public class LTTngTCPSessiondClient {
>  
>  	private Semaphore registerSem;
>  
> -	private Timer eventTimer;
> -
> -	/*
> -	 * Indexed by event name but can contains duplicates since multiple
> -	 * sessions can enable the same event with or without different loglevels.
> -	 */
> -	private Map<String, ArrayList<LTTngEvent>> eventMap =
> -		Collections.synchronizedMap(
> -				new HashMap<String, ArrayList<LTTngEvent>>());
> -
> -	private Set<LTTngEvent> wildCardSet =
> -		Collections.synchronizedSet(new HashSet<LTTngEvent>());
> -
> -	/* Timer delay at each 5 seconds. */
> -	private final static long timerDelay = 5 * 1000;
> -	private static boolean timerInitialized;
> -
>  	private static final String rootPortFile = "/var/run/lttng/jul.port";
>  	private static final String userPortFile = "/.lttng/jul.port";
>  
> @@ -90,83 +62,6 @@ public class LTTngTCPSessiondClient {
>  	public LTTngTCPSessiondClient(String host, Semaphore sem) {
>  		this.sessiondHost = host;
>  		this.registerSem = sem;
> -		this.eventTimer = new Timer();
> -		this.timerInitialized = false;
> -	}
> -
> -	private void setupEventTimer() {
> -		if (this.timerInitialized) {
> -			return;
> -		}
> -
> -		this.eventTimer.scheduleAtFixedRate(new TimerTask() {
> -			@Override
> -			public void run() {
> -				LTTngSessiondCmd2_4.sessiond_enable_handler enableCmd = new
> -					LTTngSessiondCmd2_4.sessiond_enable_handler();
> -
> -				synchronized (eventMap) {
> -					String loggerName;
> -					Enumeration loggers = handler.logManager.getLoggerNames();
> -
> -					/*
> -					 * Create an event for each logger found and attach it to the
> -					 * handler.
> -					 */
> -					while (loggers.hasMoreElements()) {
> -						ArrayList<LTTngEvent> bucket;
> -
> -						loggerName = loggers.nextElement().toString();
> -
> -						/* Logger is already enabled or end of list, skip it. */
> -						if (handler.exists(loggerName) == true ||
> -								loggerName.equals("")) {
> -							continue;
> -						}
> -
> -						bucket = eventMap.get(loggerName);
> -						if (bucket == null) {
> -							/* No event(s) exist for this logger. */
> -							continue;
> -						}
> -
> -						for (LTTngEvent event : bucket) {
> -							enableCmd.name = event.name;
> -							enableCmd.lttngLogLevel = event.logLevel.level;
> -							enableCmd.lttngLogLevelType = event.logLevel.type;
> -
> -							/* Event exist so pass null here. */
> -							enableCmd.execute(handler, null, wildCardSet);
> -						}
> -					}
> -				}
> -
> -				/* Handle wild cards. */
> -				synchronized (wildCardSet) {
> -					Map<String, ArrayList<LTTngEvent>> modifiedEvents =
> -						new HashMap<String, ArrayList<LTTngEvent>>();
> -					Set<LTTngEvent> tmpSet = new HashSet<LTTngEvent>();
> -					Iterator<LTTngEvent> it = wildCardSet.iterator();
> -
> -					while (it.hasNext()) {
> -						LTTngEvent event = it.next();
> -
> -						/* Only support * for now. */
> -						if (event.name.equals("*")) {
> -							enableCmd.name = event.name;
> -							enableCmd.lttngLogLevel = event.logLevel.level;
> -							enableCmd.lttngLogLevelType = event.logLevel.type;
> -
> -							/* That might create a new event so pass the map. */
> -							enableCmd.execute(handler, modifiedEvents, tmpSet);
> -						}
> -					}
> -					eventMap.putAll(modifiedEvents);
> -				}
> -			}
> -		}, this.timerDelay, this.timerDelay);
> -
> -		this.timerInitialized = true;
>  	}
>  
>  	/*
> @@ -185,8 +80,6 @@ public class LTTngTCPSessiondClient {
>  	 * Cleanup Agent state.
>  	 */
>  	private void cleanupState() {
> -		eventMap.clear();
> -		wildCardSet.clear();
>  		if (this.handler != null) {
>  			this.handler.clear();
>  		}
> @@ -216,8 +109,6 @@ public class LTTngTCPSessiondClient {
>  				 */
>  				registerToSessiond();
>  
> -				setupEventTimer();
> -
>  				/*
>  				 * Block on socket receive and wait for command from the
>  				 * session daemon. This will return if and only if there is a
> @@ -239,7 +130,6 @@ public class LTTngTCPSessiondClient {
>  
>  	public void destroy() {
>  		this.quit = true;
> -		this.eventTimer.cancel();
>  
>  		try {
>  			if (this.sessiondSock != null) {
> @@ -331,7 +221,7 @@ public class LTTngTCPSessiondClient {
>  						break;
>  					}
>  					enableCmd.populate(data);
> -					enableCmd.execute(this.handler, this.eventMap, this.wildCardSet);
> +					enableCmd.execute(this.handler);
>  					data = enableCmd.getBytes();
>  					break;
>  				}
> @@ -344,7 +234,7 @@ public class LTTngTCPSessiondClient {
>  						break;
>  					}
>  					disableCmd.populate(data);
> -					disableCmd.execute(this.handler, this.eventMap, this.wildCardSet);
> +					disableCmd.execute(this.handler);
>  					data = disableCmd.getBytes();
>  					break;
>  				}
> --
> 2.0.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
