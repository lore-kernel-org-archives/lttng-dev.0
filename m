From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Send the correct Java
	agent	return code when disabling events
Date: Thu, 6 Aug 2015 20:04:19 +0000 (UTC)
Message-ID: <2011207783.15178.1438891459327.JavaMail.zimbra__6587.87476500056$1438891528$gmane$org@efficios.com>
References: <1438882910-9927-1-git-send-email-alexmonthy@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZNRP0-0006hE-T7
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 16:04:37 -0400
In-Reply-To: <1438882910-9927-1-git-send-email-alexmonthy@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

merged in lttng-ust master, thanks!

Mathieu

----- On Aug 6, 2015, at 1:41 PM, Alexandre Montplaisir alexmonthy@efficios.com wrote:

> When receiving a "disable event" command from the sessiond for
> an event that is not known, the Java agent should send the
> "unknown logger name" return code, not the "invalid command" one.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@efficios.com>
> ---
> .../agent/client/SessiondDisableEventCommand.java  | 23 +++++++++++++++++++++-
> 1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git
> a/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/client/SessiondDisableEventCommand.java
> b/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/client/SessiondDisableEventCommand.java
> index 39d14b0..31d91e7 100644
> ---
> a/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/client/SessiondDisableEventCommand.java
> +++
> b/liblttng-ust-java-agent/java/lttng-ust-agent-common/org/lttng/ust/agent/client/SessiondDisableEventCommand.java
> @@ -47,6 +47,27 @@ class SessiondDisableEventCommand implements ISessiondCommand
> {
> 	@Override
> 	public ILttngAgentResponse execute(AbstractLttngAgent<?> agent) {
> 		boolean success = agent.eventDisabled(this.eventName);
> -		return (success ? ILttngAgentResponse.SUCESS_RESPONSE :
> ILttngAgentResponse.FAILURE_RESPONSE);
> +		return (success ? ILttngAgentResponse.SUCESS_RESPONSE :
> DISABLE_EVENT_FAILURE_RESPONSE);
> 	}
> +
> +	/**
> +	 * Response sent when the disable-event command asks to disable an
> +	 * unknown event.
> +	 */
> +	private static final ILttngAgentResponse DISABLE_EVENT_FAILURE_RESPONSE = new
> ILttngAgentResponse() {
> +
> +		@Override
> +		public ReturnCode getReturnCode() {
> +			return ReturnCode.CODE_UNK_LOGGER_NAME;
> +		}
> +
> +		@Override
> +		public byte[] getBytes() {
> +			byte data[] = new byte[INT_SIZE];
> +			ByteBuffer buf = ByteBuffer.wrap(data);
> +			buf.order(ByteOrder.BIG_ENDIAN);
> +			buf.putInt(getReturnCode().getCode());
> +			return data;
> +		}
> +	};
> }
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
