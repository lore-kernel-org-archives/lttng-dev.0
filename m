From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: unable to profile example
Date: Tue, 16 Apr 2019 13:46:05 -0400 (EDT)
Message-ID: <1864353373.2210.1555436765140.JavaMail.zimbra__46849.1697612748$1555436786$gmane$org@efficios.com>
References: <CAGkk+5Be9mMt6Nni8BdRwH4hfXG_QsKKjNPtYWm2xDtGOvNruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44kCTV2LVmz1Kcq
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 13:46:06 -0400 (EDT)
In-Reply-To: <CAGkk+5Be9mMt6Nni8BdRwH4hfXG_QsKKjNPtYWm2xDtGOvNruA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Luis Ayuso <luis.f.ayuso@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----- On Apr 16, 2019, at 11:34 AM, Luis Ayuso luis.f.ayuso@gmail.com wrote:

> Dear Lttng community.

> I tried to profile the example code, as described in the documentation @ [
> https://lttng.org/docs/v2.10 | https://lttng.org/docs/v2.10 ]
> and I could not get any satisfactory result.

> I am using
> - lttng (LTTng Trace Control) 2.10.2 - KeKriek
> - Ubuntu 18.04.2

> I created the files hello-tp.c hello-tp.h hello.c as described in the
> documentation
> The code succesfully compiles.
> Kernel modules are loaded.
> lttng-sessiond --daemonize runs with not acknowledgement.

> nevertheless, lttng create session command returns an error I am unable to
> justify:
> lttng create test
> Session test created.
> Traces will be written in /home/luis/lttng-traces/test-20190416-173219
> Error: Unable to create config file
> Error: Command error

> - Do I need any extra setup step that is no documented in the web?
> - Is the package at ubuntu repos working correctly?
> - are there known conflicts with any other software

This message appears when lttng fails to create either:

- $LTTNG_HOME/.lttngrc (if the LTTNG_HOME environment variable is set), or
- $HOME/.lttngrc otherwise.

Please double-check the content of those environment variables and access rights
to the directories they lead to.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
