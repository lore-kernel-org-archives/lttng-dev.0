From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust stable-2.7] Fix: Ensure the Java
 JUL	messages are correctly formatted
Date: Thu, 4 Feb 2016 20:14:57 +0000 (UTC)
Message-ID: <1589157458.12569.1454616897535.JavaMail.zimbra__16266.6268567138$1454616961$gmane$org@efficios.com>
References: <1454616177-8786-1-git-send-email-alexmonthy@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aRQIy-0005n5-Ds
 for lttng-dev@lists.lttng.org; Thu, 04 Feb 2016 15:15:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7C4C33404D5
 for <lttng-dev@lists.lttng.org>; Thu,  4 Feb 2016 20:14:58 +0000 (UTC)
In-Reply-To: <1454616177-8786-1-git-send-email-alexmonthy@efficios.com>
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

Merged into lttng-ust stable-2.7 branch, thanks!

Mathieu

----- On Feb 4, 2016, at 3:02 PM, Alexandre Montplaisir alexmonthy@efficios.com wrote:

> Same as 4721f9c, but for the stable-2.7 branch.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
> ---
> .../java/org/lttng/ust/agent/jul/LTTngLogHandler.java  | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git
> a/liblttng-ust-java-agent/java/org/lttng/ust/agent/jul/LTTngLogHandler.java
> b/liblttng-ust-java-agent/java/org/lttng/ust/agent/jul/LTTngLogHandler.java
> index b844d2f..15c7a8e 100644
> --- a/liblttng-ust-java-agent/java/org/lttng/ust/agent/jul/LTTngLogHandler.java
> +++ b/liblttng-ust-java-agent/java/org/lttng/ust/agent/jul/LTTngLogHandler.java
> @@ -19,11 +19,23 @@ package org.lttng.ust.agent.jul;
> 
> import java.lang.String;
> 
> +import java.util.logging.Formatter;
> import java.util.logging.Handler;
> import java.util.logging.LogRecord;
> 
> class LTTngLogHandler extends Handler {
> 
> +	/**
> +	 * Dummy Formatter object, so we can use its
> +	 * {@link Formatter#formatMessage(LogRecord)} method.
> +	 */
> +	private static final Formatter FORMATTER = new Formatter() {
> +		@Override
> +		public String format(LogRecord record) {
> +			throw new UnsupportedOperationException();
> +		}
> +	};
> +
> 	private final Boolean isRoot;
> 
> 	public LTTngLogHandler(Boolean isRoot) {
> @@ -54,18 +66,20 @@ class LTTngLogHandler extends Handler {
> 
> 	@Override
> 	public void publish(LogRecord record) {
> +		String formattedMessage = FORMATTER.formatMessage(record);
> +
> 		/*
> 		 * Specific tracepoint designed for JUL events. The source class of the
> 		 * caller is used for the event name, the raw message is taken, the
> 		 * loglevel of the record and the thread ID.
> 		 */
> 		if (this.isRoot) {
> -			tracepointS(record.getMessage(),
> +			tracepointS(formattedMessage,
> 				    record.getLoggerName(), record.getSourceClassName(),
> 				    record.getSourceMethodName(), record.getMillis(),
> 				    record.getLevel().intValue(), record.getThreadID());
> 		} else {
> -			tracepointU(record.getMessage(),
> +			tracepointU(formattedMessage,
> 				    record.getLoggerName(), record.getSourceClassName(),
> 				    record.getSourceMethodName(), record.getMillis(),
> 				    record.getLevel().intValue(), record.getThreadID());
> --
> 2.5.0
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
