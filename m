From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Warn when log4j version is
	too old
Date: Fri, 31 Oct 2014 19:39:33 +0000 (UTC)
Message-ID: <1895116222.5744.1414784373443.JavaMail.zimbra__35088.7881046676$1414784423$gmane$org@efficios.com>
References: <1414784039-11359-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XkI2x-0003z0-0p
 for lttng-dev@lists.lttng.org; Fri, 31 Oct 2014 15:39:43 -0400
In-Reply-To: <1414784039-11359-1-git-send-email-christian.babeux@efficios.com>
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
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Christian Babeux" <christian.babeux@efficios.com>
> Sent: Friday, October 31, 2014 3:33:59 PM
> Subject: [PATCH lttng-ust] Fix: Warn when log4j version is too old
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> index 47b4519..f7e1e38 100644
> --- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> +++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/LTTngAgent.java
> @@ -119,6 +119,7 @@ public class LTTngAgent {
>  		try {
>  			logging.getDeclaredMethod("getTimeStamp");
>  		} catch (NoSuchMethodException e) {
> +			System.err.println("Warning: The loaded log4j library is too old. Log4j
> tracing with LTTng will be disabled.");
>  			return false;
>  		} catch (NullPointerException e) {
>  			/* Should never happen */
> --
> 2.1.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
