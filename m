From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Lttng state dump traces not present in 13.04 Ubuntu
 server distribution
Date: Fri, 24 Jan 2014 13:17:18 -0500
Message-ID: <52E2AE2E.2020907__46920.0948872187$1390587510$gmane$org@voxpopuli.im>
References: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>	<52E161A8.4070908@voxpopuli.im>
	<CAAoqFdRZaoLW_r2bdaZvU+wwMtMS1nHuBNkumznqRY-_yOPh6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1W6lJs-00027b-Ux
	for lttng-dev@lists.lttng.org; Fri, 24 Jan 2014 13:17:38 -0500
In-Reply-To: <CAAoqFdRZaoLW_r2bdaZvU+wwMtMS1nHuBNkumznqRY-_yOPh6g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Krishanth TJ <krishanthtj@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hmm, ok, if you use "lttng list -k" do they appear in the list of
available events?

One other thing I can think about is that the statedump itself takes a
little bit of time to execute, so the statedump events are never at the
very start of the trace. So if your traces are very short it's possible
to miss them entirely.

Cheers,
Alexandre


On 14-01-24 08:54 AM, Krishanth TJ wrote:
> Hi,
>
> I have confirmed that the "lttng-modules-dkms" package was successfully
> installed.
>
> $ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4
> 2013-09-28 LTTng modules 2.3.2
>     * Blacklist kernels 3.10.13 and 3.11.2
>
> I have even confirmed with few debug printk's in lttng_statedump.ko that
> the module is indeed loaded and the tracepoints are getting called. But
> still babeltrace output fails to show lttng_statedump_events.
>
> Am I missing something here?
>
> Regards,
> Krish.
>
