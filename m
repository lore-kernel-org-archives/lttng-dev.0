From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: running java examples out of
	tree
Date: Tue, 30 Jun 2015 22:29:38 +0000 (UTC)
Message-ID: <1836832586.1530.1435703378334.JavaMail.zimbra__29879.2075519033$1435703472$gmane$org@efficios.com>
References: <1435699976-8809-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZA42K-0000bR-4t
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 18:30:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 43974340491
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 22:29:47 +0000 (UTC)
In-Reply-To: <1435699976-8809-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged into master and stable-2.6, thanks!

Mathieu

----- On Jun 30, 2015, at 5:32 PM, Michael Jeanson mjeanson@efficios.com wrote:

> ---
> doc/examples/java-jul/run   | 7 ++++++-
> doc/examples/java-log4j/run | 7 ++++++-
> 2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/examples/java-jul/run b/doc/examples/java-jul/run
> index 37a3cfd..6deb6fd 100755
> --- a/doc/examples/java-jul/run
> +++ b/doc/examples/java-jul/run
> @@ -8,6 +8,7 @@
> 
> DIR=`dirname $0`
> JARFILE="liblttng-ust-agent.jar"
> +JAVA_OPTIONS=""
> 
> cd $DIR
> 
> @@ -20,6 +21,10 @@ else
> 	#LIBPATH="/usr/local/lib:/usr/lib"
> fi
> 
> -java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
> +if [ "x$LIBPATH" != "x" ]; then
> +	JAVA_OPTIONS="$JAVA_OPTIONS -Djava.library.path=\"$LIBPATH\""
> +fi
> +
> +java -classpath "$CLASSPATH:." $JAVA_OPTIONS Hello
> 
> cd -
> diff --git a/doc/examples/java-log4j/run b/doc/examples/java-log4j/run
> index 9dca608..91f8f5d 100755
> --- a/doc/examples/java-log4j/run
> +++ b/doc/examples/java-log4j/run
> @@ -8,6 +8,7 @@
> 
> DIR=`dirname $0`
> JARFILE="liblttng-ust-agent.jar"
> +JAVA_OPTIONS=""
> 
> # If system classpath is empty, try to guess log4j location
> if [ "x$CLASSPATH" = "x" ]; then
> @@ -25,6 +26,10 @@ else
> 	#LIBPATH="/usr/local/lib:/usr/lib"
> fi
> 
> -java -classpath "$CLASSPATH:." -Djava.library.path="$LIBPATH" Hello
> +if [ "x$LIBPATH" != "x" ]; then
> +	JAVA_OPTIONS="$JAVA_OPTIONS -Djava.library.path=\"$LIBPATH\""
> +fi
> +
> +java -classpath "$CLASSPATH:." $JAVA_OPTIONS Hello
> 
> cd -
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
