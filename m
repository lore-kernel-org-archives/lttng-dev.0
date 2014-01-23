From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Lttng state dump traces not present in 13.04 Ubuntu
 server distribution
Date: Thu, 23 Jan 2014 13:38:32 -0500
Message-ID: <52E161A8.4070908__19410.1075911478$1390502381$gmane$org@voxpopuli.im>
References: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1W6PAr-0007mi-VL
	for lttng-dev@lists.lttng.org; Thu, 23 Jan 2014 13:38:51 -0500
In-Reply-To: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Krishanth TJ <krishanthtj@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Can you confirm if the updated "lttng-modules-dkms" package really
installed successfully? (You can uninstall/reinstall it and check in the
output.) The problem with DKMS packages is that the .deb can build fine
on the builder, but it fails to install on the user's machine depending
on the kernel version, etc.

What may happen is that the package failed to install, and you are still
using the old version of the lttng-modules that come with the default
Ubuntu kernel, which may not have statedump events. In that case I would
suggest installing the modules manually from source.

Unfortunately, there is no easy way to query which version of the
modules are running with the "lttng" command.

Cheers,
Alexandre


On 14-01-23 05:30 AM, Krishanth TJ wrote:
> Dear All,
>
> Recently when I tried to use lttng on Ubuntu 13.04 server distribution, I
> noticed that statedump traces were not present.
>
> Installed lttng-tools, lttng-modules-dkms, babeltrace from
>
> deb http://ppa.launchpad.net/lttng/ppa/ubuntu raring main
> deb-src http://ppa.launchpad.net/lttng/ppa/ubuntu raring main
>
> Version:
>
> lttng version 2.3.0
> babeltrace 1.0.3
>
> The procedure followed was
>
> # lttng create newsession
>
> # lttng enable-event -a -k
>
> # lttng start
>
> # Do something
>
> # lttng stop
>
> # lttng destroy
>
> # babeltrace <session>
>
> Any help would be appreciated.
>
> Noticed that 3.2.0-39-generic has statedump traces.
>
> Regards,
> Krish.
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
