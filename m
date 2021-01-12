Return-Path: <SRS0=ItRG=GP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA6C433DB
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:54:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17D522CBE
	for <lttng-dev@archiver.kernel.org>; Tue, 12 Jan 2021 18:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17D522CBE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DFfrM2tmvzQ76;
	Tue, 12 Jan 2021 13:54:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610477667;
	bh=AMoiRQ7w19B7f9vOfjoBHJoUJVNj4OhtaCkzGjnFzYs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X+ByQ5GaQsCAEiR54cvxPnO88Wu4PcniMm4NJiR5KH39ZVjOHNM7ST+/KMmq+pqup
	 NDaVklg0TEAwsQCpDlCHrEhLmaJbyDMqLXOo22SlZoyx8GgAXhR0TIa0/LSAbxwuSt
	 9JAem4uZVX7oxdaQIUjPIjXjjNRPrY5q1HxSySC0nSlTE5DOksopJ05pclH9C+k6Gm
	 qlGF5arNxH0U1bA//ykDgX48xH/9QQx3MHJgl1v32yD/p4ktqBUxI7QNe8PHxfEvzS
	 vKmW2z31JiTrutVcYgzhkxdfOWNI7/fEsMNInDjX97Rc/9b7EtLZo8I4W6vX6t/VGO
	 hCfS3Wtt61SEw==
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by lists.lttng.org (Postfix) with ESMTPS id 4DFcz71grQzQL6
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 12:30:11 -0500 (EST)
Received: by mail-lj1-x231.google.com with SMTP id u21so3778962lja.0
 for <lttng-dev@lists.lttng.org>; Tue, 12 Jan 2021 09:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ECckZgP2JOq6e2/Au8DjECllKGwCZV2ooHtPBF7CoE=;
 b=H8vGqo1+SFB6JfjecRk77dcy9mXp11a5CyqppMKEyW6SnPCfBqHqV5vCd9dte1l44d
 Z/X6U2o+AYjffEaJBSSCqO8badn8NTkO/k+BJGhf0lS7CZKp5Avk4UvucqfC5Yjw1yR8
 VkZkqhTCkRKEJyFvr5PhAyjGkXxrHq7dSygxwaDPfGeCM7xPAudI9LNM4Ug8OLcN+bai
 lBsxS9Ph1zh+na+NkVgDmTooyp+NtQb7MhWKzmEjWwSQsmA8A/lpv3GZNGCI4ehB4RAc
 9QC8JPg3WmVswSnIkEHvH/pX1Au18MwiY7tQLcX0KGKnSJQJJmn7L2m+nzIEj03NOOHk
 tOnA==
X-Gm-Message-State: AOAM530SEJaUzeoE+xGsQRApGeCy8Jx4TiwsiQsgGyfwBCX0cSnB9JlZ
 Kspt7sDWikYVeyk4f/W2F+RBTPMorOksBzJVHos3LQ==
X-Google-Smtp-Source: ABdhPJwghhov9FLLWIyLw3Dwlmau0bNOcOSy1n6FTjMcHh9KCGVIE5WqmIcgY2RcMt/GarrczmasyAtfNuWVqTz3InU=
X-Received: by 2002:a2e:810c:: with SMTP id d12mr133613ljg.400.1610472609359; 
 Tue, 12 Jan 2021 09:30:09 -0800 (PST)
MIME-Version: 1.0
References: <CAK7B4KePHyJFCwAczqcqz+05Ts8AVm0Xh9f4hwSBKaVhQLz8cw@mail.gmail.com>
 <977d5fa1-ff33-f99e-5be9-7c53ff6adfc4@efficios.com>
 <CAK7B4KfwwC6UbuBTzJSqTHiyuDxgjAPRryYYq7vLRJSWs=2W0g@mail.gmail.com>
 <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
In-Reply-To: <f13d262c-560a-849e-c3f2-0c0d6e67e27b@efficios.com>
Date: Tue, 12 Jan 2021 11:29:29 -0600
Message-ID: <CAK7B4Kc9bED7q9_6HsCqLT1dhJEjjNY93cspZ7Nb_Ztpn+=ERg@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, Yan Chen <ychen@northwestern.edu>, 
 Xutong Chen <XutongChen2021@u.northwestern.edu>
X-Mailman-Approved-At: Tue, 12 Jan 2021 13:54:25 -0500
Subject: Re: [lttng-dev] LTTng Support for Mount Namespace
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mohammad Kavousi via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mohammad Kavousi <kavousi@u.northwestern.edu>
Content-Type: multipart/mixed; boundary="===============5045673501160328543=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5045673501160328543==
Content-Type: multipart/alternative; boundary="000000000000cd39e005b8b75ffc"

--000000000000cd39e005b8b75ffc
Content-Type: text/plain; charset="UTF-8"

Thanks again for your reply,

To be specific, I did exactly this:

- Install linux source code, then copy the mentioned file to the folder
using: cp /usr/src/linux-headers-5.4.0-59/fs/mount.h /lib/modules/$(uname
-r)/build

- Run sudo dkms autoinstall (I also did reboot)

- Create the session and attempt to add the context

However, I'm getting the same error.

On Tue, Jan 12, 2021 at 9:05 AM Michael Jeanson <mjeanson@efficios.com>
wrote:

> On 2021-01-09 09 h 03, Mohammad Kavousi wrote:
> > Michael,
> >
> > Thank you for your swift response. However, for the first part, I'm not
> > sure what it means by "using" the full kernel source. How would I use it
> > with lttng-modules?
> >
> > As for the quick hack part, I grabbed the kernel source and copied the
> > mount.h onto the folder you mentioned, and it did not help. I don't
> > expect lttng to automatically find that file and use it; also there are
> > no other header files in the package build directory. Could you kindly
> > give us more instructions?
> >
> > Thanks,
> > Mohammad
>
> The lttng modules are shipped in Ubuntu as a dkms package which means
> they are built directly on your machine for each kernel version you
> install. So after adding the required file in your headers you'll need
> to rebuild the modules with dkms and unload / reload them in your
> running kernel or just reboot the machine.
>
> To rebuild all installed dkms modules for the current kernel:
>
>    sudo dkms autoinstall
>

--000000000000cd39e005b8b75ffc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Thanks again for your re=
ply,<div><br></div><div>To be specific, I did exactly this:</div><div><br><=
/div><div>- Install linux source code, then copy the mentioned file to the =
folder using:<font face=3D"monospace">=C2=A0cp /usr/src/linux-headers-5.4.0=
-59/fs/mount.h=C2=A0/lib/modules/$(uname -r)/build</font></div><div><br></d=
iv><div>- Run sudo dkms autoinstall (I also did reboot)</div><div><br></div=
><div>- Create the session and attempt to add the context</div><div><br></d=
iv><div>However, I&#39;m getting the same error.</div></div></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, J=
an 12, 2021 at 9:05 AM Michael Jeanson &lt;<a href=3D"mailto:mjeanson@effic=
ios.com">mjeanson@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 2021-01-09 09 h 03, Mohammad Kavousi wrote=
:<br>
&gt; Michael,<br>
&gt; <br>
&gt; Thank you for your swift response. However, for the first part, I&#39;=
m not <br>
&gt; sure what it means by &quot;using&quot; the full kernel source. How wo=
uld I use it <br>
&gt; with lttng-modules?<br>
&gt; <br>
&gt; As for the quick hack part, I grabbed the kernel source and copied the=
 <br>
&gt; mount.h onto the folder you mentioned, and it did not help. I don&#39;=
t <br>
&gt; expect lttng to automatically find that file and use it; also there ar=
e <br>
&gt; no other header files in the package build directory. Could you kindly=
 <br>
&gt; give us more instructions?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Mohammad<br>
<br>
The lttng modules are shipped in Ubuntu as a dkms package which means <br>
they are built directly on your machine for each kernel version you <br>
install. So after adding the required file in your headers you&#39;ll need =
<br>
to rebuild the modules with dkms and unload / reload them in your <br>
running kernel or just reboot the machine.<br>
<br>
To rebuild all installed dkms modules for the current kernel:<br>
<br>
=C2=A0 =C2=A0sudo dkms autoinstall<br>
</blockquote></div>

--000000000000cd39e005b8b75ffc--

--===============5045673501160328543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5045673501160328543==--
