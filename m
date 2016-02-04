From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-ust] Fix: Ensure the Java JUL messages
 are correctly formatted
Date: Thu, 4 Feb 2016 15:02:06 -0500
Message-ID: <56B3AE3E.6080406__43805.7892061353$1454616188$gmane$org@voxpopuli.im>
References: <1454563921-2696-1-git-send-email-alexmonthy@efficios.com>
 <851290023.12152.1454595796361.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1aRQ6X-0005fu-4t
 for lttng-dev@lists.lttng.org; Thu, 04 Feb 2016 15:02:14 -0500
In-Reply-To: <851290023.12152.1454595796361.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2016-02-04 09:23 AM, Mathieu Desnoyers wrote:
> ----- On Feb 4, 2016, at 12:32 AM, Alexandre Montplaisir alexmonthy@efficios.com wrote:
>
>> It is possible for log records to contain messages that need some
>> formatting, for example if the string contains localized elements
>> or if the log(Level, String, Object[]) method is used.
>>
>> In these cases, we need to make sure to format the string and not
>> pass the "raw" string to the tracepoint.
>>
>> This only applies to the JUL API. log4j 1.2.x did not handle such
>> formatting, although log4j 2.x does.
> Hi Alexandre,
>
> The fix applies fine to master (merged). Can you also provide
> a fix for stable-2.7 ? The cherry-pick is not straightforward.

Sure, I have just tested an equivalent fix for 2.7, I will send it shortly.

Alexandre

>
> Thanks!
>
> Mathieu
>
>> Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
>> ---
>> .../org/lttng/ust/agent/jul/LttngLogHandler.java         | 16 +++++++++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/liblttng-ust-java-agent/java/lttng-ust-agent-jul/org/lttng/ust/agent/jul/LttngLogHandler.java
>> b/liblttng-ust-java-agent/java/lttng-ust-agent-jul/org/lttng/ust/agent/jul/LttngLogHandler.java
>> index d8e0cb8..39e08a8 100644
>> ---
>> a/liblttng-ust-java-agent/java/lttng-ust-agent-jul/org/lttng/ust/agent/jul/LttngLogHandler.java
>> +++
>> b/liblttng-ust-java-agent/java/lttng-ust-agent-jul/org/lttng/ust/agent/jul/LttngLogHandler.java
>> @@ -20,6 +20,7 @@ package org.lttng.ust.agent.jul;
>>
>> import java.io.IOException;
>> import java.util.concurrent.atomic.AtomicLong;
>> +import java.util.logging.Formatter;
>> import java.util.logging.Handler;
>> import java.util.logging.LogRecord;
>>
>> @@ -43,6 +44,17 @@ public class LttngLogHandler extends Handler implements
>> ILttngHandler {
>>
>> 	private static final String SHARED_OBJECT_NAME = "lttng-ust-jul-jni";
>>
>> +	/**
>> +	 * Dummy Formatter object, so we can use its
>> +	 * {@link Formatter#formatMessage(LogRecord)} method.
>> +	 */
>> +	private static final Formatter FORMATTER = new Formatter() {
>> +		@Override
>> +		public String format(LogRecord record) {
>> +			throw new UnsupportedOperationException();
>> +		}
>> +	};
>> +
>> 	private final ILttngAgent<LttngLogHandler> agent;
>>
>> 	/** Number of events logged (really sent through JNI) by this handler */
>> @@ -103,13 +115,15 @@ public class LttngLogHandler extends Handler implements
>> ILttngHandler {
>> 			return;
>> 		}
>>
>> +		String formattedMessage = FORMATTER.formatMessage(record);
>> +
>> 		eventCount.incrementAndGet();
>> 		/*
>> 		 * Specific tracepoint designed for JUL events. The source class of the
>> 		 * caller is used for the event name, the raw message is taken, the
>> 		 * loglevel of the record and the thread ID.
>> 		 */
>> -		tracepoint(record.getMessage(),
>> +		tracepoint(formattedMessage,
>> 				record.getLoggerName(),
>> 				record.getSourceClassName(),
>> 				record.getSourceMethodName(),
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
