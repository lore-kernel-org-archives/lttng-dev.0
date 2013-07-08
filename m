From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: issue when installing LTTng on ubuntu
Date: Mon, 08 Jul 2013 13:09:03 -0400
Message-ID: <51DAF22F.4060503__31487.0805516422$1373303399$gmane$org@voxpopuli.im>
References: <CAP7TvLf0LFe0wrDK2qx+JYgVcfGFqQOJmbAiDvbon8o01EprsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UwEwG-000710-Pf
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 13:09:24 -0400
In-Reply-To: <CAP7TvLf0LFe0wrDK2qx+JYgVcfGFqQOJmbAiDvbon8o01EprsA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tarek slaymia <tarek.slaymia@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On 13-06-26 06:01 PM, tarek slaymia wrote:
> hi all, when installing lttng on ubuntu12.04 an issue is displayed related
> to lttng-modules-dkms module.
>
> Title of displayed message :
> lttng-modules-dkms 2.0.2-0ubuntu1 : lttng-modules kernel module failed to
> build.
>
> in file included from
> /var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/lttng-events.h:98:0
> /var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/define_trace.h:117
> /var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:165
> /var/lib/dkms/lttng-modules/2.0.2/build/probes/lttng-probe-signal.c:38:
> /var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:61:1:erreur:conflicting
> types
>
> Environment:
> - on ubuntu 12.04.2 LTS - release amd64
> - Linux 3.5.0-23-genericx86_64

When 12.04 came out, it came with kernel 3.2, and lttng-modules 2.0.2
was tested with that kernel. Newer revisions of 12.04 come with a more
recent kernel (see [1]). It's possible that the compatibility was broken
since. I don't have a 12.04 install to test it here, but if that's the
case, that bug should be reported to Ubuntu.

In the meanwhile, your best bet is to use the latest version of LTTng.
You can install the whole toolchain from the LTTng Stable PPA [2].

Cheers,
Alexandre


[1] https://wiki.ubuntu.com/Kernel/LTSEnablementStack
[2] https://launchpad.net/~lttng/+archive/ppa

>
> BR
>
