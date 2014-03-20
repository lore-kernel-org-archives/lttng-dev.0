From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: Need help in UST
Date: Thu, 20 Mar 2014 09:21:36 -0400
Message-ID: <1395321696.532aeb602693c__28743.5243757956$1395321740$gmane$org@www.imp.polymtl.ca>
References: <CAGYvGQTk2ajYcRmDSE0hzd+kB336WyPkEO3J1V80MsEB=D8AAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1WQcug-0008P5-L3
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 09:21:42 -0400
In-Reply-To: <CAGYvGQTk2ajYcRmDSE0hzd+kB336WyPkEO3J1V80MsEB=D8AAw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ningaraj Revoor <ningarajsr@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Quoting Ningaraj Revoor <ningarajsr@gmail.com>:

> Hi All,
>
> I am new to Linux and i tried using Lttng on my ubuntu box(12.04),
> i have installed lttng-tools on my machine and tried using lttng.
> Kernel tracing works for me but i am not able get UST done. i have created
> a demo app and added instrumentation code for that(using lttng-gen-tp). i
> tried referring lot of online documents(followed all steps) but UST still
> not working for me.

What kind of errors are there?

> I am not sure what i am missing, will be helpful if you can provide
> pointers to some document which gives correct steps to follow

I think the lttng-ust manual is quite comprehensive already - 
http://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html

You can also have a look at [1] and see how Simon instrumented httpd. There is a
clean and instrumented thttpd version you can get at [2] and observe how
instrumentation was done.

[1]
https://github.com/simark/httpd/commit/2c6d73c47156350233b346e9eaa49ffb07a58e6e
[2] http://step.polymtl.ca/~suchakra/osfy/
