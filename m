From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Progress on base address outstanding issues
Date: Thu, 22 May 2014 09:25:42 +0200
Message-ID: <537DA676.7010807__32551.8686594025$1400743626$gmane$org@mentor.com>
References: <66971283.20283.1400614378328.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1WnNNw-0007hb-6U
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 03:25:58 -0400
In-Reply-To: <66971283.20283.1400614378328.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Wittels,
 Rhonda" <Rhonda_Wittels@mentor.com>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

We use this feature in the new Codebench 2014.05 release (for
cyg-profile symbol resolution and ust-tracepoint source line lookup).
We will do what we can to make it stable and turn it into a fully
supported feature.

I'm currently busy finding out why LTTng 2.4 userspace tracing with
Yocto 1.6 on ARM(qemuarm) is not working properly.
( ust-tracepoints emitted from shared objects are never set into active
state and thus not recorded :-[ ).

Once I'm done with that I will look into the deadlock issue.

--
Thanks,
Paul

On 05/20/2014 09:32 PM, Mathieu Desnoyers wrote:
> Hi,
>
> We are currently revisiting the open issues before the
> 2.5 release cycle, and we are wondering if there has been
> any progress on bug http://bugs.lttng.org/issues/745 ?
>
> This feature is currently "experimental", but buggy
> (triggers deadlocks). Until we have a fix for this, it will
> stay experimental, and if there is no further progress on
> this front, we will mark it for removal for the 2.6 release
> cycle (around August 2014).
>
> Thank you,
>
> Mathieu
>


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
