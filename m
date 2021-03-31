Return-Path: <SRS0=91P6=I5=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6EC433ED
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:56:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D982A60FE8
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D982A60FE8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F9YsY19w4zSLq;
	Wed, 31 Mar 2021 13:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617213393;
	bh=Sk9i6V5dd8IMM/qIvJePrCAznKBxGM5gq81Ga/kl1dM=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bk6C+ESBF4vj+Hxp4hyLN9ROBstoUlJ5OQ+H7riP+vsEjDJRZGTxKYQBQpHtO2j3d
	 LNhO5ZSXO7gXYsEFzuOGk3LUBgbjfljSEeSXN9j5A102Df902eBxTJoEPdBZuZCBtz
	 ZhLsi0s1/csLjQ7gHrO0b1SfSC0XZamX4PDSU+0fJouGg+KGr7GN2DqPOp4Siha1tB
	 iDA87EBiIHvegK70g9vpzQmUWxmEPa5kiMGcdLez6GPBR9DStGQrb591sRIE51YECS
	 BjmEKK88OzB4bCjybZD/VYhvqR5Dry0glWxW7n9p1fkC+eEXlEk64nqvhzfybOG8Dy
	 7WUkVuyh0yDog==
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 4F9YsW2qyMzRX0
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 13:56:31 -0400 (EDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so24909595lju.7
 for <lttng-dev@lists.lttng.org>; Wed, 31 Mar 2021 10:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3xX2MHnr9GE96CnVFoPEiNXsCpy0qdanYxhKkcqnGiw=;
 b=p28dqrmHWaO2xKcXMj62UidB+CVBJaHR99TfoB3oLPyAzglF0Gtsir/fI2GCqUR2QK
 Tj0cJr0RMZ7yWYxKVJMoU/34PaRPuxEyZrsUgdVENI8Q7ZPPT2tdXp8794i2ZnstEZPK
 8ieyGdN4SHDgFWf7LygNNeknmjq1ezwvgQ/7MmSAKHjkod8Djof0qUmNTZqgtYv7l6Dr
 V7msctM3VaNzzbyeXAAHPPe5CJ0hVEICjIyQ+HuFLw3DZ7YKMbSGXxlujItjm4Ucoh2C
 SfYINOb/FhjtkoSrCIJloUAJnDbjw9exf2mBzWjqR2xac7Hk8D6UK74jXQ9DAwYXo6OA
 dO7g==
X-Gm-Message-State: AOAM532kRiaNthUP+e/60PUYWtPAXhUTGa+1ScTo1NRnUqZ56B6R6z3B
 FlW+Ex6oe+sKZW9NHNKPo6VbzuFdaSFclFEATMU=
X-Google-Smtp-Source: ABdhPJyLU0LQMMZIxbxhCuJjPKzy3aEQEjKbpv0P6vcgSzjkDxY1wBZB/OwnmbrMMVKNmeKG6FbZqVlC5PHKrzOqlNQ=
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr2745438ljo.411.1617213389792; 
 Wed, 31 Mar 2021 10:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFGSPrw1Ev1c+Ok7tvyzEJOQNDze6fbpzNKFzmH=9hSVYGF69A@mail.gmail.com>
 <20210331174201.GB28307@joraj-alpa>
In-Reply-To: <20210331174201.GB28307@joraj-alpa>
Date: Wed, 31 Mar 2021 12:55:53 -0500
Message-ID: <CAFGSPrwf1EtwuON3J=T6efyL0OLy6ZxqQWOYnwxLwJT88TBiXg@mail.gmail.com>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Can't trace function calls
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Ramesh Errabolu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Content-Type: multipart/mixed; boundary="===============2471159736815172805=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2471159736815172805==
Content-Type: multipart/alternative; boundary="0000000000009fead705bed8d52c"

--0000000000009fead705bed8d52c
Content-Type: text/plain; charset="UTF-8"

Thanks for the quick response, appreciate it.

At a high level this is what I did.

   1. reboot
   2. login as sudo
   3. set LD_LIBRARY_PATH to point to right locations
   4. ldd of executable to show right library versions are picked up
   5. execute the workload by specifiy LD_PRELOAD env variable
   6. expect to see a trace file in my $HOME/ltt* directory

When I say *FAIL*, I mean that there was no trace file in my home directory
~/lttng*

I read - https://lttng.org/man/3/lttng-ust-cyg-profile/v2.12/
I didn't read - https://lttng.org/docs/v2.12/#doc-liblttng-ust-cyg-profile

I have not run any lttng commands besides what I already gave. If they are
needed, I don't know what they are.

I tried experimenting with lttng commands create and list. The command to
list "traceable" points returned an error as included below.

root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ls ~/ | grep -i ltt
root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# lttng create
my-kernel-session --output=~/my-kernel-trace
Session my-kernel-session created.
Traces will be output to
/home/user1/git/compute/out/ubuntu-18.04/18.04/bin/~/my-kernel-trace
root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# *lttng list
--kerne*l
*Error: Unable to list kernel events: Kernel tracer not available*
root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#


A grep for lttng related processes shows me a daemon service running.

root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ps -ef | grep ltt
root      1002     1  0 12:16 ?        00:00:00 /usr/bin/lttng-sessiond
root      1054  1002  0 12:16 ?        00:00:00 */usr/bin/lttng-sessiond*
root      3145  2861  0 12:51 pts/0    00:00:00 grep --color=auto ltt
root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#


Regards,
Ramesh


On Wed, Mar 31, 2021 at 12:42 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Wed, Mar 31, 2021 at 10:51:03AM -0500, Ramesh Errabolu via lttng-dev
> wrote:
> > I am trying to capture the list of functions being called by an app. The
> > app relies on a couple of shared libraries (libhsa-runtime64.so and
> > libhsakmt.so).
>
> ok.
>
> >
> > My experiments all *FAIL *i.e. there are no log files of the output.
>
> Not sure what you mean here. But let's continue first.
>
> > The
> > link on lttng-ust-cyg-profile does not tell me where I can get them.
>
> Could you share the "link" in question?
>
> > Instrument the build files for the two libraries to allow function
> tracing
> > by the gcc/clang flags -finstrument-functions and run workload as follows
> >
> >    - Instrument the build files for the two libraries to allow function
> >    tracing by the gcc/clang flags *-finstrument-functions* and run
> workload
> >    as follows
>
> Okai. I expect that you have read this:
> https://lttng.org/docs/v2.12/#doc-liblttng-ust-cyg-profile
>
> and this
> https://lttng.org/man/3/lttng-ust-cyg-profile/v2.12/
>
> > I am using LTTng version Ubuntu: LTTng Stable 2.12 PPA
> >
> >    - apt-get install lttng-tools
> >    - apt-get install lttng-modules-dkms
> >    - apt-get install liblttng-ust-dev
> >
>
> Looks good.
>
> > I noticed no kernel modules with substring "ltt" in it.
>
> Okai so this is where we need much more information.
>
> First of all, what are the lttng commands used for your experiments?
> (lttng create, lttng enable-channel, lttng enable-event...)
> Please provide a sample script of your experiments.
>
> Second, you are mostly performing userspace tracing here, lttng-modules (
> the
> kernel tracer) might not even be needed here unless you also want to do
> kernel
> tracing.
>
> What do you mean by "there are no log files of the output."? LTTng produces
> traces encoded in CTF (Common Trace Format) that must be read by a reader
> (Babeltrace most of the time).
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000009fead705bed8d52c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Thanks for the quick response, appreciate it.</div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br></div><div =
class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">At a high =
level this is what I did.</div><div class=3D"gmail_default" style=3D"font-f=
amily:verdana,sans-serif"><ol><li>reboot</li><li>login as sudo</li><li>set =
LD_LIBRARY_PATH to point to right locations</li><li>ldd of executable to sh=
ow right library versions are picked up</li><li>execute the workload by spe=
cifiy LD_PRELOAD env variable</li><li>expect to see a trace file in my $HOM=
E/ltt* directory</li></ol></div><div class=3D"gmail_default" style=3D"font-=
family:verdana,sans-serif">When I say <b>FAIL</b>, I mean that there was no=
 trace file in my home directory ~/lttng*</div><div class=3D"gmail_default"=
 style=3D"font-family:verdana,sans-serif"><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:verdana,sans-serif">I read -=C2=A0<a href=3D"htt=
ps://lttng.org/man/3/lttng-ust-cyg-profile/v2.12/">https://lttng.org/man/3/=
lttng-ust-cyg-profile/v2.12/</a></div><div class=3D"gmail_default" style=3D=
"font-family:verdana,sans-serif">I didn&#39;t read -=C2=A0<a href=3D"https:=
//lttng.org/docs/v2.12/#doc-liblttng-ust-cyg-profile">https://lttng.org/doc=
s/v2.12/#doc-liblttng-ust-cyg-profile</a></div><div class=3D"gmail_default"=
 style=3D"font-family:verdana,sans-serif"><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:verdana,sans-serif">I have not run any lttng com=
mands besides what I already gave. If they are needed, I don&#39;t know wha=
t they are.</div><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:ver=
dana,sans-serif">I tried experimenting with lttng commands create and list.=
 The command to list &quot;traceable&quot; points returned an error as incl=
uded below.</div><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif"><br></div><blockquote style=3D"margin:0 0 0 40px;border:none;pa=
dding:0px"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-s=
erif"><font color=3D"#0b5394">root@RocrLnx23:~/git/compute/out/ubuntu-18.04=
/18.04/bin# ls ~/ | grep -i ltt</font></div><div class=3D"gmail_default" st=
yle=3D"font-family:verdana,sans-serif"><font color=3D"#0b5394">root@RocrLnx=
23:~/git/compute/out/ubuntu-18.04/18.04/bin# lttng create my-kernel-session=
 --output=3D~/my-kernel-trace</font></div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif"><font color=3D"#0b5394">Session my-ker=
nel-session created.</font></div><div class=3D"gmail_default" style=3D"font=
-family:verdana,sans-serif"><font color=3D"#0b5394">Traces will be output t=
o /home/user1/git/compute/out/ubuntu-18.04/18.04/bin/~/my-kernel-trace</fon=
t></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-seri=
f"><font color=3D"#0b5394">root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18=
.04/bin# <b>lttng list --kerne</b>l</font></div><div class=3D"gmail_default=
" style=3D"font-family:verdana,sans-serif"><font color=3D"#0b5394"><b>Error=
: Unable to list kernel events: Kernel tracer not available</b></font></div=
><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><fon=
t color=3D"#0b5394">root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin=
#=C2=A0</font></div></blockquote><div class=3D"gmail_default" style=3D"font=
-family:verdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D=
"font-family:verdana,sans-serif">A grep for lttng related processes shows m=
e a daemon service running.</div><div class=3D"gmail_default" style=3D"font=
-family:verdana,sans-serif"><br></div><blockquote style=3D"margin:0 0 0 40p=
x;border:none;padding:0px"><div class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif"><font color=3D"#0b5394">root@RocrLnx23:~/git/compute/=
out/ubuntu-18.04/18.04/bin# ps -ef | grep ltt</font></div><div class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif"><font color=3D"#0b5394=
">root =C2=A0 =C2=A0 =C2=A01002 =C2=A0 =C2=A0 1 =C2=A00 12:16 ? =C2=A0 =C2=
=A0 =C2=A0 =C2=A000:00:00 /usr/bin/lttng-sessiond</font></div><div class=3D=
"gmail_default" style=3D"font-family:verdana,sans-serif"><font color=3D"#0b=
5394">root =C2=A0 =C2=A0 =C2=A01054 =C2=A01002 =C2=A00 12:16 ? =C2=A0 =C2=
=A0 =C2=A0 =C2=A000:00:00 <b>/usr/bin/lttng-sessiond</b></font></div><div c=
lass=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><font color=
=3D"#0b5394">root =C2=A0 =C2=A0 =C2=A03145 =C2=A02861 =C2=A00 12:51 pts/0 =
=C2=A0 =C2=A000:00:00 grep --color=3Dauto ltt</font></div><div class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif"><font color=3D"#0b5394=
">root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#</font>=C2=A0</di=
v></blockquote><div class=3D"gmail_default" style=3D"font-family:verdana,sa=
ns-serif"><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-sm=
artmail=3D"gmail_signature">Regards,<div>Ramesh</div></div></div><br></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Mar 31, 2021 at 12:42 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jo=
nathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,=
<br>
<br>
On Wed, Mar 31, 2021 at 10:51:03AM -0500, Ramesh Errabolu via lttng-dev wro=
te:<br>
&gt; I am trying to capture the list of functions being called by an app. T=
he<br>
&gt; app relies on a couple of shared libraries (libhsa-runtime64.so and<br=
>
&gt; libhsakmt.so).<br>
<br>
ok.<br>
<br>
&gt; <br>
&gt; My experiments all *FAIL *i.e. there are no log files of the output.<b=
r>
<br>
Not sure what you mean here. But let&#39;s continue first. <br>
<br>
&gt; The<br>
&gt; link on lttng-ust-cyg-profile does not tell me where I can get them.<b=
r>
<br>
Could you share the &quot;link&quot; in question?<br>
<br>
&gt; Instrument the build files for the two libraries to allow function tra=
cing<br>
&gt; by the gcc/clang flags -finstrument-functions and run workload as foll=
ows<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - Instrument the build files for the two libraries to all=
ow function<br>
&gt;=C2=A0 =C2=A0 tracing by the gcc/clang flags *-finstrument-functions* a=
nd run workload<br>
&gt;=C2=A0 =C2=A0 as follows<br>
<br>
Okai. I expect that you have read this:<br>
<a href=3D"https://lttng.org/docs/v2.12/#doc-liblttng-ust-cyg-profile" rel=
=3D"noreferrer" target=3D"_blank">https://lttng.org/docs/v2.12/#doc-liblttn=
g-ust-cyg-profile</a> <br>
<br>
and this<br>
<a href=3D"https://lttng.org/man/3/lttng-ust-cyg-profile/v2.12/" rel=3D"nor=
eferrer" target=3D"_blank">https://lttng.org/man/3/lttng-ust-cyg-profile/v2=
.12/</a><br>
<br>
&gt; I am using LTTng version Ubuntu: LTTng Stable 2.12 PPA<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - apt-get install lttng-tools<br>
&gt;=C2=A0 =C2=A0 - apt-get install lttng-modules-dkms<br>
&gt;=C2=A0 =C2=A0 - apt-get install liblttng-ust-dev<br>
&gt; <br>
<br>
Looks good.<br>
<br>
&gt; I noticed no kernel modules with substring &quot;ltt&quot; in it.<br>
<br>
Okai so this is where we need much more information. <br>
<br>
First of all, what are the lttng commands used for your experiments? (lttng=
 create, lttng enable-channel, lttng enable-event...) <br>
Please provide a sample script of your experiments. <br>
<br>
Second, you are mostly performing userspace tracing here, lttng-modules ( t=
he<br>
kernel tracer) might not even be needed here unless you also want to do ker=
nel<br>
tracing. <br>
<br>
What do you mean by &quot;there are no log files of the output.&quot;? LTTn=
g produces<br>
traces encoded in CTF (Common Trace Format) that must be read by a reader<b=
r>
(Babeltrace most of the time).<br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000009fead705bed8d52c--

--===============2471159736815172805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2471159736815172805==--
