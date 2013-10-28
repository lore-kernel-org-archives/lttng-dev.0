From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-modules compatibility for 3.12 kernels
Date: Mon, 28 Oct 2013 12:22:19 +0000 (UTC)
Message-ID: <1419038926.51588.1382962939138.JavaMail.zimbra__10500.2594682903$1382963008$gmane$org@efficios.com>
References: <CAP9ODKoJN1gp4pUjf5MioR_EScYR2ZKUyQ5njfVjUUjcZhY_4w@mail.gmail.com>
	<CAP9ODKo+OReXTk9wFMCYoe79WtJEw6iPVz1b_ToSMJY0mn47Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Valq4-0001t0-Sf
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 08:22:36 -0400
In-Reply-To: <CAP9ODKo+OReXTk9wFMCYoe79WtJEw6iPVz1b_ToSMJY0mn47Rg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, lttng-dev <lttng-dev@lists.lttng.org>, Philippe Mangaud <R49081@freescale.com>, Daiane Angolini <daiane.angolini@freescale.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Otavio Salvador" <otavio@ossystems.com.br>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Philippe Mangaud" <R49081@freescale.com>, "Daiane Angolini" <daiane.angolini@freescale.com>, "Fabio Estevam"
> <fabio.estevam@freescale.com>
> Sent: Saturday, October 26, 2013 10:05:23 PM
> Subject: Re: lttng-modules compatibility for 3.12 kernels
> 
> Hello Mathieu,
> 
> On Sat, Oct 26, 2013 at 5:43 PM, Otavio Salvador
> <otavio@ossystems.com.br> wrote:
> > I hope you don't mind I send the patches directly for you, as I don't
> > know where to send it ;-)
> >
> > We've been using Linux 3.12 in Freescale's ARM BSP for Yocto and it
> > includes lttng support. Philippe reported a build error after we
> > upgraded to 3.12 kernel and investigating it, it turns to be a very
> > easy fix.
> >
> > I am attaching both patches I will be sending for Yocto inclusion.
> >
> > Please review those and let me know if they need any adjustment to be
> > applied.
> 
> Fabio kindly reviewed the patchset and found I mistakenly used the
> wrong compare operator for the macro definition; hence the v2 is
> attached. I used the opportunity the rework the commit log a bit.

Hi Otavio,

Thanks for the patches !

I merged patch 0001 as is (lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation) into lttng-modules master, stable-2.3, stable-2.2.

For patch 0002, I reworked it so it now introduces a wrapper/irq.h header. This will help us not crumble under the weight of version tracking ifdefs in the long run. I'm pulling them into lttng-modules master branch. Please let me know if they work fine for you! I'm currently traveling without fast internet connectivity, so testing on 3.12 rc is not easy for me at the moment, hence the importance of your feedback.

Thanks!

Mathieu


> 
> Thanks in advance,
> 
> Regards,
> 
> --
> Otavio Salvador                             O.S. Systems
> http://www.ossystems.com.br        http://code.ossystems.com.br
> Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
