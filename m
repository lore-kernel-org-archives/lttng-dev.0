From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-ust] JUL: use root logger to capture
 events
Date: Thu, 26 Jun 2014 12:19:00 -0400
Message-ID: <20140626161900.GB24914__9197.32823172144$1403799613$gmane$org@dalia>
References: <1402932636-8366-1-git-send-email-dgoulet@efficios.com>
 <510A3668CBDB6143966144326546DA921BFF3FC2@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1834603762=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X0COC-0000Wg-0G
 for lttng-dev@lists.lttng.org; Thu, 26 Jun 2014 12:19:14 -0400
In-Reply-To: <510A3668CBDB6143966144326546DA921BFF3FC2@eusaamb103.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Tan Dung Le Tran <tan.dung.le.tran@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1834603762==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26 Jun (16:05:31), Tan Dung Le Tran wrote:
> Hi David,
>=20
> Is this patch applicable for lttng-ust "origin/stable-2.4" ?

Yes, Mathieu will merge this in 2.4 today and we will do a release.

David

>=20
> Thanks,
> Tan
>=20
>=20
> -----Original Message-----
> From: David Goulet [mailto:dgoulet@efficios.com]=20
> Sent: June-16-14 11:31 AM
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] [PATCH lttng-ust] JUL: use root logger to capture ev=
ents
>=20
> The JUL agent now uses the root logger ("") to capture all events. This a=
llows us to remove the Timer thread and cleanup a huge portion of the code =
base. It simplifies a great deal the internal structure of the agent since =
we don't have to monitor the Logger object anymore.
>=20
> Since tracepoint filtering is done in UST, we just the LTTng handler to t=
he root logger and send everything to UST except disabled events.
>=20
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  .../org/lttng/ust/jul/LTTngLogHandler.java         | 100 ++------------
>  .../org/lttng/ust/jul/LTTngSessiondCmd2_4.java     | 145 ++++-----------=
------
>  .../org/lttng/ust/jul/LTTngTCPSessiondClient.java  | 105 +--------------
>  3 files changed, 41 insertions(+), 309 deletions(-)
>=20
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java b/li=
blttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> index 8c79512..00e8e3c 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> @@ -29,40 +29,16 @@ import java.util.Map;
> =20
>  import org.lttng.ust.jul.LTTngUst;
> =20
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
> -		this.name =3D name;
> -		this.refcount =3D 0;
> -		this.logger =3D logger;
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
>  	public int is_root =3D 0;
> +	public int attached =3D 0;
> =20
>  	public LogManager logManager;
> =20
>  	/* Logger object attached to this handler that can trigger a tracepoint=
=2E */
> -	private Map<String, LTTngLogger> loggerMap =3D
> -		Collections.synchronizedMap(new HashMap<String, LTTngLogger>());
> +	public Map<String, LTTngEvent> disabledEvents =3D
> +		Collections.synchronizedMap(new HashMap<String, LTTngEvent>());
> =20
>  	/* Constructor */
>  	public LTTngLogHandler(LogManager logManager) { @@ -75,68 +51,10 @@ pub=
lic class LTTngLogHandler extends Handler {
>  	}
> =20
>  	/*
> -	 * Return true if the logger is enabled and attached. Else, if not foun=
d,
> -	 * return false.
> -	 */
> -	public boolean exists(String name) {
> -		if (loggerMap.get(name) !=3D null) {
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
> -		logger =3D this.logManager.getLogger(event.name);
> -		if (logger =3D=3D null) {
> -			/* Stop attach right now. */
> -			return;
> -		}
> -
> -		lttngLogger =3D loggerMap.get(event.name);
> -		if (lttngLogger =3D=3D null) {
> -			lttngLogger =3D new LTTngLogger(event.name, logger);
> -
> -			/* Attach the handler to the logger and add is to the map. */
> -			lttngLogger.attach(this);
> -			lttngLogger.refcount =3D 1;
> -			loggerMap.put(lttngLogger.name, lttngLogger);
> -		} else {
> -			lttngLogger.refcount +=3D 1;
> -		}
> -	}
> -
> -	/*
> -	 * Dettach an event from this handler. If the refcount goes down to 0, =
the
> -	 * logger object is removed thus not attached anymore.
> -	 */
> -	public void detachEvent(LTTngEvent event) {
> -		LTTngLogger logger;
> -
> -		logger =3D loggerMap.get(event.name);
> -		if (logger !=3D null) {
> -			logger.refcount -=3D 1;
> -			if (logger.refcount =3D=3D 0) {
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
> +		this.disabledEvents.clear();
>  	}
> =20
>  	@Override
> @@ -147,10 +65,14 @@ public class LTTngLogHandler extends Handler {
> =20
>  	@Override
>  	public void publish(LogRecord record) {
> -		LTTngLogger logger;
> +		LTTngEvent event;
> =20
> -		logger =3D loggerMap.get(record.getLoggerName());
> -		if (logger =3D=3D null) {
> +		/*
> +		 * Check if the logger has been disabled and if yes don't fire the
> +		 * tracepoint.
> +		 */
> +		event =3D this.disabledEvents.get(record.getLoggerName());
> +		if (event !=3D null) {
>  			/* Ignore and don't fire TP. */
>  			return;
>  		}
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java =
b/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> index 6808326..dc068f1 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngSessiondCmd2_4.java
> @@ -133,7 +133,7 @@ public interface LTTngSessiondCmd2_4 {
>  			buf.order(ByteOrder.LITTLE_ENDIAN);
>  			lttngLogLevel =3D buf.getInt();
>  			lttngLogLevelType =3D buf.getInt();
> -			name =3D new String(data, data_offset, data.length - data_offset);
> +			name =3D new String(data, data_offset, data.length -=20
> +data_offset).trim();
>  		}
> =20
>  		@Override
> @@ -152,76 +152,32 @@ public interface LTTngSessiondCmd2_4 {
>  		 * @return Event name as a string if the event is NOT found thus was
>  		 * not enabled.
>  		 */
> -		public void execute(LTTngLogHandler handler,
> -				Map<String, ArrayList<LTTngEvent>> eventMap, Set wildCardSet) {
> -			ArrayList<LTTngEvent> bucket;
> -			LTTngEvent event;
> +		public void execute(LTTngLogHandler handler) {
> +			LTTngEvent event, lookupEv;
> =20
> -			if (name =3D=3D null) {
> +			if (this.name =3D=3D null) {
>  				this.code =3D lttng_jul_ret_code.CODE_INVALID_CMD;
>  				return;
>  			}
> =20
> -			/* Wild card to enable ALL logger. */
> -			if (name.trim().equals("*")) {
> -				String loggerName;
> -				Enumeration loggers =3D handler.logManager.getLoggerNames();
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
> -					loggerName =3D loggers.nextElement().toString();
> -					/* Somehow there is always an empty string at the end. */
> -					if (loggerName =3D=3D "") {
> -						continue;
> -					}
> -
> -					event =3D new LTTngEvent(loggerName, lttngLogLevel,
> -							lttngLogLevelType);
> -					/* Attach event to Log handler to it can be traced. */
> -					handler.attachEvent(event);
> -
> -					/*
> -					 * The agent timer call this function with eventMap set to
> -					 * null because it already has a reference to an existing
> -					 * event so is should not try to add a new one here.
> -					 */
> -					if (eventMap !=3D null) {
> -						bucket =3D eventMap.get(loggerName);
> -						if (bucket =3D=3D null) {
> -							bucket =3D new ArrayList<LTTngEvent>();
> -							eventMap.put(loggerName, bucket);
> -						}
> -						bucket.add(event);
> -					}
> -				}
> -			} else {
> -				event =3D new LTTngEvent(name.trim(), lttngLogLevel,
> -						lttngLogLevelType);
> -				/* Attach event to Log handler to it can be traced. */
> -				handler.attachEvent(event);
> -
> -				/*
> -				 * The agent timer call this function with eventMap set to
> -				 * null because it already has a reference to an existing
> -				 * event so is should not try to add a new one here.
> -				 */
> -				if (eventMap !=3D null) {
> -					bucket =3D eventMap.get(name.trim());
> -					if (bucket =3D=3D null) {
> -						bucket =3D new ArrayList<LTTngEvent>();
> -						eventMap.put(name.trim(), bucket);
> -					}
> -					bucket.add(event);
> -				}
> +			/*
> +			 * Try to remove the logger name from the disabled events set in
> +			 * the handler. The return value is of no importance, we just need
> +			 * to try it.
> +			 */
> +			handler.disabledEvents.remove(this.name);
> +
> +			/* Handler already attached. */
> +			if (handler.attached =3D=3D 1) {
> +				this.code =3D lttng_jul_ret_code.CODE_SUCCESS_CMD;
> +				return;
>  			}
> =20
> +			/* Get the default JUL root logger and add our handler. */
> +			Logger rootLogger =3D handler.logManager.getLogger("");
> +			rootLogger.addHandler(handler);
> +			handler.attached =3D 1;
> +
>  			this.code =3D lttng_jul_ret_code.CODE_SUCCESS_CMD;
>  			return;
>  		}
> @@ -238,13 +194,9 @@ public interface LTTngSessiondCmd2_4 {
> =20
>  		@Override
>  		public void populate(byte[] data) {
> -			int data_offset =3D INT_SIZE * 2;
> -
>  			ByteBuffer buf =3D ByteBuffer.wrap(data);
>  			buf.order(ByteOrder.LITTLE_ENDIAN);
> -			lttngLogLevel =3D buf.getInt();
> -			lttngLogLevelType =3D buf.getInt();
> -			name =3D new String(data, data_offset, data.length - data_offset);
> +			name =3D new String(data).trim();
>  		}
> =20
>  		@Override
> @@ -260,62 +212,21 @@ public interface LTTngSessiondCmd2_4 {
>  		 * Execute disable handler action which is to disable the given handler
>  		 * to the received name.
>  		 */
> -		public void execute(LTTngLogHandler handler,
> -				Map<String, ArrayList<LTTngEvent>> eventMap, Set wildCardSet) {
> -			ArrayList<LTTngEvent> bucket;
> +		public void execute(LTTngLogHandler handler) {
>  			LTTngEvent event;
> =20
> -			if (name =3D=3D null) {
> +			if (this.name =3D=3D null) {
>  				this.code =3D lttng_jul_ret_code.CODE_INVALID_CMD;
>  				return;
>  			}
> =20
> -			/* Wild card to disable ALL logger. */
> -			if (name.trim().equals("*")) {
> -				String loggerName;
> -				Enumeration loggers =3D handler.logManager.getLoggerNames();
> -
> -				/* Remove event from the wildcard set. */
> -				wildCardSet.remove(new LTTngEvent(name.trim(), lttngLogLevel,
> -							lttngLogLevelType));
> -
> -				while (loggers.hasMoreElements()) {
> -					loggerName =3D loggers.nextElement().toString();
> -					/* Somehow there is always an empty string at the end. */
> -					if (loggerName =3D=3D "") {
> -						continue;
> -					}
> -
> -					event =3D new LTTngEvent(loggerName, lttngLogLevel,
> -							lttngLogLevelType);
> -
> -					bucket =3D eventMap.get(loggerName);
> -					if (bucket !=3D null) {
> -						handler.detachEvent(event);
> -						bucket.remove(event);
> -						if (bucket.isEmpty() =3D=3D true) {
> -							eventMap.remove(bucket);
> -						}
> -					}
> -				}
> -				this.code =3D lttng_jul_ret_code.CODE_SUCCESS_CMD;
> -			} else {
> -				event =3D new LTTngEvent(this.name, lttngLogLevel,
> -						lttngLogLevelType);
> -
> -				bucket =3D eventMap.get(this.name);
> -				if (bucket !=3D null) {
> -					handler.detachEvent(event);
> -					bucket.remove(event);
> -					if (bucket.isEmpty() =3D=3D true) {
> -						eventMap.remove(bucket);
> -					}
> -					this.code =3D lttng_jul_ret_code.CODE_SUCCESS_CMD;
> -				} else {
> -					this.code =3D lttng_jul_ret_code.CODE_UNK_LOGGER_NAME;
> -				}
> +			event =3D handler.disabledEvents.get(this.name);
> +			if (event =3D=3D null) {
> +				handler.disabledEvents.put(this.name,
> +						new LTTngEvent(this.name, 0, 0));
>  			}
> =20
> +			this.code =3D lttng_jul_ret_code.CODE_SUCCESS_CMD;
>  			return;
>  		}
>  	}
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.ja=
va b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> index a2d12fc..912d507 100644
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> +++ b/liblttng-ust-jul/org/lttng/ust/jul/LTTngTCPSessiondClient.java
> @@ -39,8 +39,6 @@ import java.util.Iterator;  import java.util.List;  imp=
ort java.util.Enumeration;  import java.util.Set; -import java.util.Timer; =
-import java.util.TimerTask;  import java.util.logging.Logger;  import java=
=2Eutil.Collections;
> =20
> @@ -64,23 +62,6 @@ public class LTTngTCPSessiondClient {
> =20
>  	private Semaphore registerSem;
> =20
> -	private Timer eventTimer;
> -
> -	/*
> -	 * Indexed by event name but can contains duplicates since multiple
> -	 * sessions can enable the same event with or without different logleve=
ls.
> -	 */
> -	private Map<String, ArrayList<LTTngEvent>> eventMap =3D
> -		Collections.synchronizedMap(
> -				new HashMap<String, ArrayList<LTTngEvent>>());
> -
> -	private Set<LTTngEvent> wildCardSet =3D
> -		Collections.synchronizedSet(new HashSet<LTTngEvent>());
> -
> -	/* Timer delay at each 5 seconds. */
> -	private final static long timerDelay =3D 5 * 1000;
> -	private static boolean timerInitialized;
> -
>  	private static final String rootPortFile =3D "/var/run/lttng/jul.port";
>  	private static final String userPortFile =3D "/.lttng/jul.port";
> =20
> @@ -90,83 +71,6 @@ public class LTTngTCPSessiondClient {
>  	public LTTngTCPSessiondClient(String host, Semaphore sem) {
>  		this.sessiondHost =3D host;
>  		this.registerSem =3D sem;
> -		this.eventTimer =3D new Timer();
> -		this.timerInitialized =3D false;
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
> -				LTTngSessiondCmd2_4.sessiond_enable_handler enableCmd =3D new
> -					LTTngSessiondCmd2_4.sessiond_enable_handler();
> -
> -				synchronized (eventMap) {
> -					String loggerName;
> -					Enumeration loggers =3D handler.logManager.getLoggerNames();
> -
> -					/*
> -					 * Create an event for each logger found and attach it to the
> -					 * handler.
> -					 */
> -					while (loggers.hasMoreElements()) {
> -						ArrayList<LTTngEvent> bucket;
> -
> -						loggerName =3D loggers.nextElement().toString();
> -
> -						/* Logger is already enabled or end of list, skip it. */
> -						if (handler.exists(loggerName) =3D=3D true ||
> -								loggerName.equals("")) {
> -							continue;
> -						}
> -
> -						bucket =3D eventMap.get(loggerName);
> -						if (bucket =3D=3D null) {
> -							/* No event(s) exist for this logger. */
> -							continue;
> -						}
> -
> -						for (LTTngEvent event : bucket) {
> -							enableCmd.name =3D event.name;
> -							enableCmd.lttngLogLevel =3D event.logLevel.level;
> -							enableCmd.lttngLogLevelType =3D event.logLevel.type;
> -
> -							/* Event exist so pass null here. */
> -							enableCmd.execute(handler, null, wildCardSet);
> -						}
> -					}
> -				}
> -
> -				/* Handle wild cards. */
> -				synchronized (wildCardSet) {
> -					Map<String, ArrayList<LTTngEvent>> modifiedEvents =3D
> -						new HashMap<String, ArrayList<LTTngEvent>>();
> -					Set<LTTngEvent> tmpSet =3D new HashSet<LTTngEvent>();
> -					Iterator<LTTngEvent> it =3D wildCardSet.iterator();
> -
> -					while (it.hasNext()) {
> -						LTTngEvent event =3D it.next();
> -
> -						/* Only support * for now. */
> -						if (event.name.equals("*")) {
> -							enableCmd.name =3D event.name;
> -							enableCmd.lttngLogLevel =3D event.logLevel.level;
> -							enableCmd.lttngLogLevelType =3D event.logLevel.type;
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
> -		this.timerInitialized =3D true;
>  	}
> =20
>  	/*
> @@ -185,8 +89,6 @@ public class LTTngTCPSessiondClient {
>  	 * Cleanup Agent state.
>  	 */
>  	private void cleanupState() {
> -		eventMap.clear();
> -		wildCardSet.clear();
>  		if (this.handler !=3D null) {
>  			this.handler.clear();
>  		}
> @@ -216,8 +118,6 @@ public class LTTngTCPSessiondClient {
>  				 */
>  				registerToSessiond();
> =20
> -				setupEventTimer();
> -
>  				/*
>  				 * Block on socket receive and wait for command from the
>  				 * session daemon. This will return if and only if there is a @@ -23=
9,7 +139,6 @@ public class LTTngTCPSessiondClient {
> =20
>  	public void destroy() {
>  		this.quit =3D true;
> -		this.eventTimer.cancel();
> =20
>  		try {
>  			if (this.sessiondSock !=3D null) {
> @@ -331,7 +230,7 @@ public class LTTngTCPSessiondClient {
>  						break;
>  					}
>  					enableCmd.populate(data);
> -					enableCmd.execute(this.handler, this.eventMap, this.wildCardSet);
> +					enableCmd.execute(this.handler);
>  					data =3D enableCmd.getBytes();
>  					break;
>  				}
> @@ -344,7 +243,7 @@ public class LTTngTCPSessiondClient {
>  						break;
>  					}
>  					disableCmd.populate(data);
> -					disableCmd.execute(this.handler, this.eventMap, this.wildCardSet);
> +					disableCmd.execute(this.handler);
>  					data =3D disableCmd.getBytes();
>  					break;
>  				}
> --
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTrEf0XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02pCIIAMNNeCythwyrdcYwsxWSoIH6
nWivT83MDyA7xzB5ODD0dJqWf06w+gD87NVwheA3HUtAXP1fQiHR6/1Wxzfm/fK6
hkXpJKXrUYTmDssIowzLIvhez5FIQlyg60qbTZwlk+XUJcDphpiUaEVdnEZNzGFB
NKqVbr7mjFfAviw/x4mjuH0VjoaTE3nQAZLyYNq0hPE3mR+LqKS2r2ItoJZQjehk
GlfWjCZcl2W/DiP+pxIH0YQXkamt/5rgm2BHXEuU80/2NBNrY3dguopZDq7YmGJA
sFZiqcPUjvN4/YX6avxsJ3WP235cBVVsCBHBisvv08wocqi+ucfaFclFuHLp6+0=
=dYFm
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


--===============1834603762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1834603762==--
