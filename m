From: John Kelly <jfkelly07@gmail.com>
Subject: llntg on a PPC, Kernel 3.3.8; Only getting syscalls
Date: Fri, 23 May 2014 08:52:57 -0600
Message-ID: <CAFp0A9S=nfDdrhd7eHdAR+LjC8yeG4fNh-qcCAF1EdEGrSqysQ__8648.13476005129$1400856848$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0121730451=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jfkelly07@gmail.com>) id 1WnqqF-0002PB-H0
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 10:53:09 -0400
Received: by mail-ie0-f172.google.com with SMTP id tp5so5177839ieb.17
 for <lttng-dev@lists.lttng.org>; Fri, 23 May 2014 07:52:58 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0121730451==
Content-Type: multipart/alternative; boundary=001a11c2c13aa0f9a804fa12626d

--001a11c2c13aa0f9a804fa12626d
Content-Type: text/plain; charset=UTF-8

Hi all,

I'm debugging a performance issue on a PPC OpenWrt distribution, running
linux 3.3.8, and I've trying to debug it with a build of the lttng software
off the master branches.  I made a slight modification to get a
cross-compile working (renaming compat/{fcntl,poll,uuid}.h to prevent
recursive inclusions), and that source works fine for an x86 target on
kernel 3.4.46.

 I've got it capturing syscalls, but nothing else.  All the drivers load
OK.  I have every tracer and probe I can find turned on:

CONFIG_KPROBES=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_NET_TCPPROBE=m
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y


Can anybody give me some hints as to where to look?

--001a11c2c13aa0f9a804fa12626d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I&#39;m debugging a performance=
 issue on a PPC OpenWrt distribution, running linux 3.3.8, and I&#39;ve try=
ing to debug it with a build of the lttng software off the master branches.=
 =C2=A0I made a slight modification to get a cross-compile working (renamin=
g compat/{fcntl,poll,uuid}.h to prevent recursive inclusions), and that sou=
rce works fine for an x86 target on kernel 3.4.46.</div>
<div><br></div><div>=C2=A0I&#39;ve got it capturing syscalls, but nothing e=
lse. =C2=A0All the drivers load OK. =C2=A0I have every tracer and probe I c=
an find turned on:</div><div><br></div><div>CONFIG_KPROBES=3Dy</div><div>CO=
NFIG_KRETPROBES=3Dy</div>
<div>CONFIG_HAVE_KPROBES=3Dy</div><div>CONFIG_HAVE_KRETPROBES=3Dy</div><div=
>CONFIG_NET_TCPPROBE=3Dm</div><div><div>CONFIG_TRACEPOINTS=3Dy</div><div>CO=
NFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy</div></div><div><div>CONFIG_KALLSYMS=3Dy<=
/div><div>
CONFIG_KALLSYMS_ALL=3Dy</div></div><div><br></div><div><br></div><div>Can a=
nybody give me some hints as to where to look?</div></div>

--001a11c2c13aa0f9a804fa12626d--


--===============0121730451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0121730451==--
