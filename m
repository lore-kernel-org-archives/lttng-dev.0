From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Use Java 6 syntax in JUL
	examples
Date: Mon, 15 Feb 2016 19:39:35 +0000 (UTC)
Message-ID: <755424097.19727.1455565175495.JavaMail.zimbra__30576.7054124319$1455565236$gmane$org@efficios.com>
References: <1455564598-16049-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aVOzn-0005c9-1X
 for lttng-dev@lists.lttng.org; Mon, 15 Feb 2016 14:39:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 05640340243
 for <lttng-dev@lists.lttng.org>; Mon, 15 Feb 2016 19:39:37 +0000 (UTC)
In-Reply-To: <1455564598-16049-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- On Feb 15, 2016, at 2:29 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> doc/examples/java-jul/ApplicationContextExample.java | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/examples/java-jul/ApplicationContextExample.java
> b/doc/examples/java-jul/ApplicationContextExample.java
> index 3da3ac8..52cef3f 100644
> --- a/doc/examples/java-jul/ApplicationContextExample.java
> +++ b/doc/examples/java-jul/ApplicationContextExample.java
> @@ -67,12 +67,11 @@ public class ApplicationContextExample {
> 
> 		@Override
> 		public Object retrieveContextInfo(String key) {
> -			switch (key) {
> -			case CONTEXT_NAME_SHORT:
> +			if (CONTEXT_NAME_SHORT.equals(key)) {
> 				return (short) 42;
> -			case CONTEXT_NAME_STRING:
> +			} else if (CONTEXT_NAME_STRING.equals(key)) {
> 				return "context-value!";
> -			default:
> +			} else {
> 				return null;
> 			}
> 		}
> --
> 2.7.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
