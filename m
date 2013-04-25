From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Thu, 25 Apr 2013 09:51:20 -0400
Message-ID: <CAGDH53nxTru81cYQ2-dHWfoKOXaG2nxV_8NK91HbfjR-geBY2A__41307.1748255335$1366897911$gmane$org@mail.gmail.com>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
	<CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw@mail.gmail.com>
	<CAGDH53k0DuDWg2sQa2fRfXPMDHLYeyGJr0MXsth0PcxiY6bXUQ@mail.gmail.com>
	<CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UVMa5-0000Gp-UN
	for lttng-dev@lists.lttng.org; Thu, 25 Apr 2013 09:51:26 -0400
Received: by mail-ve0-f177.google.com with SMTP id cy12so1289345veb.36
	for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2013 06:51:20 -0700 (PDT)
In-Reply-To: <CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zifei,

The dynamic instrumentation project is very interesting indeed. I also
think it could be doable as a GSoC project. Do you have any plan on
how you would integrate dyninst with UST?

Also, a quick reminder that the GSoC application for student is open
until May 3rd. Don't forget to send us your proposal :)!

Thanks,

Christian

On Wed, Apr 24, 2013 at 11:45 AM, Zifei Tong <soariez@gmail.com> wrote:
> Hi Christian,
>
> On Sun, Apr 21, 2013 at 2:44 AM, Christian Babeux
> <christian.babeux@efficios.com> wrote:
>> The improvement of liblttng-ust-libc has nothing to do with dyninst.
>> Maybe you meant the dynamic instrumentation project?
>
> I played with dyninst today. Here is a minimal working example:
> https://gist.github.com/5kg/5451894
>
> Dyninst is a really cool project (after struggling to get it work),
> and I am more confident that the "Dynamic instrumentation support in
> UST" project is doable as a GSoC project. The systemtap project is a
> great reference [1].
>
> Expected results might be somthing like this:
> http://sourceware.org/systemtap/SystemTap_Beginners_Guide/userspace-probing.html
> .
>
> [1] http://sourceware.org/git/gitweb.cgi?p=systemtap.git;a=tree;f=stapdyn;hb=HEAD
> [2] http://lists.lttng.org/pipermail/lttng-dev/2013-February/019636.html
>
> --
> Best Regards,
> Zifei Tong
