Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9745FF5136
	for <lttng-dev@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fqx261WWqz20Nr
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1775589824;
	b=bkhhxIBGYv1otAOHzb7ke03Nsz6MKIKhYT4HOjcRL4OZxySafWSfH/bB7tICnWaEzKl1
	 8zrUoO52TZBVDy+02cdCPRIWrJwvUohPBrzyHnROZgHCDPWrXZsB7/TUC11umKPzQxt/Z
	 dumB5MrfpUky05MLzfOY61+0dB4hJuJoFPEBp8jGCpzfRgI/16boHYHVbdAQ5DOezgo5z
	 p7smZ+hCXORUfoQLCEavMKxgkyszswq+fExjQNSTelWEnO217dx48QgOEbT3XymeIeMdy
	 LPtNVOujbbzgciOCUrI47BMhuIuM3BI4rzUBEyUW5CUNYSQ25LyCrWkIHCklUWtWtqA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1775589824;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=B7oB0QO96Kghl1GIDWcZ5aMbx0g4Ys5k4vW+xEKtDNQ=;
	b=Wy206t3Y3lJPIM7/+iGFfrIsyyN9LyUGoV1hZsHtCuMNYxQEnEPPmLagljilRK6empNC
	 FxS1CWd8QYNS99vdYUSCjbGA5Srui/6+mskB6ostaoP9G2f8xLU85K4rcMN+DdP6stlXh
	 /qrGtdJckEmWe24cLN4uax5nPBXSMU9NF8WkVQuh/evQ0E7c8UHwXTYnxMog0AipJkUYq
	 SiFlvu0JnzLvEQpcIcvubxDJ+JBVj3wlZiD7zeJTsWPBlypAu7KfCaj5RAmi2ArZvAj9d
	 qbPu7L5fdtOszxnUqW2Lg5Gyis1DBDB8g9ZbdO+Zqz2fi2DqYkcJNKpSKrzDw6UAG5Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fqx261WWqz20Nr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1775589824;
	bh=8lYTqAV4d6ZA3DsUmTyakz9rLIKwr28AmF+G4AU9u48=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=CNunrTuyAd3Gtf32XFbHJ+o4j8dKEdvqRU4rOiegXBNSAdsC1XYHjFO4rREDzyEku
	 Dbzym8po9lx/eayig0DiSdwMPNNrto/ayj+hxxsK58aMg5FSg/kxN8WWQ2cpqjO79a
	 BxO+bEDOdANNgKLwQ9jqnfEOADcuPYIFXf+MAn1AeyhCS/J9di/Pi0yrHKqKZsiFqw
	 jQATxL6nsOL9DjNiDr4hoyKOe8gUczOcj4DGskUTD3gOUDoz9uXoOlPhK88U85eb1i
	 J8wf+6dFVKDBll4hcRiZzNIj+RnnlPzLwr2f0mPMmzBmaZ9Wc8pefETeNLfL/6Y/lq
	 efdD9Fcwu6SbA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fqx261WWqz20Nr;
	Tue,  7 Apr 2026 15:23:42 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fqqVp32qqz1xWP
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fqqVp32qqz1xWP
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by lists.lttng.org (Postfix) with ESMTPS id 4fqqVp32qqz1xWP
 for <lttng-dev@lists.lttng.org>; Tue,  7 Apr 2026 11:14:42 -0400 (EDT)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1976004fac.2
 for <lttng-dev@lists.lttng.org>; Tue, 07 Apr 2026 08:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574876; cv=none;
 d=google.com; s=arc-20240605;
 b=fyvP4trEISF4oc6YEY+DAYjxI7kLH0rq5r4e2CyftRX2Y3jIfzrdjuzfLQIiGpYPmz
 GoImWeuI8pjDJMgliXYKcK8Qcel+LUVI14rEEKAD6H/y+P6Lk4sjK6eTBFNMTV3wf+UT
 QfERev+IE+rXia6+VdVpM7J/eR75QNCzdhQIr7GXbqvEVCcOOmURlnP2tWDvwTW5gLNl
 0DvzOabAqOdLuVBClGELmpoEAwFGe/v1s9X3lg0bWA57+XcWCokgLnIwTwr6gBzk135J
 yHMYwpbwxN6fi7yIlAGPEhYjdLxz8z6DW1xiRwb0DA1zhMwA/5gO5kOqJFg+GhgiYkCR
 6udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=8lYTqAV4d6ZA3DsUmTyakz9rLIKwr28AmF+G4AU9u48=;
 fh=b8LGmX4snNnnfRaSS45HMRar8lwbZP/izOCcIj6//XE=;
 b=QiaIPQ5GxRFTHmd4HbQKAFyzgUNKjfpswFT7Pa0XY4Nq8uXh8A2nWPhSnSy253aVEw
 35DSHSfr+PaRRrOQ1ELsKIjtX0UTAbCe3NvkeIN0eoZMAmXjUOvvoUj2v/4M70v8a8Lj
 WleH3p+FGT6a16axVp7SWXTzl1Q9ka0ihAzN2IhQ3tN0mwYAjfkF/il34icEbFsN/UjE
 S0b7cgu715MXDLaW4MA0QobkhVN0ZV4spfEaPaxxZKV8xg7Ecblticu5bO7EcnVlVIdi
 dDU+Lxw85vFkECehgMKYJxESo69L3FlsEYK8qD3WVn80RMLseEbtcp60fF6K+jy/T+bH
 tLNA==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574876; x=1776179676;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lYTqAV4d6ZA3DsUmTyakz9rLIKwr28AmF+G4AU9u48=;
 b=sOQ/Rdy5MQa+RlXBM6VBFlvfHVaJ7jtNtX7E8FqT/1bNaRNPYzArufZsDKCUTskyQS
 2rM3EzAKXClSlkvTzDMNV8oJfVzuASHfABywA8gTM1jOzoEgSNb5DzmgDm+yal0JnRHn
 khOnkGVc38clQlzPpSXuoQlFLzRGcCh/AvVRMVdrFM0aRuPfujFrv/I4WgmmoqB0uFT5
 QHaNgOyZ05LktEJPSKNyoT96IZwbwcrT6FV3hdLH88S8N45H5evmL4Bkp8zyTnCBY+B8
 cfFYw1wY4Kp8tQOdqswlfM2qJDn4BtPtuvxIFVM5LLZu9Q8iQvXo4Suf2CBsmoae11Yb
 qWmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7gwl1l3dPMwDNTDsStz1VEIOqW6+kmnFrqyh86GFbx296TOZlaZLse0B1ghWLXs3tTF8+GuqNS8E=@lists.lttng.org
X-Gm-Message-State: AOJu0YznlS9hcLYiqSkEXPsXFqL7126nSDrgtQ4SYW/437kwgk3eOolH
 y33EBW/oD0tLifRiPgPj31kT7ALlybIY1iMFug0Kq8lfHdaz2h+3++6lCNyxzZuRICYpSNT6IdJ
 8VmotQOrzC1gQKGCqyi6HtM+Xjxcd3fU4sdknnS61gg==
X-Gm-Gg: AeBDietyp9tz2Rvd3oHdA6RUe3PcxLMRq+aoI6QyJMmnfljtUXL6EsJ0v7NJ52g9U74
 O8+3TsDwyCNbf6boJIY9Kd88o+v790JORfUr/vj+OrGsIQbaXKD718XsOZww2lHQ83K2vTT7arP
 opK+RIooXSmlVNqb9Kd5LTxqVkwH7QBai55HFN3EZskC3ZqGClU8f/GxahG0t5eJ6rHk0zexXzR
 si2MjkLRq6IyHi32UWHBBagSx6WszpCr1xrkXreVUn4XtE85BHjkc4QRgpsM/cKyYaDhOJXoSCA
 Uuc/FlnZD8W+SHoAQDblBnjtWPJ2h9j+EycKUZ20
X-Received: by 2002:a05:6870:3263:b0:404:1c81:596e with SMTP id
 586e51a60fabf-4230fcb6571mr9855904fac.12.1775574876058; Tue, 07 Apr 2026
 08:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQX81c_1OGMybWoc3axCVZGk58q9aefxpNS2XTny2K8cy_65w@mail.gmail.com>
 <4a6fd540-da30-419e-b311-1fdf17306cef@efficios.com>
In-Reply-To: <4a6fd540-da30-419e-b311-1fdf17306cef@efficios.com>
Date: Tue, 7 Apr 2026 11:14:25 -0400
X-Gm-Features: AQROBzA4ylJ_SkChZ8B6K8HjPHXFO00mbh0HnvTeJC5Q3TQ3njizCdhlnw3NgHA
Message-ID: <CAOQX81e-YGCktrjYwdwDAe_5uRmP5=GaYPBbWm1EiMDnuG0aaA@mail.gmail.com>
Subject: Re: Question about LTTng Kernel Probe Tracking
To: Kienan Stewart <kstewart@efficios.com>
Content-Type: multipart/alternative; boundary="000000000000c289fc064ee03d7e"
X-Mailman-Approved-At: Tue, 07 Apr 2026 15:23:40 -0400
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
From: Amir Najafi Zadeh via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000c289fc064ee03d7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added LTTng dev to BCC to avoid spamming.

Hi Kienan. Thanks for your response. I tried specifying the session name,
but nothing changed.

Here is the output I get after adding the tracker:

Added 1002 to the group ID tracker inclusion set

I don=E2=80=99t think the session name is the issue, because I also specifi=
ed the
session name when starting tracking. This is the session state after
creating it:

$ sudo lttng list lttng-gid-test
Recording session lttng-gid-test: [active]
    Trace output: /tmp/lttng/lttng-gid-test

=3D=3D=3D Domain: Linux kernel =3D=3D=3D

Tracked process attributes
  Process IDs:          none
  Virtual process IDs:  none
  User IDs:             none
  Virtual user IDs:     none
  Group IDs:            1002
  Virtual group IDs:    none

And these are the logs I get:

[11:01:51.222277079] (+0.000004846) dhcp15 ext4_get_inode_loc: {
cpu_id =3D 3 }, { pid =3D 403653, tid =3D 403660, procname =3D
"lttng-consumerd", gid =3D 0, uid =3D 0, vpid =3D 403653, vuid =3D 0, vgid =
=3D 0
}, { ip =3D 0xFFFFFFFFAC804940 }
...

There are many logs like this from systemd, kworker, and processes
belonging to other groups. Note that the GID 1002 that I want to trace
currently has no active subjects.

Do you suggest switching to the recent version of LTTng (current version
2.13.11)?

Best,
Amir

On Tue, Apr 7, 2026 at 10:57=E2=80=AFAM Kienan Stewart <kstewart@efficios.c=
om>
wrote:

> Hi Amir,
>
> On 2026-04-04 21:02, Amir Najafi Zadeh via lttng-dev wrote:
> > Hello all,
> >
> > I hope you are doing well.
> >
> > I have a quick question about LTTng tracking when using kernel probes. =
I
> > mainly use LTTng to trace file system functions in the Linux kernel, an=
d
> > for that I use the LTTng kernel probe feature, which works very well.
> > However, when I tried filtering logs for a specific group ID, I noticed
> > that filters are not supported for kernel probes.
> >
> > Then I attempted to use the tracking feature to trace only a specific
> > GID, but this also did not work. From what I see in my logs, it appears
> > that for kernel probes all events are captured and recorded, regardless
> > of the tracking options.
> >
> > I wanted to know if this is a known limitation, and whether there is an=
y
> > in-progress work or reason why this is not currently supported.
> >
>
> I just tried on the master branch (since I had easy access to it), and
> wasn't able to reproduce a situation where I added the gid tracking and
> had results for a different gid in lttng view.
>
> > For reference, here is my code. I am using LTTng 2.13.11 with kernel
> > 6.8.0-101-generic:
> >
> > ``` #!/bin/sh
> > SESSION_NAME=3D"lttng-gid-test"
> > OUTPUT_DIR=3D"/tmp/lttng/${SESSION_NAME}"
> > GROUP_ID=3D1002
> >
> > # create the lttng session
> > lttng create "$SESSION_NAME" -o "$OUTPUT_DIR"
> >
> > # create the lttng ring buffer channel
> > lttng enable-channel --session=3D"$SESSION_NAME" --kernel channel0 \
> > --subbuf-size=3D16M \
> > --num-subbuf=3D2
> >
> > # add pid, tid, proc, and gid for tracing collection
> > lttng add-context --session=3D"$SESSION_NAME" --channel=3Dchannel0 --ke=
rnel
> > --type pid
> > lttng add-context --session=3D"$SESSION_NAME" --channel=3Dchannel0 --ke=
rnel
> > --type gid
> >
> > # enable the target probe
> > lttng enable-event --session=3D"$SESSION_NAME" --channel=3Dchannel0 --k=
ernel
> > --probe=3Dext4_get_inode_loc ext4_get_inode_loc
> >
> > # disable all tracks # NOTE: untracking doesn't make a difference
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --gid
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --pid
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --vpid
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --uid
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --vuid
> > # lttng untrack --session=3D"$SESSION_NAME" --kernel --all --vgid
> > # only enable gid 1002 track
> > lttng track --kernel --gid=3D1002
> >
>
> Could you check the output of your script after "lttng track --kernel
> --gid=3D1002"?
>
> The rest of your commands specify a session name, but this one does not.
> I wonder if  it's selecting a different default session that the one
> you're expecting?
>
> > # start lttng lttng start $SESSION_NAME
> >
> > ```
> >
> > Thank you for your time and guidance.
> >
> > Best regards,
> > Amir
> >
> > --
> > *Amirhossein Najafizadeh*
> > *PhD Student, Computer Science Department, Stony Brook University, N.Y.
> > File systems and Storage Lab (FSL)
> >
> > *
> > najafizadeh21@gmail.com <mailto:najafizadeh21@gmail.com>
> > https://amirhnajafiz.github.io/ <https://amirhnajafiz.github.io/>
>
>

--000000000000c289fc064ee03d7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-isSelectedEnd">Added <span class=3D"gmai=
l-hover:entity-accent entity-underline gmail-inline gmail-cursor-pointer gm=
ail-align-baseline"><span class=3D"gmail-whitespace-normal">LTTng</span></s=
pan> dev to <span class=3D"gmail-hover:entity-accent entity-underline gmail=
-inline gmail-cursor-pointer gmail-align-baseline"><span class=3D"gmail-whi=
tespace-normal">BCC</span></span> to avoid spamming.<br><br>Hi Kienan. Than=
ks for your response. I tried specifying the session name, but nothing chan=
ged.</p><p class=3D"gmail-isSelectedEnd">Here is the output I get after add=
ing the tracker:</p><pre dir=3D"ltr"><code dir=3D"ltr">Added 1002 to the gr=
oup ID tracker inclusion set</code></pre><p class=3D"gmail-isSelectedEnd">I=
 don=E2=80=99t think the session name is the issue, because I also specifie=
d the session name when starting tracking. This is the session state after =
creating it:</p><pre dir=3D"ltr"><code dir=3D"ltr">$ sudo lttng list lttng-=
gid-test
Recording session lttng-gid-test: <span class=3D"gmail-text-token-text-prim=
ary gmail-cursor-text gmail-rounded-sm">[active]</span>
    Trace output: /tmp/lttng/lttng-gid-test

=3D=3D=3D Domain: Linux kernel =3D=3D=3D

Tracked process attributes
  Process IDs:          none
  Virtual process IDs:  none
  User IDs:             none
  Virtual user IDs:     none
  Group IDs:            1002
  Virtual group IDs:    none</code></pre><p class=3D"gmail-isSelectedEnd">A=
nd these are the logs I get:</p><pre dir=3D"ltr"><code dir=3D"ltr"><span cl=
ass=3D"gmail-text-token-text-primary gmail-cursor-text gmail-rounded-sm">[1=
1:01:51.222277079]</span> (+0.000004846) dhcp15 ext4_get_inode_loc: { cpu_i=
d =3D 3 }, { pid =3D 403653, tid =3D 403660, procname =3D &quot;lttng-consu=
merd&quot;, gid =3D 0, uid =3D 0, vpid =3D 403653, vuid =3D 0, vgid =3D 0 }=
, { ip =3D 0xFFFFFFFFAC804940 }
...</code></pre><p>There are many logs like this from systemd, kworker, and=
 processes belonging to other groups. Note that the GID 1002 that I want to=
 trace currently has no active subjects.<br><br>Do you suggest switching to=
 the recent version of LTTng (current version 2.13.11)?=C2=A0<br><br>Best,<=
br>Amir</p></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 7, 2026 at 10:57=E2=80=AFAM Ki=
enan Stewart &lt;<a href=3D"mailto:kstewart@efficios.com">kstewart@efficios=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi Amir,<br>
<br>
On 2026-04-04 21:02, Amir Najafi Zadeh via lttng-dev wrote:<br>
&gt; Hello all,<br>
&gt; <br>
&gt; I hope you are doing well.<br>
&gt; <br>
&gt; I have a quick question about LTTng tracking when using kernel probes.=
 I <br>
&gt; mainly use LTTng to trace file system functions in the Linux kernel, a=
nd <br>
&gt; for that I use the LTTng kernel probe feature, which works very well. =
<br>
&gt; However, when I tried filtering logs for a specific group ID, I notice=
d <br>
&gt; that filters are not supported for kernel probes.<br>
&gt; <br>
&gt; Then I attempted to use the tracking feature to trace only a specific =
<br>
&gt; GID, but this also did not work. From what I see in my logs, it appear=
s <br>
&gt; that for kernel probes all events are captured and recorded, regardles=
s <br>
&gt; of the tracking options.<br>
&gt; <br>
&gt; I wanted to know if this is a known limitation, and whether there is a=
ny <br>
&gt; in-progress work or reason why this is not currently supported.<br>
&gt; <br>
<br>
I just tried on the master branch (since I had easy access to it), and <br>
wasn&#39;t able to reproduce a situation where I added the gid tracking and=
 <br>
had results for a different gid in lttng view.<br>
<br>
&gt; For reference, here is my code. I am using LTTng 2.13.11 with kernel <=
br>
&gt; 6.8.0-101-generic:<br>
&gt; <br>
&gt; ``` #!/bin/sh<br>
&gt; SESSION_NAME=3D&quot;lttng-gid-test&quot;<br>
&gt; OUTPUT_DIR=3D&quot;/tmp/lttng/${SESSION_NAME}&quot;<br>
&gt; GROUP_ID=3D1002<br>
&gt; <br>
&gt; # create the lttng session<br>
&gt; lttng create &quot;$SESSION_NAME&quot; -o &quot;$OUTPUT_DIR&quot;<br>
&gt; <br>
&gt; # create the lttng ring buffer channel<br>
&gt; lttng enable-channel --session=3D&quot;$SESSION_NAME&quot; --kernel ch=
annel0 \<br>
&gt; --subbuf-size=3D16M \<br>
&gt; --num-subbuf=3D2<br>
&gt; <br>
&gt; # add pid, tid, proc, and gid for tracing collection<br>
&gt; lttng add-context --session=3D&quot;$SESSION_NAME&quot; --channel=3Dch=
annel0 --kernel <br>
&gt; --type pid<br>
&gt; lttng add-context --session=3D&quot;$SESSION_NAME&quot; --channel=3Dch=
annel0 --kernel <br>
&gt; --type gid<br>
&gt; <br>
&gt; # enable the target probe<br>
&gt; lttng enable-event --session=3D&quot;$SESSION_NAME&quot; --channel=3Dc=
hannel0 --kernel <br>
&gt; --probe=3Dext4_get_inode_loc ext4_get_inode_loc<br>
&gt; <br>
&gt; # disable all tracks # NOTE: untracking doesn&#39;t make a difference<=
br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-gid<br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-pid<br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-vpid<br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-uid<br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-vuid<br>
&gt; # lttng untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all -=
-vgid<br>
&gt; # only enable gid 1002 track<br>
&gt; lttng track --kernel --gid=3D1002<br>
&gt; <br>
<br>
Could you check the output of your script after &quot;lttng track --kernel =
<br>
--gid=3D1002&quot;?<br>
<br>
The rest of your commands specify a session name, but this one does not. <b=
r>
I wonder if=C2=A0 it&#39;s selecting a different default session that the o=
ne <br>
you&#39;re expecting?<br>
<br>
&gt; # start lttng lttng start $SESSION_NAME<br>
&gt; <br>
&gt; ```<br>
&gt; <br>
&gt; Thank you for your time and guidance.<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Amir<br>
&gt; <br>
&gt; -- <br>
&gt; *Amirhossein Najafizadeh*<br>
&gt; *PhD Student, Computer Science Department, Stony Brook University, N.Y=
.<br>
&gt; File systems and Storage Lab (FSL)<br>
&gt; <br>
&gt; *<br>
&gt; <a href=3D"mailto:najafizadeh21@gmail.com" target=3D"_blank">najafizad=
eh21@gmail.com</a> &lt;mailto:<a href=3D"mailto:najafizadeh21@gmail.com" ta=
rget=3D"_blank">najafizadeh21@gmail.com</a>&gt;<br>
&gt; <a href=3D"https://amirhnajafiz.github.io/" rel=3D"noreferrer" target=
=3D"_blank">https://amirhnajafiz.github.io/</a> &lt;<a href=3D"https://amir=
hnajafiz.github.io/" rel=3D"noreferrer" target=3D"_blank">https://amirhnaja=
fiz.github.io/</a>&gt;<br>
<br>
</blockquote></div>

--000000000000c289fc064ee03d7e--
