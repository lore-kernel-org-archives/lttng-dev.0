From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: Abort loading log4j agent classes when
 detected log4j version is too old
Date: Thu, 2 Oct 2014 20:36:49 +0000 (UTC)
Message-ID: <622918749.2570.1412282209881.JavaMail.zimbra__7994.40390333093$1412282274$gmane$org@efficios.com>
References: <1412281916-11684-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XZn7Y-0005ey-CE
 for lttng-dev@lists.lttng.org; Thu, 02 Oct 2014 16:37:08 -0400
In-Reply-To: <1412281916-11684-1-git-send-email-christian.babeux@efficios.com>
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

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Christian Babeux" <christian.babeux@efficios.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Thursday, October 2, 2014 4:31:56 PM
> Subject: [PATCH] Fix: Abort loading log4j agent classes when detected log4j version is too old
> 
> The Java Log4j agent rely on the getTimeStamp() method that was
> introduced in log4j 1.2.15. This fix implement a runtime detection of
> the log4j library capabilities and abort the loading of the relevant
> agent classes if the version used is too old.
> 
> Thus, log4j tracing will be deactivated on older version of the
> library.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  .../java/org/lttng/ust/agent/LTTngAgent.java       | 38
>  ++++++++++++++++++----
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> index 342ccfa..293ac84 100644
> --- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> +++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> @@ -29,7 +29,6 @@ import java.util.Enumeration;
>  import java.lang.reflect.InvocationTargetException;
>  
>  import java.util.logging.Logger;
> -import java.util.logging.FileHandler;;
>  import java.util.logging.SimpleFormatter;
>  
>  public class LTTngAgent {
> @@ -92,17 +91,44 @@ public class LTTngAgent {
>  	}
>  
>  	private Boolean loadLog4jClasses() {
> -		Boolean loaded = false;
> +		Class<?> logging;
> +
>  		try {
>  			ClassLoader loader = ClassLoader.getSystemClassLoader();
> -			loader.loadClass("org.apache.log4j.Logger");
> -			loaded = true;
> +			logging = loader.loadClass("org.apache.log4j.spi.LoggingEvent");
>  		} catch (ClassNotFoundException e) {
>  			/* Log4j classes not found, no need to create the relevant objects */
> -			loaded = false;
> +			return false;
> +		}
> +
> +		/*
> +		 * Detect capabilities of the log4j library. We only
> +		 * support log4j >= 1.2.15.  The getTimeStamp() method
> +		 * was introduced in log4j 1.2.15, so verify that it
> +		 * is available.
> +		 *
> +		 * We can't rely on the getPackage().getImplementationVersion()
> +		 * call that would retrieves information from the manifest file
> +		 * found in the JAR since the manifest file shipped
> +		 * from upstream is known to be broken in several
> +		 * versions of the library.
> +		 *
> +		 * More info:
> +		 * https://issues.apache.org/bugzilla/show_bug.cgi?id=44370
> +		 */
> +
> +		try {
> +			logging.getDeclaredMethod("getTimeStamp");
> +		} catch (NoSuchMethodException e) {
> +			return false;
> +		} catch (NullPointerException e) {
> +			/* Should never happen */
> +			return false;
> +		} catch (SecurityException e) {
> +			return false;
>  		}
>  
> -		return loaded;
> +		return true;
>  	}
>  
>  	private void initAgentJULClasses() {
> --
> 2.1.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
