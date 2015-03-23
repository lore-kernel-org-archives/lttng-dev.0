From: Rui Han <iurnah@gmail.com>
Subject: Re: How to compile lttng-modules using full kernel
	source tree.
Date: Mon, 23 Mar 2015 10:19:47 -0400
Message-ID: <CABy43G8ONcEa1vxQ1ZwcODqvJg4yfxj8eDY=tnxDFBXYaBY+kQ__20222.4789573394$1427120472$gmane$org@mail.gmail.com>
References: <CABy43G9szQBY9eObtid3D0nDTBxm-50dSbT73MT-v_ac+4n9Tw@mail.gmail.com>
 <550C3074.2010409@efficios.com>
 <1333465971.74742.1427118171635.JavaMail.zimbra@efficios.com>
 <CABy43G-k3HjEC00Z+=-P58qNkbEOu1WCpmSqORarUqAStFMZmA@mail.gmail.com>
 <180643826.77453.1427119778110.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1166014250=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <iurnah@gmail.com>) id 1Ya3Cr-00082O-0P
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 10:19:55 -0400
Received: by igcqo1 with SMTP id qo1so39608088igc.0
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2015 07:19:47 -0700 (PDT)
In-Reply-To: <180643826.77453.1427119778110.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1166014250==
Content-Type: multipart/alternative; boundary=001a113f9ae4c0a6420511f55ba1

--001a113f9ae4c0a6420511f55ba1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you Mathieu.

Regards,
Rui

On Mon, Mar 23, 2015 at 10:09 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Please refer to:
>
> http://lttng.org/docs/#doc-building-from-source
> which points to:
> https://github.com/lttng/lttng-modules/blob/master/README.md
>
> Thanks,
>
> Mathieu
>
> ----- Original Message -----
>
> > Hi Mathieu,
> > Thank you very much for your reply.
> > Where in make file can I specify the full kernel source path? I found t=
he
> > following makefile snippet but I cannot locate where the $(srctree)
> variable
> > is initialized. Could you please give me some insight or point to the
> > related material? Thank you very much.
> > ifneq ($(CONFIG_EXT4_FS),) ext4_dep =3D $(srctree) /fs/ext4/*.h ext4 =
=3D
> > lttng-probe-ext4.o
> > ifeq ($(wildcard $(ext4_dep)),) $(warning Files $(ext4_dep) not found.
> Probe
> > "ext4" is disabled. Use full kernel source tree to enable it.) ext4 =3D
> > endif
> > obj-m +=3D $(ext4)
> > endif
>
> > Regards,
> > Rui
> > On Mon, Mar 23, 2015 at 9:42 AM, Mathieu Desnoyers <
> > mathieu.desnoyers@efficios.com > wrote:
>
> > > > Hey,
> > >
> >
> > > > See comments below.
> > >
> >
>
> > > > On 2015-03-20 09:34 AM, Rui Han wrote:
> > >
> >
>
> > > > > Hi,
> > > >
> > >
> >
> > > > > I have encountered following output when I try to run make from t=
he
> > > > > lttng-modules source cloned from git repo. I have tried in a clea=
n
> > > > > install
> > > > > of both 12.04 and 14.04.
> > > >
> > >
> >
> > > > > make -C /lib/modules/3.13.0-45-generic/build
> > > > > M=3D/home/troguard32/lttng/lttng-modules modules
> > > >
> > >
> >
> > > > > make[1]: Entering directory
> `/usr/src/linux-headers-3.13.0-45-generic'
> > > >
> > >
> >
> > > > > /home/troguard32/lttng/lttng-modules/probes/Makefile:30: File
> > > > > /usr/src/linux-headers-3.13.0-45-generic/virt/kvm/iodev.h not
> found.
> > > > > Probe
> > > > > "kvm" x86-specific is disabled. Use full kernel source tree to
> enable
> > > > > it.
> > > >
> > >
> >
> > > > > /home/troguard32/lttng/lttng-modules/probes/Makefile:142: Files
> > > > > /usr/src/linux-headers-3.13.0-45-generic/fs/btrfs/*.h not found.
> Probe
> > > > > "btrfs" is disabled. Use full kernel source tree to enable it.
> > > >
> > >
> >
> > > > > /home/troguard32/lttng/lttng-modules/probes/Makefile:158: Files
> > > > > /usr/src/linux-headers-3.13.0-45-generic/fs/ext4/*.h not found.
> Probe
> > > > > "ext4"
> > > > > is disabled. Use full kernel source tree to enable it.
> > > >
> > >
> >
> > > > > Building modules, stage 2.
> > > >
> > >
> >
> > > > > MODPOST 43 modules
> > > >
> > >
> >
> > > > > make[1]: Leaving directory
> `/usr/src/linux-headers-3.13.0-45-generic'
> > > >
> > >
> >
>
> > > > > when run make modules_install, it seem the installation is
> successful,
> > > > > but
> > > > > the output is abnormal, giving repeated =E2=80=9CCan=E2=80=99t re=
ad private key=E2=80=9D
> > > > > messages.
> > > >
> > >
> >
> > > > > If I ignore this message and install all other lttng components, =
it
> > > > > seems
> > > > > lttng kernel tracer is working fine.
> > > >
> > >
> >
> > > > > My question is,
> > > >
> > >
> >
>
> > > > > 1. How to completely remove this abnormal message? where to
> specify the
> > > > > full
> > > > > kernel source path in make file? (I am a makefile beginner)
> > > >
> > >
> >
>
> > > > Abnormal message being the key related one? We are looking into but
> this
> > > > does
> > > > not in any way change behavior.
> > >
> >
> > > It's because you are building against your distribution kernel, for
> which
> >
> > > only your distribution has the signing key. Therefore, the build
> complains
> >
> > > that the modules are not signed. But since your distro kernel allows
> >
> > > loading unsigned modules, it works fine, but outputs a warning.
> >
>
> > > > As for the warning for kvm/btrfs/ext4. Nothing to worry about you
> simply
> > > > don't have these components installed on your system.
> > >
> >
> > > A small correction: you may have kvm/btrfs/ext4 on your system.
> However,
> > > lttng-modules
> >
> > > is letting you know that it cannot build the probes to attach to thos=
e
> > > subsystem, because
> >
> > > you build against the installed kernel headers, rather than against t=
he
> > > full
> > > kernel source tree.
> >
> > > This is because those subsystem place their instrumentation headers
> into
> > > subdirectories of
> >
> > > the Linux kernel tree that are not installed on the system.
> >
>
> > > Thanks,
> >
>
> > > Mathieu
> >
>
> > > > > 1. How to check whether the lttng-modules installed is fully
> functional
> > > > > or
> > > > > not?
> > > >
> > >
> >
>
> > > > A quick check is the one you probably did: lttng list -k. You can
> also
> > > > run
> > > > the root_regression tests from lttng-tools. Under ./tests you can r=
un
> > > > ./run.sh root_regression while being root.
> > >
> >
>
> > > > > 1. Does the above message is just telling me that I will be able
> to use
> > > > > the
> > > > > full function of lttng-modules except those file system probe
> mentioned
> > > > > in
> > > > > the make output?
> > > >
> > >
> >
>
> > > > Exactly.
> > >
> >
>
> > > > > Thank you very much.
> > > >
> > >
> >
> > > > > Best regards,
> > > >
> > >
> >
> > > > > Rui
> > > >
> > >
> >
> > > > > =E2=80=8B
> > > >
> > >
> >
>
> > > > > _______________________________________________
> > > >
> > >
> >
> > > > > lttng-dev mailing list lttng-dev@lists.lttng.org
> > > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > > >
> > >
> >
>
> > > > --
> > >
> >
> > > > Jonathan R. Julien
> > >
> >
> > > > Efficios
> > >
> >
>
> > > > _______________________________________________
> > >
> >
> > > > lttng-dev mailing list
> > >
> >
> > > > lttng-dev@lists.lttng.org
> > >
> >
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> >
>
> > > --
> >
> > > Mathieu Desnoyers
> >
> > > EfficiOS Inc.
> >
> > > http://www.efficios.com
> >
>
> > =E2=80=8B
>
> --
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a113f9ae4c0a6420511f55ba1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Mathieu.<div><br></div><div>Regards,</div><div>R=
ui</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Mon, Mar 23, 2015 at 10:09 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.des=
noyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Please refer to:<br>
<br>
<a href=3D"http://lttng.org/docs/#doc-building-from-source" target=3D"_blan=
k">http://lttng.org/docs/#doc-building-from-source</a><br>
which points to:<br>
<a href=3D"https://github.com/lttng/lttng-modules/blob/master/README.md" ta=
rget=3D"_blank">https://github.com/lttng/lttng-modules/blob/master/README.m=
d</a><br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<span class=3D""><br>
----- Original Message -----<br>
<br>
&gt; Hi Mathieu,<br>
&gt; Thank you very much for your reply.<br>
&gt; Where in make file can I specify the full kernel source path? I found =
the<br>
&gt; following makefile snippet but I cannot locate where the $(srctree) va=
riable<br>
&gt; is initialized. Could you please give me some insight or point to the<=
br>
&gt; related material? Thank you very much.<br>
</span>&gt; ifneq ($(CONFIG_EXT4_FS),) ext4_dep =3D $(srctree) /fs/ext4/*.h=
 ext4 =3D<br>
<span class=3D"">&gt; lttng-probe-ext4.o<br>
&gt; ifeq ($(wildcard $(ext4_dep)),) $(warning Files $(ext4_dep) not found.=
 Probe<br>
&gt; &quot;ext4&quot; is disabled. Use full kernel source tree to enable it=
.) ext4 =3D<br>
&gt; endif<br>
&gt; obj-m +=3D $(ext4)<br>
&gt; endif<br>
<br>
&gt; Regards,<br>
&gt; Rui<br>
&gt; On Mon, Mar 23, 2015 at 9:42 AM, Mathieu Desnoyers &lt;<br>
&gt; <a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@ef=
ficios.com</a> &gt; wrote:<br>
<br>
</span><div><div class=3D"h5">&gt; &gt; &gt; Hey,<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; See comments below.<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; On 2015-03-20 09:34 AM, Rui Han wrote:<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; I have encountered following output when I try to run m=
ake from the<br>
&gt; &gt; &gt; &gt; lttng-modules source cloned from git repo. I have tried=
 in a clean<br>
&gt; &gt; &gt; &gt; install<br>
&gt; &gt; &gt; &gt; of both 12.04 and 14.04.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; make -C /lib/modules/3.13.0-45-generic/build<br>
&gt; &gt; &gt; &gt; M=3D/home/troguard32/lttng/lttng-modules modules<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; make[1]: Entering directory `/usr/src/linux-headers-3.1=
3.0-45-generic&#39;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; /home/troguard32/lttng/lttng-modules/probes/Makefile:30=
: File<br>
&gt; &gt; &gt; &gt; /usr/src/linux-headers-3.13.0-45-generic/virt/kvm/iodev=
.h not found.<br>
&gt; &gt; &gt; &gt; Probe<br>
&gt; &gt; &gt; &gt; &quot;kvm&quot; x86-specific is disabled. Use full kern=
el source tree to enable<br>
&gt; &gt; &gt; &gt; it.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; /home/troguard32/lttng/lttng-modules/probes/Makefile:14=
2: Files<br>
&gt; &gt; &gt; &gt; /usr/src/linux-headers-3.13.0-45-generic/fs/btrfs/*.h n=
ot found. Probe<br>
&gt; &gt; &gt; &gt; &quot;btrfs&quot; is disabled. Use full kernel source t=
ree to enable it.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; /home/troguard32/lttng/lttng-modules/probes/Makefile:15=
8: Files<br>
&gt; &gt; &gt; &gt; /usr/src/linux-headers-3.13.0-45-generic/fs/ext4/*.h no=
t found. Probe<br>
&gt; &gt; &gt; &gt; &quot;ext4&quot;<br>
&gt; &gt; &gt; &gt; is disabled. Use full kernel source tree to enable it.<=
br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; Building modules, stage 2.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; MODPOST 43 modules<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; make[1]: Leaving directory `/usr/src/linux-headers-3.13=
.0-45-generic&#39;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; &gt; when run make modules_install, it seem the installation=
 is successful,<br>
&gt; &gt; &gt; &gt; but<br>
&gt; &gt; &gt; &gt; the output is abnormal, giving repeated =E2=80=9CCan=E2=
=80=99t read private key=E2=80=9D<br>
&gt; &gt; &gt; &gt; messages.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; If I ignore this message and install all other lttng co=
mponents, it<br>
&gt; &gt; &gt; &gt; seems<br>
&gt; &gt; &gt; &gt; lttng kernel tracer is working fine.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; My question is,<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</div></div>&gt; &gt; &gt; &gt; 1. How to completely remove this abnormal m=
essage? where to specify the<br>
<span class=3D"">&gt; &gt; &gt; &gt; full<br>
&gt; &gt; &gt; &gt; kernel source path in make file? (I am a makefile begin=
ner)<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; Abnormal message being the key related one? We are looking i=
nto but this<br>
&gt; &gt; &gt; does<br>
&gt; &gt; &gt; not in any way change behavior.<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; It&#39;s because you are building against your distribution kerne=
l, for which<br>
&gt;<br>
&gt; &gt; only your distribution has the signing key. Therefore, the build =
complains<br>
&gt;<br>
&gt; &gt; that the modules are not signed. But since your distro kernel all=
ows<br>
&gt;<br>
&gt; &gt; loading unsigned modules, it works fine, but outputs a warning.<b=
r>
&gt;<br>
<br>
&gt; &gt; &gt; As for the warning for kvm/btrfs/ext4. Nothing to worry abou=
t you simply<br>
&gt; &gt; &gt; don&#39;t have these components installed on your system.<br=
>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; A small correction: you may have kvm/btrfs/ext4 on your system. H=
owever,<br>
&gt; &gt; lttng-modules<br>
&gt;<br>
&gt; &gt; is letting you know that it cannot build the probes to attach to =
those<br>
&gt; &gt; subsystem, because<br>
&gt;<br>
&gt; &gt; you build against the installed kernel headers, rather than again=
st the<br>
&gt; &gt; full<br>
&gt; &gt; kernel source tree.<br>
&gt;<br>
&gt; &gt; This is because those subsystem place their instrumentation heade=
rs into<br>
&gt; &gt; subdirectories of<br>
&gt;<br>
&gt; &gt; the Linux kernel tree that are not installed on the system.<br>
&gt;<br>
<br>
&gt; &gt; Thanks,<br>
&gt;<br>
<br>
&gt; &gt; Mathieu<br>
&gt;<br>
<br>
</span>&gt; &gt; &gt; &gt; 1. How to check whether the lttng-modules instal=
led is fully functional<br>
<span class=3D"">&gt; &gt; &gt; &gt; or<br>
&gt; &gt; &gt; &gt; not?<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; A quick check is the one you probably did: lttng list -k. Yo=
u can also<br>
&gt; &gt; &gt; run<br>
&gt; &gt; &gt; the root_regression tests from lttng-tools. Under ./tests yo=
u can run<br>
&gt; &gt; &gt; ./run.sh root_regression while being root.<br>
&gt; &gt;<br>
&gt;<br>
<br>
</span>&gt; &gt; &gt; &gt; 1. Does the above message is just telling me tha=
t I will be able to use<br>
<span class=3D"">&gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; full function of lttng-modules except those file system=
 probe mentioned<br>
&gt; &gt; &gt; &gt; in<br>
&gt; &gt; &gt; &gt; the make output?<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; Exactly.<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; &gt; Thank you very much.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; Best regards,<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; Rui<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; =E2=80=8B<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; &gt; lttng-dev mailing list <a href=3D"mailto:lttng-dev@list=
s.lttng.org">lttng-dev@lists.lttng.org</a><br>
&gt; &gt; &gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev</a><br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; --<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; Jonathan R. Julien<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; Efficios<br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; lttng-dev mailing list<br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a><br>
&gt; &gt;<br>
&gt;<br>
&gt; &gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br>
&gt; &gt;<br>
&gt;<br>
<br>
&gt; &gt; --<br>
&gt;<br>
&gt; &gt; Mathieu Desnoyers<br>
&gt;<br>
&gt; &gt; EfficiOS Inc.<br>
&gt;<br>
&gt; &gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.=
efficios.com</a><br>
&gt;<br>
<br>
&gt; =E2=80=8B<br>
<br>
</span>--<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--001a113f9ae4c0a6420511f55ba1--


--===============1166014250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1166014250==--
