Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28826C25B74
	for <lttng-dev@archiver.kernel.org>; Thu, 16 May 2024 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715883786;
	bh=jYhxZcRjdKNnc/StNQCwmcfHcGsmC8WhXEfzPp3KR+I=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0/SfcJZliM5MN2ytVOB+PULkLF044uCStSN16lMXm1s44NfdtpOqQl2/tRttfLqKG
	 UDwzKfKg6y3DqCWyesC14ZBel/rC7VA7hl0bWjPrFzY8Z3CJmQj5atAFNoVv88mtdh
	 Z9NDRIdC9kGufnXu2Y6nRHjlBagFIImn+dl01QdZsYdEKeScG5e03dCUvjCzIfwo1O
	 s9VxVd2wQc0m0U7BRh3Dj/GaQdPLVTMKr3QaXPMe23dGGWOpEwAma/owY8n4rBYOq1
	 XAOVLfJ+gOCZyR1N9oFQVBQ4vqJbYT9pVc0SuWRohVzKLSEpzoTpQ4QpocbLEyNsaZ
	 0Il1DmJ41N+bw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VgJP53mQ5z2nrC;
	Thu, 16 May 2024 14:23:05 -0400 (EDT)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by lists.lttng.org (Postfix) with ESMTPS id 4VgJP42S5lz2nr9
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2024 14:23:03 -0400 (EDT)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6277a2bb35fso8648197b3.1
 for <lttng-dev@lists.lttng.org>; Thu, 16 May 2024 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715883783; x=1716488583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHlCpezm2uC4wBXQxWtAMNAoocMSbmdMBWrDfvHp0/Q=;
 b=PoBtSJjskwmBtO7CFfa4tW1Fu/Oz6qxHrlWY4o0G4soy8OVpXXGgfZcuZp1xUYwUIV
 91NEODynM0b4AN4tS8VcxgkbnqUWwI0nra2Hgv4G0gRYpyKzMoOvDgoCb9IF4X/HQega
 dTQ/XTWks1bDv0P/Y8gLXqe8+1zEt7fPxzrP+UcHaQ4qk7CqnQZirtrtgGNR9LOfOufA
 k80y0MVZ7ibyYx4q4L5l6JPAIHzKapI9AC9C+FJbL3GszwFTcHoU8xMRhDR5Ac0FwA0K
 FQm3mw95fidySSZS8p9SxEPOd824E6PVgD1vqxDBUOSZv0G5kluhRCvgllbm7DzhUKM+
 mUUQ==
X-Gm-Message-State: AOJu0YxkP1rvQjtGWvWvo/nQgxEC4Zlc+zfGHf32q/G1DAQNBwIRrKtt
 lC2I7CYcff6befDdX9Updl6L9uDM5buDDnlVAPSPr1mlgyNf3CJyt2SL6CDzuborCe9oDElQKTT
 gIQEt1arQUGyo6xnvak3mQfgDW7HMPRLs7KqbOg==
X-Google-Smtp-Source: AGHT+IEpyCwKcUAcDcUB3n2xpb/xdCdBSwaJmLvG9qAyCvnFn7S/xlJAgt6aQ4mt8XRnBOGCQC8BV/ZIr6GLJ+0hzRo=
X-Received: by 2002:a0d:d545:0:b0:61a:bf86:9d29 with SMTP id
 00721157ae682-620993808d8mr169017757b3.8.1715883782983; Thu, 16 May 2024
 11:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1MA5d-ah6bqoN8=_5PwTe-6h_2B0GsHzt=cVuwJANyiMDhGg@mail.gmail.com>
 <479fa8db-6d40-49c3-bb4f-8c920ab291ac@efficios.com>
 <39257e22-f657-4bba-b99d-97d4ee8789d5@efficios.com>
In-Reply-To: <39257e22-f657-4bba-b99d-97d4ee8789d5@efficios.com>
Date: Thu, 16 May 2024 11:22:52 -0700
Message-ID: <CAA1MA5e+qMEBGAtiuLPKsospQycRFFpOYKVkh66pOAvdX5TtTg@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Capturing snapshot on kernel panic
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Damien Berget via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Damien Berget <damien.berget@flyzipline.com>
Content-Type: multipart/mixed; boundary="===============7043627842448215477=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7043627842448215477==
Content-Type: multipart/alternative; boundary="0000000000005c728106189653e7"

--0000000000005c728106189653e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Kienan for these quick suggestions,
we'll investigate the pmem route (I was not aware of the lttng-cash
utility, it's pretty nice) even if I'm not sure how fast it would burn
through our SSD, it might still be worth trying.
As for kexec-tool, it's not officially supported on our embedded modules
unfortunately, so we might be SOL there. We may have to try to add our own
trace-point in kernel to use as trigger.
Cheers
Damien

On Thu, May 16, 2024 at 8:12=E2=80=AFAM Kienan Stewart <kstewart@efficios.c=
om>
wrote:

> Hi Damien,
>
> I want to expand on one of the options that could work for your case.
>
> On 5/16/24 9:37 AM, Kienan Stewart via lttng-dev wrote:
> > Hi Damien,
> >
> >
> > On 5/15/24 6:24 PM, Damien Berget via lttng-dev wrote:
> >> Good day,
> >> we have been using LTTng successfully to capture snapshots on user
> >> defined tracepoints and it did provide invaluable to debug our issues.
> >> Thanks to all the contributors of this project!
> >>
> >> We'd like to know if it would be possible to trigger on a kernel
> >> panic? I might be dubiously possible as you would still need to have
> >> the file-system working to write the results but I should ask.
> >>
> >
> > For userspace tracing, I think the recommendation is usually to use a
> > dax/pmem device and have the buffers for the session mapped there. Afte=
r
> > a panic, the contents of the buffers can be restored using
> lttng-crash[1].
> >
> > Note that dax/pem isn't supported by the kernel space tracer at this
> time.
> >
> > If I recall, there are other ways to things in the panic sequence (that
> > aren't lttng specific), but I'm personally not as familiar with the
> > details of that stage of linux.
> >
>
> It's possible to kexec-tools to load a new kernel post-panic[1]. If your
> system uses kexec, the contents of RAM aren't necessarily flushed, and
> if both the initial kernel and post-panic kernel started by kexec have
> the same configuration for an emulated PMEM device using the memmap
> paramenter [2,3] that region of memory can have a daxfs created in it
> post-clean boot.
>
> Note: some systems may not flush the memory during a warm reboot, but
> this is dependent on the BIOS.
>
> When your system boots you could do something like the following:
>
>   * If it's a clean boot, create the daxfs
>   * If it's an "unclean" boot (e.g. the daxfs already exists, or a
> kernel parameter informs you that it started post-panic) then you can
> copy/move/use lttng-crash to persistent storage for analysis
>   * Start tracing using a snapshot session and the userspace buffers on
> the daxfs.
>
> In this type of situation the "snapshot" command is never invoked
> directly, but the recovery of the buffers to create a snapshot is possibl=
e.
>
> [1]: https://www.kernel.org/doc/html/latest/admin-guide/kdump/kdump.html
> [2]:
> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> [3]:
>
> https://docs.pmem.io/persistent-memory/getting-started-guide/creating-dev=
elopment-environments/linux-environments/linux-memmap
>
> thanks,
> kienan
>
> >> Looking at available kernel syscall, the "reboot" one seems like a
> >> good candidate, however I was not able to capture a snapshot on it. I
> >> have tested the setup below with "--name=3Dchdir" syscall and it
> >> works, "cd" to a directory will create a trace. But no dice with reboo=
t.
> >>
> >
> > The details of how this work will depend on your system. For example, m=
y
> > installations tend to use systemd as PID 1. The broad strokes seem to
> > be: `/usr/sbin/reboot` is actually a link to `systemctl`, which I
> > believe then kicks off the reboot.service, the PID 1 is swapped to
> > /usr/lib/systemd/systemd-shutdown, sigterm then sigkill are sent to all
> > processes, unmounts, syncs, calls the reboot system call [2,3].
> >
> > As both the sigterm and the unmounts are done before the syscall,
> > lttng-sessiond and the consumers will have already shutdown by the time
> > it enters.
> >
> > While this doesn't necessarily help your original question of panics, i=
f
> > you want to snapshot before shutdown or reboot and are using systemd,
> > it's possible to leave a script or binary in a known directory so that
> > it's invoked prior to the rest of the shutdown sequence[4].
> >
> > [1]: https://lttng.org/docs/v2.13/#doc-persistent-memory-file-systems
> > [2]:
> >
> https://github.com/systemd/systemd/blob/6533c14997700f74e9ea42121303fc1f5=
c63e62b/src/shutdown/shutdown.c
> > [3]:
> >
> https://github.com/systemd/systemd/blob/main/src/shared/reboot-util.c#L77
> > [4]: https://www.systutorials.com/docs/linux/man/8-systemd-reboot/
> >
> > hope this helps,
> > kienan
> >
> >> Would you have any suggestions?
> >> Thanks for your help,
> >> Cheers
> >> Damien
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>
> >> # Prep output dir
> >> mkdir /application/trace/
> >> rm -rf /application/trace/*
> >>
> >> # Create session
> >> sudo lttng destroy snapshot-trace-session
> >> sudo lttng create snapshot-trace-session --snapshot
> >> --output=3D"/application/trace/"
> >> sudo lttng enable-channel --kernel --num-subbuf=3D8 channelk
> >> sudo lttng enable-channel --userspace --num-subbuf=3D8 channelu
> >>
> >> # Configure session
> >> sudo lttng enable-event --kernel --syscall --all --channel channelk
> >> sudo lttng enable-event --kernel --tracepoint "sched*" --channel
> channelk
> >> sudo lttng enable-event --userspace --all --channel channelu
> >> sudo lttng add-context -u -t vtid -t procname
> >> sudo lttng remove-trigger trig_reboot
> >> sudo lttng add-trigger --name=3Dtrig_reboot \
> >>          --condition=3Devent-rule-matches --type=3Dkernel:syscall:entr=
y \
> >>          --name=3Dreboot\
> >>          --action=3Dsnapshot-session snapshot-trace-session \
> >>          --rate-policy=3Donce-after:1
> >>
> >> # start & list info
> >> sudo lttng start
> >> sudo lttng list snapshot-trace-session
> >> sudo lttng list-triggers
> >>
> >> #=3D=3D=3D=3D=3D=3D=3D=3D test it...
> >> sudo reboot
> >>
> >> #=3D=3D=3D=3D=3D=3D=3D reconnect and Nothing :(
> >> $ ls -alu /application/trace/
> >> drwxr-xr-x    2 u  u       4096 May 15  2024 .
> >> drwxr-xr-x   10 u  u       4096 May 15  2024 ..
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--=20
*Damien Berget*

--0000000000005c728106189653e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks=C2=A0Kienan for these quick suggestions, <br>we&#39=
;ll investigate the pmem route (I was not aware of the=C2=A0lttng-cash util=
ity, it&#39;s pretty nice) even if I&#39;m not sure how fast it would burn =
through our SSD, it might still be worth=C2=A0trying.<br>As for kexec-tool,=
 it&#39;s not officially supported=C2=A0on our embedded modules unfortunate=
ly, so we might be SOL there. We may have to try to add our own trace-point=
 in kernel to use as trigger.<br>Cheers<div>Damien</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 16, 202=
4 at 8:12=E2=80=AFAM Kienan Stewart &lt;<a href=3D"mailto:kstewart@efficios=
.com">kstewart@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi Damien,<br>
<br>
I want to expand on one of the options that could work for your case.<br>
<br>
On 5/16/24 9:37 AM, Kienan Stewart via lttng-dev wrote:<br>
&gt; Hi Damien,<br>
&gt; <br>
&gt; <br>
&gt; On 5/15/24 6:24 PM, Damien Berget via lttng-dev wrote:<br>
&gt;&gt; Good day,<br>
&gt;&gt; we have been using LTTng successfully=C2=A0to capture snapshots on=
 user <br>
&gt;&gt; defined tracepoints and it did provide invaluable to debug our iss=
ues. <br>
&gt;&gt; Thanks to all the contributors of this project!<br>
&gt;&gt;<br>
&gt;&gt; We&#39;d like to know if it would be possible to trigger on a kern=
el <br>
&gt;&gt; panic? I might be dubiously possible as you would still need to ha=
ve <br>
&gt;&gt; the file-system working to write the results but I should ask.<br>
&gt;&gt;<br>
&gt; <br>
&gt; For userspace tracing, I think the recommendation is usually to use a =
<br>
&gt; dax/pmem device and have the buffers for the session mapped there. Aft=
er <br>
&gt; a panic, the contents of the buffers can be restored using lttng-crash=
[1].<br>
&gt; <br>
&gt; Note that dax/pem isn&#39;t supported by the kernel space tracer at th=
is time.<br>
&gt; <br>
&gt; If I recall, there are other ways to things in the panic sequence (tha=
t <br>
&gt; aren&#39;t lttng specific), but I&#39;m personally not as familiar wit=
h the <br>
&gt; details of that stage of linux.<br>
&gt; <br>
<br>
It&#39;s possible to kexec-tools to load a new kernel post-panic[1]. If you=
r <br>
system uses kexec, the contents of RAM aren&#39;t necessarily flushed, and =
<br>
if both the initial kernel and post-panic kernel started by kexec have <br>
the same configuration for an emulated PMEM device using the memmap <br>
paramenter [2,3] that region of memory can have a daxfs created in it <br>
post-clean boot.<br>
<br>
Note: some systems may not flush the memory during a warm reboot, but <br>
this is dependent on the BIOS.<br>
<br>
When your system boots you could do something like the following:<br>
<br>
=C2=A0 * If it&#39;s a clean boot, create the daxfs<br>
=C2=A0 * If it&#39;s an &quot;unclean&quot; boot (e.g. the daxfs already ex=
ists, or a <br>
kernel parameter informs you that it started post-panic) then you can <br>
copy/move/use lttng-crash to persistent storage for analysis<br>
=C2=A0 * Start tracing using a snapshot session and the userspace buffers o=
n <br>
the daxfs.<br>
<br>
In this type of situation the &quot;snapshot&quot; command is never invoked=
 <br>
directly, but the recovery of the buffers to create a snapshot is possible.=
<br>
<br>
[1]: <a href=3D"https://www.kernel.org/doc/html/latest/admin-guide/kdump/kd=
ump.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/h=
tml/latest/admin-guide/kdump/kdump.html</a><br>
[2]: <br>
<a href=3D"https://www.kernel.org/doc/html/latest/admin-guide/kernel-parame=
ters.html" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/=
html/latest/admin-guide/kernel-parameters.html</a><br>
[3]: <br>
<a href=3D"https://docs.pmem.io/persistent-memory/getting-started-guide/cre=
ating-development-environments/linux-environments/linux-memmap" rel=3D"nore=
ferrer" target=3D"_blank">https://docs.pmem.io/persistent-memory/getting-st=
arted-guide/creating-development-environments/linux-environments/linux-memm=
ap</a><br>
<br>
thanks,<br>
kienan<br>
<br>
&gt;&gt; Looking at available kernel syscall, the &quot;reboot&quot; one se=
ems like a <br>
&gt;&gt; good candidate, however I was not able to capture a snapshot on it=
. I <br>
&gt;&gt; have tested the setup below with &quot;--name=3Dchdir&quot; syscal=
l and it <br>
&gt;&gt; works,=C2=A0&quot;cd&quot; to a directory will=C2=A0create a trace=
. But no dice with reboot.<br>
&gt;&gt;<br>
&gt; <br>
&gt; The details of how this work will depend on your system. For example, =
my <br>
&gt; installations tend to use systemd as PID 1. The broad strokes seem to =
<br>
&gt; be: `/usr/sbin/reboot` is actually a link to `systemctl`, which I <br>
&gt; believe then kicks off the reboot.service, the PID 1 is swapped to <br=
>
&gt; /usr/lib/systemd/systemd-shutdown, sigterm then sigkill are sent to al=
l <br>
&gt; processes, unmounts, syncs, calls the reboot system call [2,3].<br>
&gt; <br>
&gt; As both the sigterm and the unmounts are done before the syscall, <br>
&gt; lttng-sessiond and the consumers will have already shutdown by the tim=
e <br>
&gt; it enters.<br>
&gt; <br>
&gt; While this doesn&#39;t necessarily help your original question of pani=
cs, if <br>
&gt; you want to snapshot before shutdown or reboot and are using systemd, =
<br>
&gt; it&#39;s possible to leave a script or binary in a known directory so =
that <br>
&gt; it&#39;s invoked prior to the rest of the shutdown sequence[4].<br>
&gt; <br>
&gt; [1]: <a href=3D"https://lttng.org/docs/v2.13/#doc-persistent-memory-fi=
le-systems" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.=
13/#doc-persistent-memory-file-systems</a><br>
&gt; [2]: <br>
&gt; <a href=3D"https://github.com/systemd/systemd/blob/6533c14997700f74e9e=
a42121303fc1f5c63e62b/src/shutdown/shutdown.c" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/systemd/systemd/blob/6533c14997700f74e9ea421213=
03fc1f5c63e62b/src/shutdown/shutdown.c</a><br>
&gt; [3]: <br>
&gt; <a href=3D"https://github.com/systemd/systemd/blob/main/src/shared/reb=
oot-util.c#L77" rel=3D"noreferrer" target=3D"_blank">https://github.com/sys=
temd/systemd/blob/main/src/shared/reboot-util.c#L77</a><br>
&gt; [4]: <a href=3D"https://www.systutorials.com/docs/linux/man/8-systemd-=
reboot/" rel=3D"noreferrer" target=3D"_blank">https://www.systutorials.com/=
docs/linux/man/8-systemd-reboot/</a><br>
&gt; <br>
&gt; hope this helps,<br>
&gt; kienan<br>
&gt; <br>
&gt;&gt; Would you have any suggestions?<br>
&gt;&gt; Thanks for your help,<br>
&gt;&gt; Cheers<br>
&gt;&gt; Damien<br>
&gt;&gt;<br>
&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;<br>
&gt;&gt; # Prep output dir<br>
&gt;&gt; mkdir /application/trace/<br>
&gt;&gt; rm -rf /application/trace/*<br>
&gt;&gt;<br>
&gt;&gt; # Create session<br>
&gt;&gt; sudo lttng destroy snapshot-trace-session<br>
&gt;&gt; sudo lttng create snapshot-trace-session --snapshot <br>
&gt;&gt; --output=3D&quot;/application/trace/&quot;<br>
&gt;&gt; sudo lttng enable-channel --kernel --num-subbuf=3D8 channelk<br>
&gt;&gt; sudo lttng enable-channel --userspace --num-subbuf=3D8 channelu<br=
>
&gt;&gt;<br>
&gt;&gt; # Configure session<br>
&gt;&gt; sudo lttng enable-event --kernel --syscall --all --channel channel=
k<br>
&gt;&gt; sudo lttng enable-event --kernel --tracepoint &quot;sched*&quot; -=
-channel channelk<br>
&gt;&gt; sudo lttng enable-event --userspace --all --channel channelu<br>
&gt;&gt; sudo lttng add-context -u -t vtid -t procname<br>
&gt;&gt; sudo lttng remove-trigger trig_reboot<br>
&gt;&gt; sudo lttng add-trigger --name=3Dtrig_reboot \<br>
&gt;&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 --condition=3Devent-rule-matches=
 --type=3Dkernel:syscall:entry \<br>
&gt;&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 --name=3Dreboot\<br>
&gt;&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 --action=3Dsnapshot-session snap=
shot-trace-session \<br>
&gt;&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 --rate-policy=3Donce-after:1<br>
&gt;&gt;<br>
&gt;&gt; # start &amp; list info<br>
&gt;&gt; sudo lttng start<br>
&gt;&gt; sudo lttng list snapshot-trace-session<br>
&gt;&gt; sudo lttng list-triggers<br>
&gt;&gt;<br>
&gt;&gt; #=3D=3D=3D=3D=3D=3D=3D=3D test it...<br>
&gt;&gt; sudo reboot<br>
&gt;&gt;<br>
&gt;&gt; #=3D=3D=3D=3D=3D=3D=3D reconnect and=C2=A0Nothing :(<br>
&gt;&gt; $ ls -alu /application/trace/<br>
&gt;&gt; drwxr-xr-x =C2=A0 =C2=A02 u =C2=A0u =C2=A0 =C2=A0 =C2=A0 4096 May =
15 =C2=A02024 .<br>
&gt;&gt; drwxr-xr-x =C2=A0 10 u =C2=A0u =C2=A0 =C2=A0 =C2=A0 4096 May 15 =
=C2=A02024 ..<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">ltt=
ng-dev@lists.lttng.org</a><br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev</a><br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><b>Damien Berget</b></div></div>

--0000000000005c728106189653e7--

--===============7043627842448215477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7043627842448215477==--
