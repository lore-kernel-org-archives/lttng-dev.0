From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Cleanup: Remove the no longer
 needed liblttng-ust-jul folder
Date: Thu, 25 Sep 2014 16:28:39 +0000 (UTC)
Message-ID: <1916678258.28028.1411662519012.JavaMail.zimbra__12352.3417315029$1411662532$gmane$org@efficios.com>
References: <1411661291-28139-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XXBrw-00073c-Jd
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 12:26:14 -0400
In-Reply-To: <1411661291-28139-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- Original Message -----
> From: "Christian Babeux" <christian.babeux@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Thursday, September 25, 2014 12:08:11 PM
> Subject: [PATCH lttng-ust] Cleanup: Remove the no longer needed liblttng-ust-jul folder
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java | 138
>  ---------------------
>  .../org/lttng/ust/jul/LTTngLogHandler.java         |  80 ------------
>  2 files changed, 218 deletions(-)
>  delete mode 100644 liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
>  delete mode 100644 liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> 
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
> deleted file mode 100644
> index 7c8e98e..0000000
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngAgent.java
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -/*
> - * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Lesser General Public License, version 2.1
> only,
> - * as published by the Free Software Foundation.
> - *
> - * This library is distributed in the hope that it will be useful, but
> WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
> License
> - * for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public License
> - * along with this library; if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -package org.lttng.ust.jul;
> -
> -import java.io.IOException;
> -import java.io.InputStream;
> -import java.io.BufferedReader;
> -import java.io.FileReader;
> -import java.util.concurrent.Semaphore;
> -import java.util.concurrent.TimeUnit;
> -import java.util.logging.FileHandler;
> -import java.util.logging.Handler;
> -import java.util.logging.Level;
> -import java.util.logging.Logger;
> -import java.util.logging.LogManager;
> -import java.util.Enumeration;
> -
> -public class LTTngAgent {
> -
> -	/* Possible that we have to threads handling two sessiond. */
> -	private static LTTngLogHandler lttngHandlerRoot;
> -	private static LTTngLogHandler lttngHandlerUser;
> -	private static LTTngThread lttngThreadRoot;
> -	private static LTTngThread lttngThreadUser;
> -	private static Thread sessiondThRoot;
> -	private static Thread sessiondThUser;
> -
> -	/* Singleton agent object. */
> -	private static LTTngAgent curAgent = null;
> -
> -	/* Indicate if this object has been initialized. */
> -	private static boolean initialized = false;
> -
> -	private static Semaphore registerSem;
> -	private final static int semTimeout = 3; /* Seconds */
> -
> -	/*
> -	 * Default value to connect to session daemon. Port number is dynamically
> -	 * fetched from the port file that is created by a running session daemon.
> -	 */
> -	private static final String sessiondAddr = "127.0.0.1";
> -
> -	/*
> -	 * Constructor is private. This is a singleton and a reference should be
> -	 * acquired using getLTTngAgent().
> -	 */
> -	private LTTngAgent() throws IOException {
> -		this.logManager = LogManager.getLogManager();
> -		this.lttngHandlerUser = new LTTngLogHandler();
> -		this.lttngHandlerRoot = new LTTngLogHandler();
> -		this.lttngHandlerRoot.is_root = 1;
> -		this.registerSem = new Semaphore(0, true);
> -	}
> -
> -	/*
> -	 * Public getter to acquire a reference to this singleton object.
> -	 */
> -	public static synchronized LTTngAgent getLTTngAgent() throws IOException {
> -		if (curAgent == null) {
> -			curAgent = new LTTngAgent();
> -			curAgent.init();
> -		}
> -
> -		return curAgent;
> -	}
> -
> -	/*
> -	 * Initialize LTTngAgent. This will attach the log handler to all Logger
> -	 * returned by the logManager.
> -	 */
> -	private synchronized void init() throws SecurityException, IOException {
> -		int nr_acquires = 0;
> -
> -		if (this.initialized) {
> -			return;
> -		}
> -
> -		/* Handle user session daemon if any. */
> -		this.lttngThreadUser = new LTTngThread(this.sessiondAddr,
> -				this.lttngHandlerUser, this.registerSem);
> -		this.sessiondThUser = new Thread(lttngThreadUser);
> -		this.sessiondThUser.setDaemon(true);
> -		this.sessiondThUser.start();
> -		/* Wait for registration done of per-user sessiond */
> -		nr_acquires++;
> -
> -		/* Handle root session daemon. */
> -		this.lttngThreadRoot = new LTTngThread(this.sessiondAddr,
> -				this.lttngHandlerRoot, this.registerSem);
> -		this.sessiondThRoot = new Thread(lttngThreadRoot);
> -		this.sessiondThRoot.setDaemon(true);
> -		this.sessiondThRoot.start();
> -		/* Wait for registration done of system-wide sessiond */
> -		nr_acquires++;
> -
> -		/* Wait for each registration to end. */
> -		try {
> -			this.registerSem.tryAcquire(nr_acquires, semTimeout,
> -					TimeUnit.SECONDS);
> -		} catch (InterruptedException e) {
> -			e.printStackTrace();
> -		}
> -
> -		this.initialized = true;
> -	}
> -
> -	public void dispose() throws IOException {
> -		this.lttngJULThreadUser.dispose();
> -		this.lttngJULThreadRoot.dispose();
> -
> -		/* Remove handlers from the root logger */
> -		Logger rootLogger = LogManager.getLogManager().getLogger("");
> -		rootLogger.removeHandler(this.lttngHandlerUser);
> -		rootLogger.removeHandler(this.lttngHandlerRoot);
> -
> -		try {
> -			this.sessiondThUser.join();
> -			this.sessiondThRoot.join();
> -		} catch (InterruptedException e) {
> -			e.printStackTrace();
> -		}
> -	}
> -}
> diff --git a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> b/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> deleted file mode 100644
> index 008b105..0000000
> --- a/liblttng-ust-jul/org/lttng/ust/jul/LTTngLogHandler.java
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -/*
> - * Copyright (C) 2013 - David Goulet <dgoulet@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Lesser General Public License, version 2.1
> only,
> - * as published by the Free Software Foundation.
> - *
> - * This library is distributed in the hope that it will be useful, but
> WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
> License
> - * for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public License
> - * along with this library; if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -package org.lttng.ust.jul;
> -
> -import java.lang.String;
> -import java.util.logging.Handler;
> -import java.util.logging.LogRecord;
> -import java.util.logging.LogManager;
> -import java.util.logging.Level;
> -import java.util.logging.Logger;
> -import java.util.Collections;
> -import java.util.HashMap;
> -import java.util.Map;
> -
> -import org.lttng.ust.jul.LTTngUst;
> -
> -public class LTTngLogHandler extends Handler {
> -	/* Am I a root Log Handler. */
> -	public int is_root = 0;
> -	public int refcount = 0;
> -
> -	/* Logger object attached to this handler that can trigger a tracepoint. */
> -	public Map<String, LTTngEvent> enabledEvents =
> -		Collections.synchronizedMap(new HashMap<String, LTTngEvent>());
> -
> -	/* Constructor */
> -	public LTTngLogHandler() {
> -		super();
> -		/* Initialize LTTng UST tracer. */
> -		LTTngUst.init();
> -	}
> -
> -	/*
> -	 * Cleanup this handler state meaning put it back to a vanilla state.
> -	 */
> -	public void clear() {
> -		this.enabledEvents.clear();
> -	}
> -
> -	@Override
> -	public void close() throws SecurityException {}
> -
> -	@Override
> -	public void flush() {}
> -
> -	@Override
> -	public void publish(LogRecord record) {
> -		/*
> -		 * Specific tracepoing designed for JUL events. The source class of the
> -		 * caller is used for the event name, the raw message is taken, the
> -		 * loglevel of the record and the thread ID.
> -		 */
> -		if (this.is_root == 1) {
> -			LTTngUst.tracepointS(record.getMessage(),
> -					record.getLoggerName(), record.getSourceClassName(),
> -					record.getSourceMethodName(), record.getMillis(),
> -					record.getLevel().intValue(), record.getThreadID());
> -		} else {
> -			LTTngUst.tracepointU(record.getMessage(),
> -					record.getLoggerName(), record.getSourceClassName(),
> -					record.getSourceMethodName(), record.getMillis(),
> -					record.getLevel().intValue(), record.getThreadID());
> -		}
> -	}
> -}
> --
> 2.1.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
