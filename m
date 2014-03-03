From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [GSoc 2014] Strace replacement based on LTTng
Date: Mon, 3 Mar 2014 11:57:21 -0500
Message-ID: <CA+jJMxsYMLLL+TPexQj3AZzEsUxHNFM45gVy=_aaoPkPm=sGKA__12813.7275613428$1393865892$gmane$org@mail.gmail.com>
References: <1393683063.22314.7.camel@TAURUS>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WKWBG-0006Nm-OH
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 11:57:33 -0500
Received: by mail-qc0-f176.google.com with SMTP id m20so3724881qcx.35
	for <lttng-dev@lists.lttng.org>; Mon, 03 Mar 2014 08:57:21 -0800 (PST)
In-Reply-To: <1393683063.22314.7.camel@TAURUS>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Riccardo Schirone <sirmy15@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Mar 1, 2014 at 9:11 AM, Riccardo Schirone <sirmy15@gmail.com> wrote:
> hi, i am Riccardo Schirone, an italian student interested in GSoC and in
> particular in the "Strace drop-in replacement based on LTTng" idea.
> Anyway, i would like to better understand the problem. For example, will
> i have to add features to lttng and so i need to have deep knowledge of
> process and linux system or all the features are just there and i have
> to fit them?
>

Hi Riccardo,

Although it should be possible to implement an strace replacement
without extensive modifications to LTTng itself, we do expect our
students to have a good understanding of Linux systems.

The pillars of this feature are already in place and Julien Desfossez
is already working on a similar utility as part of the lttngtop
project.

Regards,
J=E9r=E9mie

> Thank you
>
>
> Riccardo Schirone
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
