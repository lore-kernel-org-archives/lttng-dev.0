From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Extracting System Call IDs By Using TMF
Date: Fri, 29 Nov 2013 11:59:11 -0500
Message-ID: <5298C7DF.7090606__27463.65348944$1385744416$gmane$org@gmail.com>
References: <CAKQh6pji+x7NV4nURCeyozMZkbJJXfAbHvLNJJ95y21CoXT-=Q@mail.gmail.com>
	<5298B54A.5080907@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VmRPS-0001lS-7e
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 11:59:24 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so15952323iec.7
	for <lttng-dev@lists.lttng.org>; Fri, 29 Nov 2013 08:59:12 -0800 (PST)
Received: from [132.207.221.82] (Sansfil-Public-Lassonde-221-82.polymtl.ca.
	[132.207.221.82])
	by mx.google.com with ESMTPSA id v9sm41763782igh.7.2013.11.29.08.59.11
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 29 Nov 2013 08:59:12 -0800 (PST)
In-Reply-To: <5298B54A.5080907@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Le 2013-11-29 10:39, Matthew Khouzam a =E9crit :
> Hi Shariyar,
> =

> I would like to know what is the need for the syscall id? I looked at
> kernel events, and they store the system call name, not the id? Is it
> for performance reasons, or is there some functionality that can be
> achieved from a call ID that cannot from a name?


For that reason, I implemented a simple syscall event module, that do
not decode arguments:

https://github.com/giraldeau/lttng-modules/blob/addons/addons/lttng-syscall=
-entry.c

Francis
