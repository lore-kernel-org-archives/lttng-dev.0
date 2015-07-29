From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Allow compiling the Java agent
 with	Java 1.6
Date: Wed, 29 Jul 2015 20:35:25 +0000 (UTC)
Message-ID: <1073926106.161.1438202125852.JavaMail.zimbra__24136.3665358678$1438202188$gmane$org@efficios.com>
References: <1438201794-335-1-git-send-email-alexmonthy@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZKY4i-0007wg-M2
 for lttng-dev@lists.lttng.org; Wed, 29 Jul 2015 16:35:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CDE8634056C
 for <lttng-dev@lists.lttng.org>; Wed, 29 Jul 2015 20:35:36 +0000 (UTC)
In-Reply-To: <1438201794-335-1-git-send-email-alexmonthy@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- On Jul 29, 2015, at 4:29 PM, Alexandre Montplaisir alexmonthy@efficios.com wrote:

> Previous patch d60dfbe inadvertently made use of
> ReflectiveOperationException, which was introduced in Java 7.
> To continue being able to compile the agent with Java 6, we
> can list individual exception types instead.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
> ---
> .../org/lttng/ust/agent/LTTngAgent.java            | 71 +++++++++++++++++-----
> 1 file changed, 57 insertions(+), 14 deletions(-)
> 
> diff --git
> a/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/LTTngAgent.java
> b/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/LTTngAgent.java
> index 3c9a799..1a6b59a 100644
> ---
> a/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/LTTngAgent.java
> +++
> b/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/LTTngAgent.java
> @@ -18,6 +18,7 @@
> package org.lttng.ust.agent;
> 
> import java.lang.reflect.Constructor;
> +import java.lang.reflect.InvocationTargetException;
> import java.lang.reflect.Method;
> import java.util.logging.Handler;
> import java.util.logging.Logger;
> @@ -95,11 +96,19 @@ public class LTTngAgent {
> 
> 			/* Attach the handler to the root JUL logger */
> 			Logger.getLogger("").addHandler((Handler) julHandler);
> -		} catch (ReflectiveOperationException e) {
> +
> 			/*
> -			 * LTTng JUL classes not found, no need to create the relevant
> -			 * objects
> +			 * If any of the following exceptions happen, it means we could not
> +			 * find or initialize LTTng JUL classes. We will not setup LTTng JUL
> +			 * tracing in this case.
> 			 */
> +		} catch (SecurityException e) {
> +		} catch (IllegalAccessException e) {
> +		} catch (IllegalArgumentException e) {
> +		} catch (ClassNotFoundException e) {
> +		} catch (NoSuchMethodException e) {
> +		} catch (InstantiationException e) {
> +		} catch (InvocationTargetException e) {
> 		}
> 	}
> 
> @@ -119,11 +128,25 @@ public class LTTngAgent {
> 			Class<?> log4jAppenderClass =
> 			Class.forName("org.lttng.ust.agent.log4j.LttngLogAppender");
> 			Constructor<?> log4jAppendCtor = log4jAppenderClass.getConstructor();
> 			log4jAppender = (ILttngHandler) log4jAppendCtor.newInstance();
> -		} catch (ReflectiveOperationException e) {
> +
> 			/*
> -			 * LTTng Log4j classes not found, no need to create the relevant
> -			 * objects.
> +			 * If any of the following exceptions happen, it means we could not
> +			 * find or initialize LTTng log4j classes. We will not setup LTTng
> +			 * log4j tracing in this case.
> 			 */
> +		} catch (SecurityException e) {
> +			return;
> +		} catch (ClassNotFoundException e) {
> +			return;
> +		} catch (NoSuchMethodException e) {
> +			return;
> +		} catch (IllegalArgumentException e) {
> +			return;
> +		} catch (InstantiationException e) {
> +			return;
> +		} catch (IllegalAccessException e) {
> +			return;
> +		} catch (InvocationTargetException e) {
> 			return;
> 		}
> 
> @@ -143,12 +166,22 @@ public class LTTngAgent {
> 			Object rootLogger = getRootLoggerMethod.invoke(null, (Object[]) null);
> 			addAppenderMethod.invoke(rootLogger, log4jAppender);
> 
> -		} catch (ReflectiveOperationException e) {
> 			/*
> -			 * We have checked for the log4j library version previously, these
> -			 * classes should exist.
> +			 * We have checked for the log4j library version previously, none of
> +			 * the following exceptions should happen.
> 			 */
> -			throw new IllegalStateException();
> +		} catch (SecurityException e) {
> +			throw new IllegalStateException(e);
> +		} catch (ClassNotFoundException e) {
> +			throw new IllegalStateException(e);
> +		} catch (NoSuchMethodException e) {
> +			throw new IllegalStateException(e);
> +		} catch (IllegalArgumentException e) {
> +			throw new IllegalStateException(e);
> +		} catch (IllegalAccessException e) {
> +			throw new IllegalStateException(e);
> +		} catch (InvocationTargetException e) {
> +			throw new IllegalStateException(e);
> 		}
> 	}
> 
> @@ -228,12 +261,22 @@ public class LTTngAgent {
> 			Object rootLogger = getRootLoggerMethod.invoke(null, (Object[]) null);
> 			removeAppenderMethod.invoke(rootLogger, log4jAppender);
> 
> -		} catch (ReflectiveOperationException e) {
> 			/*
> -			 * We were able to attach the appender, we should not have problems
> -			 * here either!
> +			 * We were able to attach the appender previously, we should not
> +			 * have problems here either!
> 			 */
> -			throw new IllegalStateException();
> +		} catch (SecurityException e) {
> +			throw new IllegalStateException(e);
> +		} catch (ClassNotFoundException e) {
> +			throw new IllegalStateException(e);
> +		} catch (NoSuchMethodException e) {
> +			throw new IllegalStateException(e);
> +		} catch (IllegalArgumentException e) {
> +			throw new IllegalStateException(e);
> +		} catch (IllegalAccessException e) {
> +			throw new IllegalStateException(e);
> +		} catch (InvocationTargetException e) {
> +			throw new IllegalStateException(e);
> 		}
> 
> 		/* Close the appender */
> --
> 2.1.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
