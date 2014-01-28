From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Tue, 28 Jan 2014 12:29:43 -0500
Message-ID: <1390930183.52e7e90758145__35923.7561504871$1390930247$gmane$org@www.imp.polymtl.ca>
References: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1W8CTp-0004N6-1O
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 12:29:50 -0500
In-Reply-To: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Check if the liblttng-ust-cyg-profile.so is present in system using 'locate'. On
my system its in /usr/lib64

Then give the absolute path -

*LD_PRELOAD=/usr/lib64/liblttng-ust-cyg-profile.so* appname

This works for me.

--
Suchakra

Quoting Shariyar <syed.shariyar@gmail.com>:

> Hi,
>
> I am trying to collect function entry and exit points in a trace. I  have
> followed the instructions written on the following man page:
> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.html.
>
>
> In my system, UST tracepoint tracing  is working fine and I am able to
> collect traces with the statically typed tracepoints in the code. However,
> there is no liblttng-ust-cyg-profile.so in my system and I get an error
> when I execute the following:
>
>        *LD_PRELOAD=liblttng-ust-cyg-profile.so* appname
>
> Please let me know how to get it to work?
>
> Thanks,
> Shariyar
>
