From: Josh Stone <jistone@redhat.com>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Wed, 24 Apr 2013 13:32:09 -0700
Message-ID: <51784149.3020500__29964.168489869$1366835563$gmane$org@redhat.com>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
	<CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw@mail.gmail.com>
	<CAGDH53k0DuDWg2sQa2fRfXPMDHLYeyGJr0MXsth0PcxiY6bXUQ@mail.gmail.com>
	<CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jistone@redhat.com>) id 1UV6MT-000062-2L
	for lttng-dev@lists.lttng.org; Wed, 24 Apr 2013 16:32:17 -0400
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

On 04/24/2013 08:45 AM, Zifei Tong wrote:
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

Thanks!  Please feel free to ask questions about that code on the
systemtap list.  And of course I'm still learning Dyninst myself, so if
you come you come across any way to improve things that stapdyn is
doing, I'd love that feedback too.

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
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
