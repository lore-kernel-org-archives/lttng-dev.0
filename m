From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: UST tracepoints, same provider, different files
Date: Mon, 29 Apr 2013 09:59:43 -0400
Message-ID: <CAFXXi0kKx6k4mUDAUxJ0xpW4qqckySAq2vGYwFULJ3CmevPxhw__7570.88468312777$1367244043$gmane$org@mail.gmail.com>
References: <CAFXXi0=52W6vKHO6GA2dFPUPocVXPJD23HSG6K=riQTgWaDoTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UWocs-0003BJ-TX
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 10:00:19 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so2602541iak.29
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 07:00:13 -0700 (PDT)
In-Reply-To: <CAFXXi0=52W6vKHO6GA2dFPUPocVXPJD23HSG6K=riQTgWaDoTQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Just to add a precision, it happens only when both tracepoints use the
same provider.

On 29 April 2013 09:58, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Hello !
>
> I am trying to add two tracepoints to a simple test application. If I
> put both tracepoints in different compilation units (two .c files),
> UST crashes when the application starts with the following message:
>
> test: /usr/local/include/lttng/ust-tracepoint-event.h:685:
> __lttng_events_init__my_project: Assertion `!ret' failed.
>
> I made an example [1] so you can simply run "make && ./test". I am
> using the latest git versions, on Ubuntu 13.04 x86_64.
>
> Thanks !
>
> Simon
>
> [1] http://git.dorsal.polymtl.ca/~smarchi?p=ust-test.git;a=summary
