From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 09:57:30 -0400
Message-ID: <CA+jJMxuPEipdetRy4ETyJ=LPARUOZq8a+dTKzP_esDS8zuonKQ__14024.5129973211$1396879102$gmane$org@mail.gmail.com>
References: <20140407114320.GA25948@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXA3L-000831-Os
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 09:57:39 -0400
Received: by mail-qc0-f181.google.com with SMTP id x3so6282131qcv.26
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 06:57:30 -0700 (PDT)
In-Reply-To: <20140407114320.GA25948@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jan,

Can you post the errors you get if you set the "CC=3Dgcc" line in
demo-tracef/Makefile by

ifdef AM_CC
    CC =3D $(AM_CC)
endif

Regards,
J=E9r=E9mie

On Mon, Apr 7, 2014 at 7:43 AM, Jan Glauber <jan.glauber@gmail.com> wrote:
> Hi list,
>
> I get a compile error with current git head of lttng-ust if I cross-compi=
le (bitbake):
>
> | make[4]: Entering directory `/home/jang/temp/p4/JGlauber_hal_share/poky=
/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/=
doc/examples/demo-tracef'
> | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork -mfloat=
-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15 --sysroot=3D/home/jang/temp/p4=
/JGlauber_hal_share/poky/build/tmp/sysroots/omap5 -L/home/jang/te
> |               -o demo-tracef demo-tracef.o -ldl -llttng-ust
> | demo-tracef.o: file not recognized: File format not recognized
> | collect2: error: ld returned 1 exit status
> | make[4]: *** [demo-tracef] Error 1
>
> Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix thi=
s I get more
> errors which I don't undertand. Am I the only one running into this?
>
> thx, Jan
> ---
> Harman Becker Automotive GmbH
> System Profiling & Optimizing Team
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
