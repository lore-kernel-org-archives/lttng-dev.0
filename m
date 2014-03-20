From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Need help in UST
Date: Thu, 20 Mar 2014 09:05:36 -0400
Message-ID: <CA+jJMxusTB3symn0wdjeYh9tum2E-qP=vpcfjUd+exuxsOcG=w__5730.33837504244$1395320787$gmane$org@mail.gmail.com>
References: <CAGYvGQTk2ajYcRmDSE0hzd+kB336WyPkEO3J1V80MsEB=D8AAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WQcfG-0008Fm-7X
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 09:05:44 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so846371qcy.26
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 06:05:36 -0700 (PDT)
In-Reply-To: <CAGYvGQTk2ajYcRmDSE0hzd+kB336WyPkEO3J1V80MsEB=D8AAw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ningaraj Revoor <ningarajsr@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Mar 20, 2014 at 6:09 AM, Ningaraj Revoor <ningarajsr@gmail.com> wro=
te:
> Hi All,
>
> I am new to Linux and i tried using Lttng on my ubuntu box(12.04),
> i have installed lttng-tools on my machine and tried using lttng.
> Kernel tracing works for me but i am not able get UST done. i have create=
d a
> demo app and added instrumentation code for that(using lttng-gen-tp). i
> tried referring lot of online documents(followed all steps) but UST still
> not working for me.
> I am not sure what i am missing, will be helpful if you can provide point=
ers
> to some document which gives correct steps to follow
>

Hi!

You can have a look at the examples provided in lttng-ust's tree[1].

Don't hesitate to share your demo application and the commands you
used if you still can't get it to work.

Also, did you install LTTng from source or from your distro's packages?

Regards,
J=E9r=E9mie

[1] https://bugs.lttng.org/projects/lttng-ust/repository/revisions/master/s=
how/doc/examples

>
>
> Thanks,
> Ningaraj
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
