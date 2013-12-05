From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: is ltt patch required to build lttng module?
Date: Thu, 5 Dec 2013 10:25:15 -0500
Message-ID: <CA+jJMxsuXT=_1Yw4N_ixx7RQyN0X5X3EaFPgPB2QzxuhKSDnLA__11103.0890876011$1386257174$gmane$org@mail.gmail.com>
References: <CAO_Arvp5Q6EfDS_LRBKKCaPybXG-3+vp6ezzjfAcRKfNk+YTrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Voanp-0008AW-By
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 10:25:27 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so3636718qcz.16
	for <lttng-dev@lists.lttng.org>; Thu, 05 Dec 2013 07:25:15 -0800 (PST)
In-Reply-To: <CAO_Arvp5Q6EfDS_LRBKKCaPybXG-3+vp6ezzjfAcRKfNk+YTrQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 5, 2013 at 2:40 AM, kumar s <skumar.m226@gmail.com> wrote:
> Hi,
>
> I am using kernel version 2.6.32.27. When building lttng module, do i need
> to build against kernel which is patched using lttng (v0.190) or should i
> build lttng modules for kernel that is not patched.
>

You do not need to patch your kernel using the 0.x kernel patch set to
use the 2.x tracer.

To build lttng-modules on this kernel, you will need to apply the
patches found under linux-patches in the lttng-modules tree.

Regards,
J=E9r=E9mie

> I am trying to build lttng module latest version taken from lttng-module.=
git
>
> Thank you
> Skumar
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
