From: Elie Abi Saad <abisaad.elie@gmail.com>
Subject: Re: Live reading without using disk
Date: Wed, 17 Sep 2014 19:46:32 +0200
Message-ID: <CAD+1jo-0micD5cz62SxNSFki_6Cp38ttusbHUYRSek4J9Lw9gw__8612.38950533352$1410976045$gmane$org@mail.gmail.com>
References: <CAD+1jo_H23O5HiJ9n6VWFDfe7xMTN+26j_0PqXkZjXSYPRO7+g@mail.gmail.com>
 <5419C690.6050708@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abisaad.elie@gmail.com>) id 1XUJJO-0003Mz-4g
 for lttng-dev@lists.lttng.org; Wed, 17 Sep 2014 13:46:40 -0400
Received: by mail-qa0-f44.google.com with SMTP id w8so2384343qac.3
 for <lttng-dev@lists.lttng.org>; Wed, 17 Sep 2014 10:46:32 -0700 (PDT)
In-Reply-To: <5419C690.6050708@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

2014-09-17 19:36 GMT+02:00 Julien Desfossez <jdesfossez@efficios.com>:
>
>
> For now, there is no easy way to extract the trace data directly from
> the memory. There are old prototypes and ideas to create a consumerd
> that can process the traces in memory but nothing in the mainline. I'm
> currently working on ideas around this area but nothing solid yet.
>
> So yes for now, the traces (live or snapshots) must be written on disk
> before being available to a viewer.
>
> If space is the problem (especially for the live mode), you can have a
> look at the -C and -W options of the "lttng enable-channel" command.
> They allow you to limit the maximum disk space that a trace can occupy.
> If the problem is the disk I/O, I suggest for now to have a dedicated
> disk to store the traces or extract them on the network.
> Finally, if the problem is the latency between the event produced and
> available to the viewer (and a lower footprint on the system), there is
> no easy solution there for now.

Thanks for your answer, that's all I wanted to know.

-- 
Elie Abi Saad
