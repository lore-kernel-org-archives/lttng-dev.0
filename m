Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5518CCA1005
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Sep 2025 21:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGfWt0THcz1Cgr
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1756849738;
	b=KxEtj2SeJufZ8Sk9Lg3ZObTyoI0ISrm+CblGNmIn5Qp1u6l6VXblJASwYMWvFiZcIHcp
	 0Z8FC/JGjExaNnDaQ0hgVvgRORYHpVqmPIuED9OGPDqexbqe20t2ht3GphRmfOzbWmJYC
	 mmeoHczbeAG4zDUXOL2d24aP+X1HbjrjKb7pwMbRJoJK9iYKo4ysltkEs5ZlsD0FhpDTV
	 yzVIxiK9Hw1xvuPw8zc3DHxF1Jm7IDM+MWOx8SUCNzjpuX6BugsC/31jN2YhWKdkkmMMe
	 OsJ4hBsE3/k1Q4B/ESjMCcLoMvuVni70ONmfLWAH4iXzdTxQplCc9PfJ1FYGyQFIWpg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1756849738;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=sNYiGoYsLFsg9lgLuZur1AI+atLhFnTl0dTNxgh9Ce4=;
	b=H2ZUE2Iw/7VAmuZWygeEd1pjM4I8b/Ya1AWyPkx2BthOnkOzv38AL1Bj2BARWLZ7jcDD
	 8mv8mRB24Eun3G14v/XFYdSPKLURMMKW+F2AB5OQ9GTV5DF4T82OoWXWTA/SVUZbbun5v
	 r4MDtuCCgQvQZIt4WYiHMQeYzSe3CZ7I8Kgn1t/BpBdUwYDbLR/sZcH4EUd6KcDCe7zOB
	 GtNB95YBr+3p+dXHvc/G/IEhjzuzdaQDD/1dlvfenLsnp8eeck1EWHpoPFjPw4vavgyg9
	 0f3ZYF97Sg4bA400Q3NIA+utX0EaTS4ZUlMo1Yjr77cqcKO0yGYFNoVwqU/1iHtbtiQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGfWt0THcz1Cgr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1756849738;
	bh=sNYiGoYsLFsg9lgLuZur1AI+atLhFnTl0dTNxgh9Ce4=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ftT31hgjPlETwSCIqvzr0twXwPnFJ7NjmBnlJx1MAiNGJaJyAgFLrFHCKF0kHccSN
	 K1ovN4zSlr5gHXQH3ZVR0zVv3h6tmOb6v9SJR5m+xlJ14JpbLAsV3c42MSNiVKTDPT
	 i+agAsEGMyt80oDVfXX/W8SjEW99JR9zIwpRr/ckRmfGBZmGXVhPnAtfn6uqNiYPsJ
	 8r2jOEISjL/5UOsfeMwG3KUaCBjxElrU2KDox2h95XXcewaZQ9XL7NNpujf+f1LWgE
	 kNjBvvi+ZZHbl9hKEBWBpiZWLKQ0hi13pdk0M2vbx7ZpNUHBeBzvSJ55esWYoVwvck
	 lCmY0DrQz5kbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4cGfWt0THcz1Cgr;
	Tue,  2 Sep 2025 17:48:58 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4cGfWr4PnFz1Cgc
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4cGfWr4PnFz1Cgc
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by lists.lttng.org (Postfix) with ESMTPS id 4cGfWr4PnFz1Cgc
 for <lttng-dev@lists.lttng.org>; Tue,  2 Sep 2025 17:48:56 -0400 (EDT)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61cc281171cso10056287a12.0
 for <lttng-dev@lists.lttng.org>; Tue, 02 Sep 2025 14:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756849735; x=1757454535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNYiGoYsLFsg9lgLuZur1AI+atLhFnTl0dTNxgh9Ce4=;
 b=A/GDj1XHrhihd64eAkA/Q/I+O10poslCJq0438T9FHnZRbg1Bfc/bx+z+h3xpx7mqM
 65Aw+HR2HX6CVaFfMeCq5Z1pedX6Sze8ysf4F2G33tDMmB2uS2cPmOBltmCa7czdiA+P
 FW5I6tVTK3u1e3o0dG5UPc5jOjTvWW0lIkEdTNtRL4MoP9IgzhBUNXeRvy2N/RZM43e5
 IiGwh6/DE7AiBUi3eC4LoaYniinqk11Q/+Lp8zK7YeMDPWDJ+ZkGSK0tMEQtbx+m8YOu
 k5H447NiKgd5dJ36XB1jg7Mfhc94vsXYTKxMRhsbTBgez5io8f8cS0hRvLM2YvwiIffx
 UqbQ==
X-Gm-Message-State: AOJu0YwjWMKMmJXrtuJFGZeUxrvluTaQpB69BC2bBzeZnARyOu0RVxAu
 Tx/zbDbl+kPM9oK6tB74Us9rd8uiz3HZYqbEXnx8os7uN6/4mTX4dFnU/I2XI62b62Xt8zMWmeM
 LBZoYxCj9i1HH3CnP1dUVs5mtQW1vPhLagwma
X-Gm-Gg: ASbGncuIdHotzb/jn34BYgjfWkWC7wWevU9T7zLnkYUmMEbJPqY3ZjYzFEZg0QGgM3Z
 mf0EHWW5sYhCeqkmi/3MsG9mD5lxicchBLpMPIvFyCNrDQn+IOtxttPw5SnpeEjz6f49LYbgEzA
 SCYj+IRyFj3yoJXn45NEEw/jKkpCdsjPc+38P6ZB4Tg0R2W9UGcGSSUDsuYzQYvGaBfFqz5JsRI
 2TzwOz+
X-Google-Smtp-Source: AGHT+IEMZHRSIza/JiJRpGCmO7GF1F5HvgQPa9uURNgnqhZ/3hLNtpTcDbnvv4MI36pw1T1YdbnTlPYR8ij5oV90j+s=
X-Received: by 2002:a05:6402:35cb:b0:61d:e5a2:ea5d with SMTP id
 4fb4d7f45d1cf-61de5a2ec2dmr9291716a12.25.1756849734866; Tue, 02 Sep 2025
 14:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGpciq6Cb6+hqsfn+_zPk+MqCg+b0M_Gc3jVxVvnEGcE8rdLw@mail.gmail.com>
 <CAKGpciqHpGqGJChLa8p4P4Xv7EyUPMxULHxeknOTyie8kHH6hg@mail.gmail.com>
 <3c49eadb-f310-46b2-984d-58a0c193cde9@efficios.com>
 <CAKGpcipt=fWJi9Y497C3vq03CXmPY6rXQqs8ZP9nDoTGdRKnAA@mail.gmail.com>
 <CAKGpcipfyp3Ds4J0OH96Mu4zVhCLJg8g6tqEnfcRscZ1T8EmVA@mail.gmail.com>
 <2f0dc1b4-3fcb-453c-aa42-4a1f85623300@paulmck-laptop>
 <CAKGpciq+ixOVGN7TXYaF336ZEL_mOejzic5BvaKbexwwn_aqOQ@mail.gmail.com>
 <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
In-Reply-To: <BD1A29BD-2AD2-4092-B1A2-DFEFAE77AAEE@sury.org>
Date: Tue, 2 Sep 2025 23:48:43 +0200
X-Gm-Features: Ac12FXyM92TbbbfG6FQmTo6gqMIEryaqpPfyfS4xlEelolBrgIwted0GPqLjJsI
Message-ID: <CAKGpcip6w2nVQ+vbtfFH1296xTi5HYX+68J8okecChsihejDQA@mail.gmail.com>
Subject: Re: URCU feature request?
To: =?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Cc: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="0000000000005eda15063dd87442"
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
From: Thobias Knudsen via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Thobias Knudsen <thobknu@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000005eda15063dd87442
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes but all read/write operations doesn't have the syntax of a function as
you used in the example here i.e. use(...). When it is a function you can
easily just change the implementation to check if it is called inside a
read section. Some reads and writes are usually done by this syntax (a =3D =
b)
and '=3D' cannot be overridden.

BTW just saying that what we're talking about now is not the original
topic, but if someone has an elegant solution to this that would be nice!

Thanks
Thobias

tir. 2. sep. 2025 kl. 23:34 skrev Ond=C5=99ej Sur=C3=BD <ondrej@sury.org>:

> If I understand you correctly, you can do something like this:
>
> #undef rcu_read_lock
> #define rcu_read_lock() urcu_memb_read_lock(); {
>
> #undef rcu_read_unlock
> #define rcu_read_lock() } urcu_memb_read_unlock();
>
> (replace memb with your RCU variant of course)
>
> and make your code declare all the RCU protected pointers inside the RCU
> critical section, e.g.
>
> rcu_read_lock();
> my_pointer *foo =3D rcu_dereference(...);
>
> use(foo); /* valid */
>
> rcu_read_unlock();
>
>
> use(foo); /* invalid and caught by the compiler */
>
> Ondrej
> --
> Ond=C5=99ej Sur=C3=BD (He/Him)
> ondrej@sury.org
>
> > On 2. 9. 2025, at 23:06, Thobias Knudsen via lttng-dev <
> lttng-dev@lists.lttng.org> wrote:
> >
> > Yes, that is what I'm worried about. For my case when using URCU that i=
s
> my biggest concern, as the debug macro "library" I made checks everything
> else, if I haven't overlooked anything.
> >
>
>

--0000000000005eda15063dd87442
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes but all read/write operations doesn&#39;t=C2=A0have th=
e syntax of a function as you used in the example here i.e. use(...). When =
it is a function you can easily just change the implementation to check if =
it is called inside a read section. Some reads and writes are usually done =
by this syntax (a =3D b) and &#39;=3D&#39; cannot be overridden.<div><br></=
div><div>BTW just saying that what we&#39;re talking about now is not the o=
riginal topic, but if someone has an elegant solution to this that would be=
 nice!<br><div><br></div><div>Thanks</div><div>Thobias</div></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">tir. 2. sep. 2025 kl. 23:34 skrev Ond=C5=99ej Sur=C3=BD &lt;<a=
 href=3D"mailto:ondrej@sury.org">ondrej@sury.org</a>&gt;:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">If I understand you correctly, yo=
u can do something like this:<br>
<br>
#undef rcu_read_lock<br>
#define rcu_read_lock() urcu_memb_read_lock(); {<br>
<br>
#undef rcu_read_unlock<br>
#define rcu_read_lock() } urcu_memb_read_unlock();<br>
<br>
(replace memb with your RCU variant of course)<br>
<br>
and make your code declare all the RCU protected pointers inside the RCU cr=
itical section, e.g.<br>
<br>
rcu_read_lock();<br>
my_pointer *foo =3D rcu_dereference(...);<br>
<br>
use(foo); /* valid */<br>
<br>
rcu_read_unlock();<br>
<br>
<br>
use(foo); /* invalid and caught by the compiler */<br>
<br>
Ondrej<br>
--<br>
Ond=C5=99ej Sur=C3=BD (He/Him)<br>
<a href=3D"mailto:ondrej@sury.org" target=3D"_blank">ondrej@sury.org</a><br=
>
<br>
&gt; On 2. 9. 2025, at 23:06, Thobias Knudsen via lttng-dev &lt;<a href=3D"=
mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.o=
rg</a>&gt; wrote:<br>
&gt; <br>
&gt; Yes, that is what I&#39;m worried about. For my case when using URCU t=
hat is my biggest concern, as the debug macro &quot;library&quot; I made ch=
ecks everything else, if I haven&#39;t overlooked anything.<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000005eda15063dd87442--
