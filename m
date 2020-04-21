From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Have live session and rotation together
Date: Tue, 21 Apr 2020 19:15:39 -0400 (EDT)
Message-ID: <1540290911.63019.1587510939096.JavaMail.zimbra@efficios.com>
References: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
 <211031090.61650.1587478983634.JavaMail.zimbra@efficios.com>
 <CAAeL1ME-1B6uLf9iGVWcpA=5MqAMLaCoq+eLkDCsd=GpXy5gJg@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 496KDX1jRqz1hsr
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 19:15:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 717E9296D89
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 19:15:39 -0400 (EDT)
In-Reply-To: <CAAeL1ME-1B6uLf9iGVWcpA=5MqAMLaCoq+eLkDCsd=GpXy5gJg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sergei Dyshel <qyron.private@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Apr 21, 2020, at 5:37 PM, Sergei Dyshel qyron.private@gmail.com wrote:

[...]
> 
>> Considering that there are few compelling use-cases for using both
>> features together, and no customer have expressed interest in this,
>> it is not part of our roadmap.
> 
> Here is my case: I'm using LTTNG for continuous tracing during the
> whole system timeline,
> generating pretty big volume of traces.
> 
> I'm using live and session and Babeltrace2 plugin which converts
> processes these traces,
> converts them to text and stores them
> in some text file to which I apply "logrotate" so that old traces are
> archived when needed.
> 
> However, as I see, "lttng-relayd" also writes binary traces in CTF
> from to some directory, never discarding old traces. So assuming
> system long runtime this directory is going to eat all the free space
> sometime?! Rotation would allow me to discard old archives just as
> "logrotate" does. How else can I discard old CTF files?

The feature you need is called "tracefile rotation", with the channel
attributes "tracefile count" and "tracefile size". It was implemented at
the same time as the live mode for exactly the purpose you describe.

See https://lttng.org/docs/#doc-tracefile-rotation for more information.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
