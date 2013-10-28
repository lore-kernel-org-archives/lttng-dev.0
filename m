From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: lttng-modules compatibility for 3.12 kernels
Date: Mon, 28 Oct 2013 11:43:39 -0200
Message-ID: <CAP9ODKoLAKyuiCEP34_AFUp9MnSFfqtTiAtWzoJ6OvXC7KV4iw__31310.5605928742$1382971419$gmane$org@mail.gmail.com>
References: <CAP9ODKoJN1gp4pUjf5MioR_EScYR2ZKUyQ5njfVjUUjcZhY_4w@mail.gmail.com>
	<CAP9ODKo+OReXTk9wFMCYoe79WtJEw6iPVz1b_ToSMJY0mn47Rg@mail.gmail.com>
	<1419038926.51588.1382962939138.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1Van6f-0000eg-DO
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 09:43:50 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so3598250oag.3
	for <lttng-dev@lists.lttng.org>; Mon, 28 Oct 2013 06:43:39 -0700 (PDT)
In-Reply-To: <1419038926.51588.1382962939138.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, lttng-dev <lttng-dev@lists.lttng.org>, Philippe Mangaud <R49081@freescale.com>, Daiane Angolini <daiane.angolini@freescale.com>
List-Id: lttng-dev@lists.lttng.org

Hello Mathieu,

On Mon, Oct 28, 2013 at 10:22 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Thanks for the patches !

You're welcome.

> I merged patch 0001 as is (lttng-statedump-impl: Fix lttng_list_interrupts for empty implementation) into lttng-modules master, stable-2.3, stable-2.2.

Great.

> For patch 0002, I reworked it so it now introduces a wrapper/irq.h header. This will help us not crumble under the weight of version tracking ifdefs in the long run. I'm pulling them into lttng-modules master branch. Please let me know if they work fine for you! I'm currently traveling without fast internet connectivity, so testing on 3.12 rc is not easy for me at the moment, hence the importance of your feedback.

Great. The patch works as intended.

I am going to send the next failure we need to fix with 3.12-rc6 to
the mailing list.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
